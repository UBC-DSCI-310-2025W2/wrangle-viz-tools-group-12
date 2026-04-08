library(testthat)
library(rlang)

source("../../R/make_dummy_col.R", encoding = "UTF-8")
 # 1.Simple expected cases
test_that("make_dummy_col works correctly with one string in the vector", {
  df <- data.frame(
    name = c("Alice", "Bob", "Charlie", "David"),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    name = c("Alice", "Bob", "Charlie", "David"),
    status = c(1, 0, 1, 0)
  )
  result <- make_dummy_col(df, "status","status", c("Married"))
  expect_identical(result, df_expected)
  result_2 <- make_dummy_col(df, "status", "status", "Married")
  expect_identical(result_2, df_expected)
})
test_that("make_dummy_col works correctly with multiple string in the vector", {
  df <- data.frame(
    name = c("Alice", "Bob", "Charlie", "David"),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    name = c("Alice", "Bob", "Charlie", "David"),
    married = c(1, 0, 1, 1)
  )
  result <- make_dummy_col(df, "status", "married", c("Married", "Divorced"))
  expect_identical(result, df_expected)
})
test_that("make_dummy_col work correctly with num in the vector", {
  df <- data.frame(
    numbers = c(100, 100, 99, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    status = c("Married", "Single", "Married", "Divorced"),
    numbers = c(1, 1, 1, 0)
  )
  result <- make_dummy_col(df, "numbers","numbers", c(100, 99))
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
  expect_identical(
    expect_warning(make_dummy_col(df, "y", "y", c("1")), "contains NA or '\\?'"),
   df_expected)
})

test_that("Warning triggers for 'NA", {
  df <- data.frame(
    x = c(1,2,3,4),
    y = c(0,1,NA,1)
  )
  df_expected <- data.frame(
    x = c(1,2,3,4),
    y = c(0,1,0,1)
  )
  
  expect_identical(
    expect_warning(make_dummy_col(df, "y","y", c(1)), "contains NA or '\\?'"),
   df_expected)
})

test_that("make_dummy_col works when vector is empty", { 
  df <- data.frame(
    numbers = c(100, 100, 99, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    status = c("Married", "Single", "Married", "Divorced"),
    numbers = c(0, 0, 0, 0)
  )

  expect_identical(
    expect_warning(make_dummy_col(df, "numbers","numbers", c()),
    "Type mismatch: The provided values are not the same class as the column values.")      
      , df_expected) #this triggers a warning and expected

})

test_that("make_dummy_col works no value column matches vector", {
  df <- data.frame(
    numbers = c(100, 100, 99, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    status = c("Married", "Single", "Married", "Divorced"),
    numbers = c(0, 0, 0, 0)
  )
  result <- make_dummy_col(df, "numbers", "numbers", c(2))
  expect_identical(result, df_expected)
})

test_that("make_dummy_col works when all value column matches vector", {
  df <- data.frame(
    numbers = c(100, 100, 100, 100),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    status = c("Married", "Single", "Married", "Divorced"),
    numbers = c(1, 1, 1, 1)
  )
  result <- make_dummy_col(df, "numbers","numbers", c(100))
  expect_identical(result, df_expected)
})

test_that("make_dummy_col works when vector is a different type", {
  df <- data.frame(
    status = c("Married", "Single", "Married", "Divorced"), 
    numbers = c(100, 100, 100, 100)
  )

  expect_warning(make_dummy_col(df, "numbers","numbers", c("100")),"Type mismatch: The provided values are not the same class as the column values.")
})

test_that("make_dummy_col works when vector contains string and num", {
  df <- data.frame(
    numbers = c(100, 100, 100, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )
  df_expected <- data.frame(
    status = c("Married", "Single", "Married", "Divorced"),
    numbers = c(0, 0, 0, 0)
  )

    expect_warning(
      make_dummy_col(df, "numbers", "numbers",c("100", 98)),
      "Type mismatch: The provided values are not the same class as the column values.")

})


#3. Abnormal, error or adversarial use cases.

test_that("make_dummy_col stops if dataframe is not a dataframe", {
  df <- data.frame(
    numbers = c(100, 100, 100, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )

    expect_error(
      make_dummy_col(1, "numbers", "numbers", c(100)),
      "`data_frame` must be a data frame or tibble."
      )
})

test_that("make_dummy_col stops if col name is not a single string", {
  df <- data.frame(
    numbers = c(100, 100, 100, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )

    expect_error(
      make_dummy_col(df, 1, "1", c(100)),
      "`col_name` must be a single string."
      )
    expect_error(
      make_dummy_col(df, c("hi", "hello"),"name", c(100)),
      "`col_name` must be a single string."
      )
})

test_that("make_dummy_col stops if values is not a vector", {
  df <- data.frame(
    numbers = c(100, 100, 100, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )

    expect_error(
      make_dummy_col(df, "status","status", df),
      "`values` cannot be a dataframe."
      )
})

test_that("make_dummy_col stops if values is not a vector", {
  df <- data.frame(
    numbers = c(100, 100, 100, 98),
    status = c("Married", "Single", "Married", "Divorced")
  )

    expect_error(
      make_dummy_col(df, "testing", "testing",100),
      "Column testing not found in data frame."
      )
})


