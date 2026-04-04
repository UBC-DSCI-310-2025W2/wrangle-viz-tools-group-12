#' Creates a confusion matrix plot to compare predicted classes with actual classes
#'
#' This function creates a confusion matrix plot when it is given two vectors, one of the predicted classes and
#' one of the actual ground truth.
#'
#' @param actual A vector of the ground truth classes
#' @param predicted_classes A vector of the predicted classes
#'
#' @return A ggplot object of a confusion matrix
#' @export
#'
#' @examples
#' actual <- c(0, 1, 1, 1)
#' predicted_classses <- c(0, 0, 1, 1)
#' create_confusion_matrix_plot(actual, predicted_classes)

create_confusion_matrix_plot <- function(actual, predicted_classes) {
  if (length(actual) != length(predicted_classes)) {
    stop("`actual` and `predicted_classes` must have the same length.")
  }

  if (!is.numeric(actual)) {
    stop("`actual` must be numeric (0/1).")
  }

  if (!all(actual %in% c(0, 1))) {
    stop("`actual` must only contain 0 and 1.")
  }

  if (!is.numeric(predicted_classes)) {
    stop("`predicted_classes` must be numeric (0/1).")
  }

  if (!all(predicted_classes %in% c(0, 1))) {
    stop("`predicted_classes` must only contain 0 and 1.")
  }

  actual_f <- factor(actual)
  pred_f <- factor(as.numeric(as.character(predicted_classes)))

  cm <- confusionMatrix(pred_f, actual_f)
  conf_df <- as.data.frame(cm$table)
  names(conf_df) <- c("Actual", "Predicted", "Freq")

  confusion_plot <- ggplot(conf_df, aes(x = Actual, y = Predicted, fill = Freq)) +
    geom_tile() +
    geom_text(aes(label = Freq), size = 6) +
    scale_fill_gradient(low = "white", high = "steelblue") +
    labs(
      title = "Confusion Matrix for Logistic Regression",
      x = "Actual Income (0 = <=50K, 1 = >50K)",
      y = "Predicted Income"
    ) +
    theme_minimal() +
    theme(
      axis.text.x = element_text(size = 14),
      axis.text.y = element_text(size = 14),
      axis.title.x = element_text(size = 16),
      axis.title.y = element_text(size = 16),
      plot.title = element_text(size = 18, face = "bold")
    )

  return(confusion_plot)
}