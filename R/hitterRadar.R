#' Create a radar plot from a hitter profile
#'
#' This function creates a radar plot using the scaled values from a hitter profile
#' data frame. It is desgined to work with the output from `hitterProfile()`.
#'
#' @param profile_data A data frame created by `hitter_profile()`, containing
#' a `metric` columns, a `scaled_value` column, and a `player` column.
#'
#' @returns A radar plot displaying the chosen hitter's scaled offensive production
#' @export
#'
#' @examples
#' judge_profile <- hitterProfile(
#'   player = "Aaron Judge",
#'   ops = 1.000,
#'   avg = 0.300,
#'   slg = 0.700,
#'   wrc_plus = 175,
#'   iso = 0.210,
#'   war = 9.5
#' )
#'
#' hitterRadar(judge_profile)
hitterRadar <- function(profile_data) {

  radar_values <- as.data.frame(t(profile_data$scaled_value))

  names(radar_values) <- profile_data$metric

  radar_data <- rbind(
    rep(100, ncol(radar_values)),
    rep(0, ncol(radar_values)),
    radar_values
  )

  rownames(radar_data) <- c("max", "min", "player")

  fmsb::radarchart(
    radar_data,
    axistype = 1,
    pcol = "orange",
    pfcol = grDevices::rgb(1, 0.5, 0, 0.3),
    plwd = 2,
    cglcol = "grey",
    cglty = 1,
    axislabcol = "grey",
    vlcex = 1,
    title = unique(profile_data$player)
  )
}
