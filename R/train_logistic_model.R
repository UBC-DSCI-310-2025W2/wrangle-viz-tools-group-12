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
#' @importFrom stats glm binomial
#' 
#' @examples
#' df <- data.frame(x = c(1,2,3), y = c(0,1,0))
#' train_logistic_model(df, y ~ x)

train_logistic_model <- function(df, formula) {
  if (!is.data.frame(df)) {
    stop("df must be a data frame")
  }
  if (!inherits(formula, "formula")) {
    stop("formula must be a formula object")
  }
  response_var <- all.vars(formula)[1]
  if (!response_var %in% names(df)) {
    stop(paste("Response variable", response_var, "not found in df"))
  }
  if (length(unique(df[[response_var]])) != 2) {
    stop("Response variable must be binary (exactly 2 unique values) for logistic regression")
  }

  model <- glm(formula, data = df, family = binomial())
  return(model)
}