library(testthat)
library(caret)

source("../../R/08_create_confusion_matrix_plot.R")

# Test 1: Simple use case 1 (actual and predicted are exact same)
test_that("create_confusion_matrix_plot returns a ggplot object", {
  actual <- c(0, 1, 0, 1)
  predicted_classes <- c(0, 1, 0, 1)
  
  confusion_plot <- create_confusion_matrix_plot(actual, predicted_classes)
  
  expect_true("ggplot" %in% class(confusion_plot))
})

# Test 2: Simple use case 2 (actual and predicted are different)
test_that("confusion matrix plot is created without error on valid input", {
  actual <- c(0, 1, 0, 1, 1, 0)
  predicted_classes <- c(0, 1, 0, 0, 1, 1)
  
  expect_no_error(
    create_confusion_matrix_plot(actual, predicted_classes)
  )
})

# Test 3: Wrong input case 1 (vectors that are not just 0 or 1)
test_that("error if actual or predicted_classes are not numeric 0/1 vectors", {
  expect_error(
    create_confusion_matrix_plot(c("a", "b"), c(0, 1))
  )
  
  expect_error(
    create_confusion_matrix_plot(c(0, 1), c("x", "y"))
  )
  
  expect_error(
    create_confusion_matrix_plot(c(0, 2), c(0, 1))
  )
  
  expect_error(
    create_confusion_matrix_plot(c(0, 1), c(0, 3))
  )
})

# Test 4: Wrong input case 2 (unequal vector lengths)
test_that("error if actual and predicted_classes have different lengths", {
  actual <- c(0, 1, 0)
  predicted_classes <- c(0, 1)
  
  expect_error(
    create_confusion_matrix_plot(actual, predicted_classes)
  )
})

# Test 5: Edge case (minimal valid data)
test_that("function works with minimal valid input", {
  actual <- c(0, 1)
  predicted_classes <- c(0, 1)
  
  confusion_plot <- create_confusion_matrix_plot(actual, predicted_classes)
  
  expect_true("ggplot" %in% class(confusion_plot))
})

