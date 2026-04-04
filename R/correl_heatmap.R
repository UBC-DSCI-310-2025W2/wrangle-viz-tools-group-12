#' Plot a correlation heatmap of numeric variables
#'
#' @param data A data frame containing numeric columns to correlate
#' @param title A string for the plot title
#'
#' @return A ggplot object of the correlation heatmap
#' @export
#'
#' @examples
#' plot_correlation_heatmap(mtcars, "Correlation Heatmap of mtcars")
plot_correlation_heatmap <- function(data, title = "Correlation Heatmap") {
  if (!is.data.frame(data)) stop("`data` must be a data frame")

  num_df <- data |> dplyr::select(where(is.numeric))

  if (ncol(num_df) < 2) stop("`data` must have at least 2 numeric columns")

  cor_mat <- cor(num_df, use = "complete.obs")

  cor_long <- as.data.frame(cor_mat) |>
    tibble::rownames_to_column("Var1") |>
    tidyr::pivot_longer(-Var1, names_to = "Var2", values_to = "Correlation")

  ggplot2::ggplot(cor_long, ggplot2::aes(x = Var1, y = Var2, fill = Correlation)) +
    ggplot2::geom_tile(color = "white") +
    ggplot2::scale_fill_gradient2(
      low = "steelblue", mid = "white", high = "firebrick",
      midpoint = 0, limits = c(-1, 1)
    ) +
    ggplot2::theme_minimal() +
    ggplot2::labs(title = title, x = "", y = "", fill = "Corr") +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(size = 14, angle = 45, hjust = 1),
      axis.text.y = ggplot2::element_text(size = 14),
      plot.title  = ggplot2::element_text(size = 18, face = "bold")
    )
}