library(testthat)
library(ggplot2)
source("../../R/05_correl_heatmap.R")

test_that("returns a ggplot object", {
  p <- plot_correlation_heatmap(mtcars)
  expect_s3_class(p, "ggplot")
})

test_that("works with custom title", {
  p <- plot_correlation_heatmap(mtcars, title = "My Heatmap")
  expect_equal(p$labels$title, "My Heatmap")
})

test_that("errors on non-data-frame input", {
  expect_error(plot_correlation_heatmap("not a dataframe"))
})

test_that("errors when fewer than 2 numeric columns", {
  bad_df <- data.frame(a = c("x", "y", "z"))
  expect_error(plot_correlation_heatmap(bad_df))
})