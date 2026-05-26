#' Create a scaled hitter profile from user defined offensive metrics
#'
#' This function creates a hitter profile from selected offensive baseball metrics.
#' The user can enter any combination of the offensive metrics listed, which will return
#' a data frame with the raw inputted values and scaled values. The scaled values can
#' then be inputted into the `hitterRadar` function, that will plot the metrics on
#' a radar plot.
#'
#' @param player The name of the player being analyzed, must be one character string.
#' @param wrc_plus Weighted runs created plus.
#' @param ops On-base plus slugging.
#' @param obp On-base percentage.
#' @param slg Slugging percentage.
#' @param avg Batting average.
#' @param iso Isolated power.
#' @param war Wins above replacement.
#' @param woba Weighted on-base average.
#' @param bb_pct Walk percentage.
#' @param barrel_pct Barrel percentage.
#' @param hard_hit_pct Hard-hit percentage.
#'
#' @returns A data frame with the player name, selected metrics, raw inputted values,
#' and scaled values.
#'
#' @export
#'
#' @examples
#' judge_profile <- hitterProfile(
#'   player = "Aaron Judge",
#'   wrc_plus = 175,
#'   ops = 1.110,
#'   obp = 0.458,
#'   slg = 0.701,
#'   avg = 0.322,
#'   iso = 0.379
#' )
#'
#' judge_profile
hitterProfile <- function(player,
                          wrc_plus = NULL,
                          ops = NULL,
                          obp = NULL,
                          slg = NULL,
                          avg = NULL,
                          iso = NULL,
                          war = NULL,
                          woba = NULL,
                          bb_pct = NULL,
                          barrel_pct = NULL,
                          hard_hit_pct = NULL) {

  checkmate::assert_string(player)

  if (!is.null(wrc_plus)) {
    checkmate::assert_number(wrc_plus)
  }

  if (!is.null(ops)) {
    checkmate::assert_number(ops)
  }

  if (!is.null(obp)) {
    checkmate::assert_number(obp)
  }

  if (!is.null(slg)) {
    checkmate::assert_number(slg)
  }

  if (!is.null(avg)) {
    checkmate::assert_number(avg)
  }

  if (!is.null(iso)) {
    checkmate::assert_number(iso)
  }

  if (!is.null(war)) {
    checkmate::assert_number(war)
  }

  if (!is.null(woba)) {
    checkmate::assert_number(woba)
  }

  if (!is.null(bb_pct)) {
    checkmate::assert_number(bb_pct)
  }

  if (!is.null(barrel_pct)) {
    checkmate::assert_number(barrel_pct)
  }

  if (!is.null(hard_hit_pct)) {
    checkmate::assert_number(hard_hit_pct)
  }

  scale_metric <- function(x, min_value, max_value) {
    scaled <- ((x - min_value) / (max_value - min_value)) * 100
    scaled <- max(0, min(scaled, 100))
    scaled
  }

  profile <- data.frame(
    metric = character(),
    raw_value = numeric(),
    scaled_value = numeric()
  )

  add_metric <- function(profile, metric_name, raw_value, min_value, max_value) {
    if (!is.null(raw_value)) {
      new_row <- data.frame(
        metric = metric_name,
        raw_value = raw_value,
        scaled_value = scale_metric(raw_value, min_value, max_value)
      )

      profile <- rbind(profile, new_row)
    }

    profile
  }

  profile <- add_metric(profile, "wRC+", wrc_plus, 50, 200)
  profile <- add_metric(profile, "OPS", ops, 0.600, 1.300)
  profile <- add_metric(profile, "OBP", obp, 0.175, 0.500)
  profile <- add_metric(profile, "SLG", slg, 0.250, 0.750)
  profile <- add_metric(profile, "AVG", avg, 0.150, 0.375)
  profile <- add_metric(profile, "ISO", iso, 0.050, 0.400)
  profile <- add_metric(profile, "WAR", war, 0, 15)
  profile <- add_metric(profile, "wOBA", woba, 0.200, 0.450)
  profile <- add_metric(profile, "BB%", bb_pct, 3, 20)
  profile <- add_metric(profile, "Barrel%", barrel_pct, 2, 25)
  profile <- add_metric(profile, "Hard Hit%", hard_hit_pct, 20, 60)

  profile$player <- player

  profile
}
