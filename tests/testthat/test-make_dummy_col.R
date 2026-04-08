library(testthat)
library(rlang)

source("../../R/make_dummy_col.R", encoding = "UTF-8")

# 1. Simple expected cases
test_that("make_dummy_col works correctly with one string in the vector", {
  df <- data.frame(
    name = c("Alice", "Bob", "Charlie", "David"),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    name = c("Alice", "Bob", "Charlie", "David"),
    status = c(1, 0, 1, 0)
  )

  result <- expect_warning(
    make_dummy_col(df, "status", "status", c("Married")),
    "The new column name is same as the selected column name, overwritting original column"
  )
  expect_identical(result, df_expected)

  result_2 <- expect_warning(
    make_dummy_col(df, "status", "status", "Married"),
    "The new column name is same as the selected column name, overwritting original column"
  )
  expect_identical(result_2, df_expected)
})

test_that("make_dummy_col works correctly with multiple strings in the vector", {
  df <- data.frame(
    name = c("Alice", "Bob", "Charlie", "David"),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    name = c("Alice", "Bob", "Charlie", "David"),
    status = c("Married", "Single", "Married", "Divorced"),
    married = c(1, 0, 1, 1)
  )

  result <- make_dummy_col(df, "status", "married", c("Married", "Divorced"))
  expect_identical(result, df_expected)
})

test_that("make_dummy_col works correctly with numeric vector", {
  df <- data.frame(
    numbers = c(100, 100, 99, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    numbers = c(1, 1, 1, 0),
    status = c("Married", "Single", "Married", "Divorced")
  )

  result <- expect_warning(
    make_dummy_col(df, "numbers", "numbers", c(100, 99)),
    "The new column name is same as the selected column name, overwritting original column"
  )
  expect_identical(result, df_expected)
})

# 2. Edge cases
test_that("Warning triggers for '?'", {
  df <- data.frame(
    x = c(1,2,3,4),
    y = c(0,1,"?",1)
  )
  df_expected <- data.frame(
    x = c(1,2,3,4),
    y = c(0,1,0,1)
  )

  result <- expect_warning(
    make_dummy_col(df, "y", "y", c("1")),
    "contains NA or '\\?'"
  )

  expect_identical(result, df_expected)
})

test_that("Warning triggers for NA", {
  df <- data.frame(
    x = c(1,2,3,4),
    y = c(0,1,NA,1)
  )
  df_expected <- data.frame(
    x = c(1,2,3,4),
    y = c(0,1,0,1)
  )

  result <- expect_warning(
    make_dummy_col(df, "y", "y", c(1)),
    "contains NA or '\\?'"
  )

  expect_identical(result, df_expected)
})

test_that("make_dummy_col works when vector is empty", { 
  df <- data.frame(
    numbers = c(100, 100, 99, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    numbers = c(0, 0, 0, 0),
    status = c("Married", "Single", "Married", "Divorced")
  )

  result <- expect_warning(
    make_dummy_col(df, "numbers", "numbers", c()),
    "Type mismatch"
  )

  expect_identical(result, df_expected)
})

test_that("make_dummy_col works when no values match", {
  df <- data.frame(
    numbers = c(100, 100, 99, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    numbers = c(0, 0, 0, 0),
    status = c("Married", "Single", "Married", "Divorced")
  )

  result <- expect_warning(
    make_dummy_col(df, "numbers", "numbers", c(2)),
    "The new column name is same as the selected column name, overwritting original column"
  )

  expect_identical(result, df_expected)
})

test_that("make_dummy_col works when all values match", {
  df <- data.frame(
    numbers = c(100, 100, 100, 100),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    numbers = c(1, 1, 1, 1),
    status = c("Married", "Single", "Married", "Divorced")
  )

  result <- expect_warning(
    make_dummy_col(df, "numbers", "numbers", c(100)),
    "The new column name is same as the selected column name, overwritting original column"
  )

  expect_identical(result, df_expected)
})

test_that("make_dummy_col warns when vector is different type", {
  df <- data.frame(
    status = c("Married", "Single", "Married", "Divorced"), 
    numbers = c(100, 100, 100, 100)
  )

  expect_warning(
    make_dummy_col(df, "numbers", "numbers", c("100")),
    "Type mismatch"
  )
})

test_that("make_dummy_col works when vector contains string and num", {
  df <- data.frame(
    numbers = c(100, 100, 100, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )

  result <- expect_warning(
    make_dummy_col(df, "numbers", "numbers", c("100", 98)),
    "Type mismatch"
  )

  df_expected <- data.frame(
    numbers = c(1,1, 1, 1),
    status = c("Married", "Single", "Married", "Divorced")
  )

  expect_identical(result, df_expected)
})

# 3. Error / adversarial cases

test_that("make_dummy_col stops if input is not a dataframe", {
  expect_error(
    make_dummy_col(1, "numbers", "numbers", c(100)),
    "`data_frame` must be a data frame or tibble."
  )
})

test_that("make_dummy_col stops if col_name is not a single string", {
  df <- data.frame(
    numbers = c(100, 100, 100, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )

  expect_error(
    make_dummy_col(df, 1, "numbers", c(100)),
    "`col_name` must be a single string."
  )

  expect_error(
    make_dummy_col(df, c("hi", "hello"), "numbers", c(100)),
    "`col_name` must be a single string."
  )
})

test_that("make_dummy_col stops if values is a dataframe", {
  df <- data.frame(
    numbers = c(100, 100, 100, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )

  expect_error(
    make_dummy_col(df, "status", "status", df),
    "`values` cannot be a dataframe."
  )
})

test_that("make_dummy_col stops if column not found", {
  df <- data.frame(
    numbers = c(100, 100, 100, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )

  expect_error(
    make_dummy_col(df, "testing", "testing", 100),
    "Column testing not found in data frame."
  )
})