# Create a radar plot from a hitter profile

This function creates a radar plot using the scaled values from a hitter
profile data frame. It is desgined to work with the output from
[`hitterProfile()`](https://adc-405-s26.github.io/webgem/reference/hitterProfile.md).

## Usage

``` r
hitterRadar(profile_data)
```

## Arguments

- profile_data:

  A data frame created by `hitter_profile()`, containing a `metric`
  columns, a `scaled_value` column, and a `player` column.

## Value

A radar plot displaying the chosen hitter's scaled offensive production

## Examples

``` r
judge_profile <- hitterProfile(
  player = "Aaron Judge",
  ops = 1.000,
  avg = 0.300,
  slg = 0.700,
  wrc_plus = 175,
  iso = 0.210,
  war = 9.5
)

hitterRadar(judge_profile)
```
