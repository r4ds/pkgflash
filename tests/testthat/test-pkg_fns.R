test_that("List of exports is correct.", {
  expect_snapshot_error(
    pkg_fn_info("fakepkg260hoGT7MYNzmrCw")
  )

  # Note: This test is fragile; if testthat changes, the result changes. Once
  # pkgflash has enough functions of its own, perhaps use it as the test.
  expect_snapshot(
    pkg_fn_info("testthat")
  )
})
