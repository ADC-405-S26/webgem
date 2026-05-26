test_that("hitterRadar creates a radar plot without error", {

  result <- hitterProfile(
    player = "Test Player",
    ops = 0.950,
    obp = 0.360,
    slg = 0.490,
    wrc_plus = 130
  )

  expect_no_error(
    hitterRadar(result)
  )
})

test_that("hitterRadar catches non data-frame input", {

  expect_error(
    hitterRadar(c(1, 2, 3)),
    "Assertion on 'profile_data' failed"
  )
})

test_that("hitterRadar catches missing required columns", {

  result <- data.frame(
    metric = c("OPS", "OBP", "SLG"),
    raw_value = c(0.950, 0.360, 0.490)
  )

  expect_error(
    hitterRadar(result),
    "scaled_value"
  )
})
