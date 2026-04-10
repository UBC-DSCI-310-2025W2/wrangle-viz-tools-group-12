#' Creates a confusion matrix plot from a confusion matrix table
#'
#' This function takes a confusion matrix table (e.g., from caret::confusionMatrix)
#' and returns a ggplot visualization.
#'
#' @param cm_table A table or data frame representing the confusion matrix
#' (e.g., cm$table from caret::confusionMatrix)
#'
#' @return A ggplot object of a confusion matrix
#' @export
#'
#' @importFrom ggplot2 ggplot aes geom_tile geom_text scale_fill_gradient labs theme_minimal theme element_text
#'
#' @examples
#' library(caret)
#' actual <- factor(c(0, 1, 1, 1))
#' predicted <- factor(c(0, 0, 1, 1))
#' cm <- confusionMatrix(predicted, actual)
#' create_confusion_matrix_plot(cm$table)

create_confusion_matrix_plot <- function(cm_table) {

  # Convert to data frame if needed
  conf_df <- as.data.frame(cm_table)
  names(conf_df) <- c("Actual", "Predicted", "Freq")

  # Plot
  ggplot(conf_df, aes(x = Actual, y = Predicted, fill = Freq)) +
    geom_tile() +
    geom_text(aes(label = Freq), size = 6) +
    scale_fill_gradient(low = "white", high = "steelblue") +
    labs(
      title = "Confusion Matrix",
      x = "Actual",
      y = "Predicted"
    ) +
    theme_minimal() +
    theme(
      axis.text.x = element_text(size = 14),
      axis.text.y = element_text(size = 14),
      axis.title.x = element_text(size = 16),
      axis.title.y = element_text(size = 16),
      plot.title = element_text(size = 18, face = "bold")
    )
}