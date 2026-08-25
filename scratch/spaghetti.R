library(tidyverse)

bq1_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca1-Bisley.csv")
glimpse(bq1_data)
bq2_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca2-Bisley.csv")
glimpse(bq2_data)
bq3_data <- read_csv("data/knb-lter-luq.20.4923064/QuebradaCuenca3-Bisley.csv")
glimpse(bq3_data)
prm_data <- read_csv("data/knb-lter-luq.20.4923064/RioMameyesPuenteRoto.csv")
glimpse(prm_data)

fig3_raw <- bind_rows(bq1_data, bq2_data, bq3_data, prm_data)
view(fig3_raw)

fig_3_ions <- fig3_raw |> 
  select("Sample_ID", "Sample_Date", "NO3-N", "K", "Mg", "Ca", "NH4-N")

view(fig_3_ions)



fig_3_long <- fig_3_ions |> 
  pivot_longer(
    cols = "NO3-N":"NH4-N",
    names_to = "Nutrient",
    values_to = "Concentration"
  )

fig_3_long
view(fig_3_long)

ggplot(
    data = fig_3_long,
    mapping = aes(
        x = Sample_Date,
        y = Concentration,
        color = Sample_ID
    )
) + 
  geom_line() +
  facet_wrap(~Nutrient, scales = "free")



# moving average attempt  ------------------------------------------------

fig_3_ions

fig_3_smooth <- tibble(
    window_start = seq(fig_3_ions$Sample_Date[1],
        fig_3_ions$Sample_Date[nrow(fig_3_ions)],
        by = "9 weeks"
    ),
    "NO3-N" = NA, 
    "K" = NA, 
    "Mg" = NA, 
    "Ca" = NA, 
    "NH4-N" = NA
)

fig_3_smooth


# comments from day 10 moving average -------------------------------------------

# qs_smoothed <- tibble(
#     window_start = seq(
#         qs_data$sample_date[1], 
#         qs_data$sample_date[nrow(qs_data)], 
#         by = "9 days"
#     ),
#     k_mgl = NA,
#     mg_mgl = NA
# )
# qs_smoothed

# for (i in 1:nrow(qs_smoothed)) {
#   w1 <- qs_smoothed$window_start[i]
#   w2 <- w1+9
#   print(w1)
#   print(w2)
  
#   pot <- qs_data$k_mgl[qs_data$sample_date >= w1 & qs_data$sample_date < w2]
#   mag <- qs_data$mg_mgl[qs_data$sample_date >= w1 & qs_data$sample_date < w2]
#   print(pot)
#   print(mag)
  
#   qs_smoothed$k_mgl[i] <- mean(pot, na.rm = TRUE)
#   qs_smoothed$mg_mgl[i] <- mean(mag, na.rm = TRUE)
# }

# qs_smoothed


# qs_long <- qs_smoothed |> 
#   pivot_longer(
#     cols = k_mgl:mg_mgl,
#     names_to = "ion",
#     values_to = "concentration"
#   )
# qs_long

# ggplot(
#     data = qs_long,
#     mapping = aes(
#         x = window_start,
#         y = concentration,
#         color = ion
#     )
# ) + geom_point() +
#   scale_y_continuous(
#     name = "Average Concentration (mgl)"
#   ) + 
#   scale_x_date(
#     name = "Date"
#   )