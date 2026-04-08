#' Transforms a column into dummy variables 1 or 0
#' 
#' Converts one column in a dataframe into dummy variables removing the original column from dataframe
#'
#' @param data_frame A data frame or data frame extension (e.g. a tibble).
#' @param col_name The name of the column (a single string) to check to convert its values to binary
#' @param new_name The name of the new column (a single string) for new binary variables, can be same as col name
#' @param values A vector of values to be treated as one c(...) or a singular value of any type except a dataframe or tibble
#' @return A data frame with a one column as binary variables
#'
#' @export
#' 
#' @importFrom rlang is_string
#' 
#' @examples
#' df <- data.frame(
#'   marital_status = c("Married", "Widowed", "Single", "Widowed")
#' )
#' make_dummy_col(df, "marital_status", "status", "Widowed")
#' 
#' 
make_dummy_col <- function(data_frame, col_name, new_name, values) {
  #checking that it is a data frame
  if (!is.data.frame(data_frame)) {
    stop("`data_frame` must be a data frame or tibble.")
  }
  if (is.data.frame(values)) {
    stop("`values` cannot be a dataframe.")
  }
    # checking that the column is a string
    if (!rlang::is_string(col_name) | !rlang::is_string(new_name)) {
    stop("`col_name` must be a single string.")
  }
  #checking that the column exists
    if (!col_name %in% names(data_frame)) {
    stop("Column ", col_name, " not found in data frame.")
  }
    # checking that the data class is same for values and column
  if (!all(class(data_frame[[col_name]]) == class(values))) {
    warning("Type mismatch: The provided values are not the same class as the column values.")
  }
  if (any(is.na(data_frame[[col_name]]) | data_frame[[col_name]] == "?", na.rm = TRUE)) {
    warning("The column contains NA or '?' values which will be coded as 0.")
  }

  # this generates a vector of dummy varaibles
  dummy_vector <- ifelse(data_frame[[col_name]] %in% values, 1, 0)
  data_frame[[col_name]] <- NULL
  data_frame[[new_name]] <- dummy_vector
  #overriding the old column as a dummy variable


  return(data_frame)
} 