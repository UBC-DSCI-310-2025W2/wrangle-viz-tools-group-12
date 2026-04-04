#' Train a logistic regression model
#'
#' This function trains a logistic regression model using a given dataset
#' and formula.
#'
#' @param df A data frame containing the dataset
#' @param formula A formula specifying the model
#'
#' @return A trained glm model object
#' @export
#'
#' @examples
#' df <- data.frame(x = c(1,2,3), y = c(0,1,0))
#' train_logistic_model(df, y ~ x)

train_logistic_model <- function(df, formula) {
  if (!is.data.frame(df)) {
    stop("df must be a data frame")
  }

  model <- glm(formula, data = df, family = binomial())

  return(model)
}