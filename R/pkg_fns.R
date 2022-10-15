#' List exported functions and their arguments
#'
#' Generate a list of the functions exported by a package, along with their
#' arguments, and the default values of those arguments.
#'
#' Note: While you can get values for "base" as if it is a package, primitive
#' functions will show `NULL` as their arguments.
#'
#' @param pkg A character naming an installed package.
#'
#' @return A named list of named pairlists. The names of the outer list are the
#'   functions, and the names of each contained pairlist are the arguments. The
#'   values of the pairlists are the default values of the arguments.
#' @export
#'
#' @examples
#' base_fns <- pkg_fn_info("base")
#' # Note that we do not know information about the arguments of primatives.
#' base_fns$is.function
#'
#' pkg_fn_info("utils")
pkg_fn_info <- function(pkg) {
  rlang::check_installed(
    pkg,
    reason = "in order to generate flashcards about it."
  )

  pkg_fns <- .pkg_fns(pkg)

  purrr::map(
    pkg_fns,
    formals,
    envir = rlang::ns_env(pkg)
  )
}

#' List functions exported by a package
#'
#' The trick is sorting out data from functions. There may be an easier way to
#' do this.
#'
#' @inheritParams pkg_fn_info
#'
#' @return A list of the actual functions exported by the package (not just
#'   their names).
#'
#' @keywords internal
.pkg_fns <- function(pkg) {
  all_exports <- getNamespaceExports(pkg)
  maybe_fns <- mget(
    all_exports,
    envir = rlang::ns_env(pkg),
    mode = "function",
    # We need to have an alternative for each element, even if we want to use
    # the same empty-list for all of them.
    ifnotfound = rep_len(list(), length(all_exports))
  )
  maybe_fns[lengths(maybe_fns) == 1]
}
