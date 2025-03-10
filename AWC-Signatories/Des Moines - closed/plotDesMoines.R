library(tidyverse)
library(ggplot2)
library(plotly)

## Sequential complete mo/yr index for date plotting

index <- data.frame(yr = sort(rep(2019:2023, 12)),
                    mo = rep(1:12, 5)) %>%
  mutate(mon.yr = paste0(month.abb[mo], ".", yr),
         index.date = lubridate::ymd(paste0(yr, "-", mo, "-01")
         ))

start_mo <- 1

yrs <- as.numeric(lubridate::ymd(
  paste0(seq(min(index$yr), max(index$yr), 1), 
         "-", start_mo, "-01")))

# Key dates

date.rollback = as.Date("2024-06-05") #90 days after end of session, 3/7
date.reform = as.Date("2021-07-25")
date.start = as.Date("2019-01-01")
today = Sys.Date()


# Data frame for plotting time series

df_by_month <- desmoines.inci %>% group_by(yr, mo) %>%
  count() %>%
  left_join(index, ., by = c("yr", "mo")) %>%
  mutate(count = as.numeric(tidyr::replace_na(n, 0)),
         numdate = as.numeric(index.date)
         )

# Set up plot

p <- ggplot(df_by_month, 
            aes(x = numdate, y = count)
       )  +
  
  # points - not used
  # geom_point(aes(fill = factor(yr),
  #                text = paste0(mon.yr, ": ", count)),
  #            size=1.5, shape=21, stroke=0.25) +
  
  geom_bar(aes(fill = factor(yr), text = paste0(mon.yr, ": ", count)),
           alpha=0.5, color="grey",
           stat="identity"
  ) +
  scale_fill_brewer(palette="Spectral") +
             
  geom_smooth(linetype="dot", linewidth=.5) +
  
  # year boundaries
  geom_vline(xintercept = yrs, col="white", alpha=.5) +
  
  # reform date
  geom_vline(xintercept = date.reform, col="darkgrey", alpha=.5) +
  annotate("text", x=(as.numeric(date.reform)+150), y=max(df_by_month$count), 
           label="Post Reform",
           size=3) +
  annotate("text", x=(as.numeric(date.reform)-150), y=max(df_by_month$count), 
           label="Pre Reform",
           size=3) +
  
  geom_hline(yintercept = 0, col="grey") +
  
  labs(title = paste("Monthly pursuits: DesMoines", min(index$yr), "-", max(index$yr)),
       x = "Month.Year",
       y = "Number of pursuits",
       #caption = paste("DesMoines", min(index$yr), "-", max(index$yr)),
       fill = "Year") +
  
  scale_x_continuous(
    breaks = df_by_month$index.date[seq(1, nrow(df_by_month), 6)],
    label = df_by_month$mon.yr[seq(1, nrow(df_by_month), 6)]
  )  +
  
  scale_y_continuous(limits = c(-0.5, NA), breaks = 0:max(df_by_month$count)) +
  
  theme(axis.text.x = element_text(size=7, angle = 45, vjust = 0.5)) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Create plot

ggplotly(p, tooltip = "text")
