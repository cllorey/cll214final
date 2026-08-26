source("R/moving-average.R")
library(tidyverse)

bq1_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv")
bq2_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv")
bq3_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv")
prm_data <- read_csv("data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv")

bq1 <- bq1_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1996-12-31")

bq2 <- bq2_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1996-12-31")

bq3 <- bq3_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1996-12-31")

prm <- prm_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1996-12-31")

bq1_result <- moving_average(site_data = bq1)

bq2_result <- moving_average(site_data = bq2)

bq3_result <- moving_average(site_data = bq3)

prm_result <- moving_average(site_data = prm)

fig3 <- bind_rows(bq1_result, bq2_result, bq3_result, prm_result)

fig3_long <- fig3 |> 
  pivot_longer(
    cols = "no3n_mgl":"nh4n_mgl",
    names_to = "Nutrient",
    values_to = "Concentration"
  )

ggplot(
    data = fig3_long,
    mapping = aes(
        x = window_start,
        y = Concentration,
        color = Sample_ID
    )
) + 
  geom_line() +
  facet_wrap(~Nutrient, scales = "free", ncol = 1) +
  scale_x_date(name = "Years")





# Old spaghetti below this line ------------------------------------------



bq1 <- bq1_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1996-12-31")

bq1_smoothed <- tibble(
    window_start = seq(
        bq1$Sample_Date[1],
        bq1$Sample_Date[nrow(bq1)],
        by = "9 weeks"
    ),
    Sample_ID = "BQ1",
    "NO3-N" = NA, 
    "K" = NA, 
    "Mg" = NA, 
    "Ca" = NA, 
    "NH4-N" = NA
)
bq1_smoothed

for (i in 1:nrow(bq1_smoothed)) {
  w1 <- bq1_smoothed$window_start[i]
  w2 <- w1 + weeks(9)
  print(w1)
  print(w2)
  
  no3n <- bq1$"NO3-N"[bq1$Sample_Date >= w1 & bq1$Sample_Date < w2]
  k <- bq1$K[bq1$Sample_Date >= w1 & bq1$Sample_Date < w2]
  mg <- bq1$Mg[bq1$Sample_Date >= w1 & bq1$Sample_Date < w2]
  ca <- bq1$Ca[bq1$Sample_Date >= w1 & bq1$Sample_Date < w2]
  nh4n <- bq1$"NH4-N"[bq1$Sample_Date >= w1 & bq1$Sample_Date < w2]
  print(no3n)
  print(k)
  print(mg)
  print(ca)
  print(nh4n)
  
  bq1_smoothed$"NO3-N"[i] <- mean(no3n, na.rm = TRUE)
  bq1_smoothed$K[i] <- mean(k, na.rm = TRUE)
  bq1_smoothed$Mg[i] <- mean(mg, na.rm = TRUE)
  bq1_smoothed$Ca[i] <- mean(ca, na.rm = TRUE)
  bq1_smoothed$"NH4-N"[i] <- mean(nh4n, na.rm = TRUE)
}

bq1_smoothed
view(bq1_smoothed)

bq1_smoothed_long <- bq1_smoothed |> 
  pivot_longer(
    cols = "NO3-N":"NH4-N",
    names_to = "Nutrient",
    values_to = "Concentration"
  )
bq1_smoothed_long

ggplot(
    data = bq1_smoothed_long,
    mapping = aes(
        x = window_start,
        y = Concentration
    )
) + 
  geom_line() +
  facet_wrap(~Nutrient, scales = "free") +
  scale_x_date(name = "Years")

# bq2 workspace

bq2 <- bq2_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1996-12-31")

bq2_smoothed <- tibble(
    window_start = seq(
        bq2$Sample_Date[1],
        bq2$Sample_Date[nrow(bq2)],
        by = "9 weeks"
    ),
    Sample_ID = "BQ2",
    "NO3-N" = NA, 
    "K" = NA, 
    "Mg" = NA, 
    "Ca" = NA, 
    "NH4-N" = NA
)
bq2_smoothed

for (i in 1:nrow(bq2_smoothed)) {
  w1 <- bq2_smoothed$window_start[i]
  w2 <- w1 + weeks(9)
  print(w1)
  print(w2)
  
  no3n <- bq2$"NO3-N"[bq2$Sample_Date >= w1 & bq2$Sample_Date < w2]
  k <- bq2$K[bq2$Sample_Date >= w1 & bq2$Sample_Date < w2]
  mg <- bq2$Mg[bq2$Sample_Date >= w1 & bq2$Sample_Date < w2]
  ca <- bq2$Ca[bq2$Sample_Date >= w1 & bq2$Sample_Date < w2]
  nh4n <- bq2$"NH4-N"[bq2$Sample_Date >= w1 & bq2$Sample_Date < w2]
  print(no3n)
  print(k)
  print(mg)
  print(ca)
  print(nh4n)
  
  bq2_smoothed$"NO3-N"[i] <- mean(no3n, na.rm = TRUE)
  bq2_smoothed$K[i] <- mean(k, na.rm = TRUE)
  bq2_smoothed$Mg[i] <- mean(mg, na.rm = TRUE)
  bq2_smoothed$Ca[i] <- mean(ca, na.rm = TRUE)
  bq2_smoothed$"NH4-N"[i] <- mean(nh4n, na.rm = TRUE)
}

bq2_smoothed
view(bq2_smoothed)

bq2_smoothed_long <- bq2_smoothed |> 
  pivot_longer(
    cols = "NO3-N":"NH4-N",
    names_to = "Nutrient",
    values_to = "Concentration"
  )
bq2_smoothed_long

# bq3 workspace

bq3 <- bq3_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1996-12-31")

bq3_smoothed <- tibble(
    window_start = seq(
        bq3$Sample_Date[1],
        bq3$Sample_Date[nrow(bq3)],
        by = "9 weeks"
    ),
    Sample_ID = "BQ3",
    "NO3-N" = NA, 
    "K" = NA, 
    "Mg" = NA, 
    "Ca" = NA, 
    "NH4-N" = NA
)
bq3_smoothed

for (i in 1:nrow(bq3_smoothed)) {
  w1 <- bq3_smoothed$window_start[i]
  w2 <- w1 + weeks(9)
  print(w1)
  print(w2)
  
  no3n <- bq3$"NO3-N"[bq3$Sample_Date >= w1 & bq3$Sample_Date < w2]
  k <- bq3$K[bq3$Sample_Date >= w1 & bq3$Sample_Date < w2]
  mg <- bq3$Mg[bq3$Sample_Date >= w1 & bq3$Sample_Date < w2]
  ca <- bq3$Ca[bq3$Sample_Date >= w1 & bq3$Sample_Date < w2]
  nh4n <- bq3$"NH4-N"[bq3$Sample_Date >= w1 & bq3$Sample_Date < w2]
  print(no3n)
  print(k)
  print(mg)
  print(ca)
  print(nh4n)
  
  bq3_smoothed$"NO3-N"[i] <- mean(no3n, na.rm = TRUE)
  bq3_smoothed$K[i] <- mean(k, na.rm = TRUE)
  bq3_smoothed$Mg[i] <- mean(mg, na.rm = TRUE)
  bq3_smoothed$Ca[i] <- mean(ca, na.rm = TRUE)
  bq3_smoothed$"NH4-N"[i] <- mean(nh4n, na.rm = TRUE)
}

bq3_smoothed
view(bq3_smoothed)

bq3_smoothed_long <- bq3_smoothed |> 
  pivot_longer(
    cols = "NO3-N":"NH4-N",
    names_to = "Nutrient",
    values_to = "Concentration"
  )
bq3_smoothed_long

# PRM workspace

prm <- prm_data |> 
  filter(Sample_Date >= "1988-01-01" & Sample_Date <= "1996-12-31")

prm_smoothed <- tibble(
    window_start = seq(
        prm$Sample_Date[1],
        prm$Sample_Date[nrow(prm)],
        by = "9 weeks"
    ),
    Sample_ID = "PRM",
    "NO3-N" = NA, 
    "K" = NA, 
    "Mg" = NA, 
    "Ca" = NA, 
    "NH4-N" = NA
)
prm_smoothed

for (i in 1:nrow(prm_smoothed)) {
  w1 <- prm_smoothed$window_start[i]
  w2 <- w1 + weeks(9)
  print(w1)
  print(w2)
  
  no3n <- prm$"NO3-N"[prm$Sample_Date >= w1 & prm$Sample_Date < w2]
  k <- prm$K[prm$Sample_Date >= w1 & prm$Sample_Date < w2]
  mg <- prm$Mg[prm$Sample_Date >= w1 & prm$Sample_Date < w2]
  ca <- prm$Ca[prm$Sample_Date >= w1 & prm$Sample_Date < w2]
  nh4n <- prm$"NH4-N"[prm$Sample_Date >= w1 & prm$Sample_Date < w2]
  print(no3n)
  print(k)
  print(mg)
  print(ca)
  print(nh4n)
  
  prm_smoothed$"NO3-N"[i] <- mean(no3n, na.rm = TRUE)
  prm_smoothed$K[i] <- mean(k, na.rm = TRUE)
  prm_smoothed$Mg[i] <- mean(mg, na.rm = TRUE)
  prm_smoothed$Ca[i] <- mean(ca, na.rm = TRUE)
  prm_smoothed$"NH4-N"[i] <- mean(nh4n, na.rm = TRUE)
}

prm_smoothed
view(prm_smoothed)

prm_smoothed_long <- prm_smoothed |> 
  pivot_longer(
    cols = "NO3-N":"NH4-N",
    names_to = "Nutrient",
    values_to = "Concentration"
  )
prm_smoothed_long

## Bind & plot - bind the rows using something like: 
# fig3_raw <- bind_rows(bq1_data, bq2_data, bq3_data, prm_data)

fig3 <- bind_rows(bq1_smoothed_long, bq2_smoothed_long, bq3_smoothed_long, prm_smoothed_long)
fig3
view(fig3)

ggplot(
    data = fig3,
    mapping = aes(
        x = window_start,
        y = Concentration,
        color = Sample_ID
    )
) + 
  geom_line() +
  facet_wrap(~Nutrient, scales = "free", ncol = 1) +
  scale_x_date(name = "Years")
