# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(site_data) {
  # Tibble to contain results 
  result <- tibble(
    window_start = seq(site_data$Sample_Date[1], site_data$Sample_Date[nrow(site_data)], by = "9 weeks"),
    Site = site_data$Site[1],
    no3n_ugL = NA, 
    k_mgL = NA, 
    mg_mgL = NA, 
    ca_mgL = NA,
    nh4n_ugL = NA
  )

  for (i in 1:nrow(result)) {
    # Variables for the start and end of the current window
    w1 <- result$window_start[i]
    w2 <- w1 + weeks(9)

    # Logical vector that defines which samples are inside the window
    in_window <- site_data$Sample_Date >= w1 & site_data$Sample_Date < w2

    # Indexes ion concentrations that fall inside the window
    no3n_window <- site_data$`NO3-N`[in_window]
    k_window <- site_data$K[in_window]
    mg_window <- site_data$Mg[in_window]
    ca_window <- site_data$Ca[in_window]
    nh4n_window <- site_data$`NH4-N`[in_window]

    # Calculates the mean of each ion concentration and fill in the result
    result$no3n_ugL[i] <- mean(no3n_window, na.rm = TRUE)
    result$k_mgL[i] <- mean(k_window, na.rm = TRUE)
    result$mg_mgL[i] <- mean(mg_window, na.rm = TRUE)
    result$ca_mgL[i] <- mean(ca_window, na.rm = TRUE)
    result$nh4n_ugL[i] <- mean(nh4n_window, na.rm = TRUE)
  }
  return(result)
}
