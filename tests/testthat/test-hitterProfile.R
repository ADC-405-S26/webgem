test_that("hitterProfile correctly creates a profile data frame", {

  result <- hitterProfile(
    player = "Test Player",
    wrc_plus = 175,
    ops = 1.110,
    obp = 0.458,
    slg = 0.701,
    avg = 0.322,
    iso = 0.379,
    war = 10.8,
    woba = 0.458,
    bb_pct = 18.9,
    barrel_pct = 26.9,
    hard_hit_pct = 61.8
  )

  expect_s3_class(result, "data.frame")
  expect_named(result, c("metric", "raw_value", "scaled_value", "player"))
  expect_equal(nrow(result), 11)
})

test_that("hitterProfile only includes user inputted metrics", {

  result <- hitterProfile(
    player = "Test Player",
    ops = 0.850,
    obp = 0.360,
    slg = 0.490
  )

  expect_equal(result$metric, c("OPS", "OBP", "SLG"))
  expect_equal(nrow(result), 3)
  expect_true(all(!is.na(result$scaled_value)))
})

test_that("hitterProfile results in scaled values between 0 and 100", {

  results <- hitterProfile(
    player = "Test Player",
    ops = 0.850,
    obp = 0.360,
    slg = 0.490
  )

  expect_true(all(results$scaled_value <= 100))
  expect_true(all(results$scaled_value >= 0))
})

test_that("hitterProfile assertions catch invalid metric inputs", {

  # metric is not numeric
  expect_error(
    hitterProfile(
      player = "Test Player",
      ops = "good"
    ), "Assertion on 'ops' failed")

  # metric is a length greater than 1
  expect_error(
    hitterProfile(
      player = "Test Player",
      wrc_plus = c(120, 130)
    ), "Assertion on 'wrc_plus' failed")

})

test_that("hitterProfile assertions catch invalid 'player' inputs", {

  # player is not a character string
  expect_error(
    hitterProfile(
      player = 132,
      obp = 0.300
    ), "Assertion on 'player' failed")

  # player is a character vector of length > 1
  expect_error(
    hitterProfile(
      player = c("Test Player 1", "Text Player 2"),
      obp = 0.300
    ), "Assertion on 'player' failed")
})


