# Create a scaled hitter profile from user defined offensive metrics

This function creates a hitter profile from selected offensive baseball
metrics. The user can enter any combination of the offensive metrics
listed, which will return a data frame with the raw inputted values and
scaled values. The scaled values can then be inputted into the
`hitterRadar` function, that will plot the metrics on a radar plot.

## Usage

``` r
hitterProfile(
  player,
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
  hard_hit_pct = NULL
)
```

## Arguments

- player:

  The name of the player being analyzed, must be one character string.

- wrc_plus:

  Weighted runs created plus.

- ops:

  On-base plus slugging.

- obp:

  On-base percentage.

- slg:

  Slugging percentage.

- avg:

  Batting average.

- iso:

  Isolated power.

- war:

  Wins above replacement.

- woba:

  Weighted on-base average.

- bb_pct:

  Walk percentage.

- barrel_pct:

  Barrel percentage.

- hard_hit_pct:

  Hard-hit percentage.

## Value

A data frame with the player name, selected metrics, raw inputted
values, and scaled values.

## Examples

``` r
judge_profile <- hitterProfile(
  player = "Aaron Judge",
  wrc_plus = 175,
  ops = 1.110,
  obp = 0.458,
  slg = 0.701,
  avg = 0.322,
  iso = 0.379
)

judge_profile
#>   metric raw_value scaled_value      player
#> 1   wRC+   175.000     83.33333 Aaron Judge
#> 2    OPS     1.110     72.85714 Aaron Judge
#> 3    OBP     0.458     87.07692 Aaron Judge
#> 4    SLG     0.701     90.20000 Aaron Judge
#> 5    AVG     0.322     76.44444 Aaron Judge
#> 6    ISO     0.379     94.00000 Aaron Judge
```
