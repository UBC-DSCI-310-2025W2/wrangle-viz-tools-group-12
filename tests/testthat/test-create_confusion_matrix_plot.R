library(testthat)
library(caret)

source("../../R/create_confusion_matrix_plot.R")

# Test 1: Simple use case 1 (actual and predicted are exact same)
test_that("create_confusion_matrix_plot returns a ggplot object", {
  actual <- factor(c(0, 1, 0, 1))
  predicted <- factor(c(0, 1, 0, 1))

  cm <- confusionMatrix(predicted, actual)
  confusion_plot <- create_confusion_matrix_plot(cm$table)

  expect_true("ggplot" %in% class(confusion_plot))
})

# Test 2: Simple use case 2 (actual and predicted are different)
test_that("confusion matrix plot is created without error on valid confusion matrix input", {
  actual <- factor(c(0, 1, 0, 1, 1, 0))
  predicted <- factor(c(0, 1, 0, 0, 1, 1))

  cm <- confusionMatrix(predicted, actual)

  expect_no_error(
    create_confusion_matrix_plot(cm$table)
  )
})

# Test 3: Wrong input case 1 (not a valid confusion matrix structure)
test_that("error if input is not a valid confusion matrix structure", {
  expect_error(
    create_confusion_matrix_plot(c(1, 2, 3))
  )
})

# Test 4: Wrong input case 2 (not a 2D confusion matrix)
test_that("error if confusion matrix does not have correct structure", {
  # 1D table (not 2D confusion matrix)
  invalid_table <- table(c(0, 1, 1, 0))
  
  expect_error(
    create_confusion_matrix_plot(invalid_table)
  )
})

# Test 5: Edge case (minimal valid data)
test_that("function works with minimal valid input", {
  actual <- factor(c(0, 1))
  predicted <- factor(c(0, 1))

  cm <- confusionMatrix(predicted, actual)
  confusion_plot <- create_confusion_matrix_plot(cm$table)

  expect_true("ggplot" %in% class(confusion_plot))
})
