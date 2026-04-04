library(testthat)

source("../../R/06_train_logistic_model.R", encoding = "UTF-8")

# ---- Test 1: Simple expected use case ----
test_that("train_logistic_model returns a glm object", {
  df <- data.frame(
    x = c(1,2,3,4),
    y = c(0,1,0,1)
  )
  
  model <- train_logistic_model(df, y ~ x)
  
  expect_true("glm" %in% class(model))
})

# ---- Test 2: Works on valid data without errors ----
test_that("model fits without error on valid data", {
  df <- data.frame(
    x = c(1,2,3,4),
    y = c(0,1,0,1)
  )
  
  expect_no_error(
    train_logistic_model(df, y ~ x)
  )
})

# ---- Test 3: Abnormal / adversarial input ----
test_that("error if df is not a data frame", {
  expect_error(
    train_logistic_model(123, y ~ x)
  )
  expect_error(
    train_logistic_model("not_a_df", y ~ x)
  )
  expect_error(
    train_logistic_model(list(1,2,3), y ~ x)
  )
})

# ---- Test 4: Edge case - minimal valid data ----
test_that("model still works with minimal data", {
  df <- data.frame(
    x = c(1,2),
    y = c(0,1)
  )
  
  model <- train_logistic_model(df, y ~ x)
  
  expect_true("glm" %in% class(model))
})

# ---- Test 5: NA values ----
test_that("model handles missing values appropriately", {
  df <- data.frame(
    x = c(1, 2, NA, 4),
    y = c(0, 1, 0, 1)
  )
  
  expect_warning(
    model <- train_logistic_model(df, y ~ x)
  )
})