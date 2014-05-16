generate_subsets <- function(phy, window_size) {

  time_range <- range(sample_data(phy)$age_at_sampling)
  start <- time_range[1]
  stop <- time_range[2]

  window_range <- start:stop

  subsets <- list()
  for (x in window_range) {
    d <- window_size / 2.0
    i <- x - d
    j <- x + d

    meta <- sample_data(phy)

    ss1 <- meta[meta$age_at_sampling >= i,]
    ss2 <- meta[meta$age_at_sampling <= j,]

    ss <- phy

    sample_data(ss) <- sample_data(ss2)

    subsets <- cbind(subsets, ss)
  }
  return(subsets)
}
