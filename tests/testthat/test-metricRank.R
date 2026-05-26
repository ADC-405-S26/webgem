test_that("metricRank categorizes numeric vector correctly with one threshold", {

    result <- metricRank(
      x = c(1, 2, 3, 4, 5, 6),
      threshold = 3.5,
      lower_label = "low",
      upper_label = "high"
    )
    expect_equal(result, c("low", "low", "low", "high", "high", "high"))
    expect_type(result, "character")
    expect_length(result, 6)
})

test_that("metricRank categorizes numeric vector correctly with two thresholds", {

  result <- metricRank(
    x = c(1, 2, 3, 4, 5, 6),
    threshold = 2.5,
    upper_threshold = 4.5,
    lower_label = "low",
    middle_label = "middle",
    upper_label = "high"
  )

  expect_equal(result, c("low", "low", "middle", "middle", "high", "high"))
  expect_type(result, "character")
  expect_length(result, 6)
})

test_that("metricRank handles values exactly equal to thresholds", {

  result <- metricRank(
    x = c(2, 3, 4),
    threshold = 2,
    upper_threshold = 4,
    lower_label = "low",
    middle_label = "middle",
    upper_label = "high"
  )

  expect_equal(result, c("middle", "middle", "high"))
})

test_that("metricRank assertions catch invalid 'x' inputs", {

  # x is not numeric
  expect_error(metricRank(
    x = "one", "two", "three",
    threshold = 2,
    lower_label = "low",
    upper_label = "high"
  ), "Assertion on 'x' failed")

  # x is a data frame, not a numeric vector
  expect_error(
    metricRank(
      x = data.frame(values = c(1, 2, 3)),
      threshold = 2,
      lower_label = "low",
      upper_label = "high"
      ), "Assertion on 'x' failed")

  # x is a numeric vector of length less than 2
  expect_error(
    metricRank(
      x = c(1),
      threshold = 0.5,
      lower_label = "low",
      upper_label = "high"
    ), "Assertion on 'x' failed")
})

test_that("metricRank assertions catch invalid 'threshold' inputs", {
  # threshold is not numeric
  expect_error(
    metricRank(
      x = c(1, 2, 3),
      threshold = "two",
      lower_label = "low",
      upper_label = "high"
    ), "Assertion on 'threshold' failed")

  # threshold has more than one value
  expect_error(
    metricRank(
      x = c(1, 2, 3),
      threshold = c(2, 3),
      lower_label = "low",
      upper_label = "high"
    ), "Assertion on 'threshold' failed")
})

test_that("metricRank assertions catch invalid label inputs", {
  # lower_label is not a character string
  expect_error(
    metricRank(
      x = c(1, 2, 3),
      threshold = 2,
      lower_label = 1,
      upper_label = "high"
    ), "Assertion on 'lower_label' failed")

  # upper_label is not a character string
  expect_error(
    metricRank(
      x = c(1, 2, 3),
      threshold = 2,
      lower_label = "low",
      upper_label = 10
    ), "Assertion on 'upper_label' failed")

  # lower_label has more than one value
  expect_error(
    metricRank(
      x = c(1, 2, 3),
      threshold = 2,
      lower_label = c("low", "bad"),
      upper_label = "high"
    ), "Assertion on 'lower_label' failed")

  # upper_label has more than one value
  expect_error(
    metricRank(
      x = c(1, 2, 3),
      threshold = 2,
      lower_label = "low",
      upper_label = c("high", "bad")
    ), "Assertion on 'upper_label' failed")
})
