source("R/moving-average.R")
library(tidyverse)

# Load the data
bq1_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv")
bq2_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv")
bq3_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv")
prm_data <- read_csv("data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv")

# Filter the data to include relevant time frames and site names 
bq1 <- bq1_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-06-30") |> 
  mutate(Site = "BQ1")

bq2 <- bq2_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-06-30") |> 
  mutate(Site = "BQ2")

bq3 <- bq3_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-06-30") |> 
  mutate(Site = "BQ3")

prm <- prm_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1994-06-30")|> 
  mutate(Site = "PRM")

# Use the stored function to calculate the moving average for each site 
bq1_result <- moving_average(site_data = bq1)

bq2_result <- moving_average(site_data = bq2)

bq3_result <- moving_average(site_data = bq3)

prm_result <- moving_average(site_data = prm)

# Combine the moving average results into one dataframe
fig3 <- bind_rows(bq1_result, bq2_result, bq3_result, prm_result)

# Prepare the combined dataframe for plotting 
fig3_long <- fig3 |> 
  pivot_longer(
    cols = "no3n_ugL":"nh4n_ugL",
    names_to = "Nutrient",
    values_to = "Concentration"
  )

# Plot the data
ggplot(
    data = fig3_long,
    mapping = aes(
        x = window_start,
        y = Concentration,
        linetype = Site
    )
) + 
  geom_line() +
  geom_vline(xintercept = ymd("1989-09-18")) +
  theme_bw() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  ) +
  theme(legend.title = element_blank()) +
  theme(
    legend.position = "inside",
    legend.position.inside = c(.9, .25),
    legend.justification = c("right", "bottom")) +
  facet_grid(vars(Nutrient), scales = "free_y", switch = "y") + 
  theme(strip.placement = "outside") +
  scale_x_date(name = "Years", sec.axis = dup_axis())
