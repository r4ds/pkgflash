test_that("List of exports is correct.", {
  expect_snapshot_error(
    pkg_fn_info("fakepkg260hoGT7MYNzmrCw")
  )

  # This doesn't really tell us much yet, but it's the most controllable way to
  # do this. Eventually we should also export some data to make sure that also
  # works.
  expect_snapshot(
    pkg_fn_info("pkgflash")
  )
})
