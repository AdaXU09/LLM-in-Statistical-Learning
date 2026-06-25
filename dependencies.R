# dependencies.R
# -----------------------------------------------------------------------------
# This file exists solely so that `renv` captures packages that the analysis
# notebooks use *indirectly* and that are therefore invisible to renv's
# dependency scanner (which only detects explicit `library()` / `pkg::fun`
# calls in the .Rmd sources).
#
# `see` is loaded on demand by report() / performance() (the easystats stack)
# for their plotting methods. It is a Suggests-level dependency and had to be
# installed manually during development. Listing it here pins it in renv.lock
# so a clean clone resolves it automatically.
#
# This file is documentation for the dependency manifest only; it is not part
# of any analysis and does not need to be sourced.

library(see)
