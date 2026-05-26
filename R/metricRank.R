#' Rank numeric values using one or two thresholds
#'
#' This function labels numeric values based on user-defined threshold values.
#' With one threshold, values are labeled as lower or upper. With two thresholds,
#' values are labeled as lower, middle, or upper. This function is useful for
#' creating categories from numeric metrics, especially when preparing data for
#' summaries or visualization.
#'
#' @param x A numeric vector to label
#' @param threshold The cutoff value used to separate lower values from higher values.
#' Values below this number receive `lower_label`, values above receive `upper_label`.
#' @param upper_threshold An optional upper cutoff value. If provided, values between `threshold` and `upper_threshold` receive the middle label.
#' @param lower_label The label for values below `threshold`.
#' @param middle_label The label for values between `threshold` and `upper_threshold`. Only used when `upper_threshold` is provided.
#' @param upper_label The label for values at or above the upper cutoff/
#'
#' @returns A character vector or labels
#' @export
#'
#' @examples
#' era = c(2.03, 2.40, 5.49, 4.23, 3.46, 1.01, 4.50, 3.98, 3.76)
#'
#' metricRank(
#'   x = era,
#'   threshold = 2.75,
#'   upper_threshold = 3.75,
#'   lower_label = "great era",
#'   middle_label = "mediocre era",
#'   upper_label = "bad era")
metricRank <- function(x, threshold, upper_threshold = NULL, lower_label, middle_label = NULL, upper_label) {

  checkmate::assert_numeric(x)
  checkmate::assert_number(threshold)
  checkmate::assert_string(lower_label)
  checkmate::assert_string(upper_label)

  if (!is.null(upper_threshold)) {
    checkmate::assert_number(upper_threshold)
    checkmate::assert_string(middle_label)
  }

  if(is.null(upper_threshold)) {
    result <-  ifelse(x >= threshold, upper_label, lower_label)
  } else {
    result <- ifelse(
      x < threshold,
      lower_label,
      ifelse(x >= upper_threshold, upper_label, middle_label)
    )
  }
  result
}
