#' Transforms a column into dummy variables 1 or 0
#'
#' Converts one column in a dataframe into dummy variables
#'
#' @param data_frame A data frame or data frame extension (e.g. a tibble).
#' @param col_name The name of the column (a single string) to check to convert its values to binary
#' @param values A vector of values to be treated as one c(...) or a singular value of any type except a dataframe or tibble
#' @return A data frame with a one column as binary variables
#'
#' @export
#' @examples
#' count_classes(adult_raw, " marital_status", c(" Widowed"))
#' 
#' 
make_dummy_col <- function(data_frame, col_name, values) {
  #checking that it is a data frame
  if (!is.data.frame(data_frame)) {
    stop("`data_frame` must be a data frame or tibble.")
  }
  if (is.data.frame(values)) {
    stop("`values` cannot be a dataframe.")
  }
    # checking that the column is a string
    if (!rlang::is_string(col_name)) {
    stop("`col_name` must be a single string.")
  }
  #checking that the column exists
    if (!col_name %in% names(data_frame)) {
    stop("Column ", col_name, " not found in data frame.")
  }
    # checking that the data class is same for values and column
    if (class(data_frame[[col_name]]) != class(values)) {
    warning("Type mismatch: The provided values are not the same class as the column values.")
  }
  if (any(is.na(data_frame[[col_name]]) | data_frame[[col_name]] == "?", na.rm = TRUE)) {
    warning("The column contains NA or '?' values which will be coded as 0.")
  }
  #this converts the column into characters 
  column_data <- as.character(data_frame[[col_name]])
  #this converts the column into characters 
  search_values <- as.character(values)
  # this generates a vector of dummy varaibles
  dummy_vector <- ifelse(column_data %in% search_values, 1, 0)
  #overriding the old column as a dummy variable
  data_frame[[col_name]] <- dummy_vector
  return(data_frame)
} 