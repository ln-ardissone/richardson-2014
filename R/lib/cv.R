# Create function for running cross-validation
CV <- function(model1, data) {
  values <- matrix(NA, nrow =nrow(data), ncol = 2)
  for (i in 1:nrow(data)) {
    data2 <- data[-i, ] # leave out one observation
    model12 <- glm(model1$formula, family =binomial("logit"), data = data2)
    values[i,1] <- round(predict(model12, newdata = data[i, ], type="response"))
    values[i,2] <- round(as.logical(data$seroconverted[i]))
  }
  sum(values[ ,1] == values[ ,2])/nrow(values)
}
