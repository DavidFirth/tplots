                                        # ternary_lines
                                        # ternary_polyline
#' Draw lines in a Ternary Plot
#'
#' @description Three-part compositional data points are connected by lines in a ternary plot.
#' 
#' @param nby3 a 3-column numeric matrix.  Each row represents one point to be plotted.  Rows will be scaled to sum to 1 before plotting, so no row can contain only zeros.
#' @param neg_action a character string, either `"warning"` or `"error"`; or `NULL` if no checking of negative values is wanted.  This provides optional checking for negative values in the `nby3` matrix.
#' @param ... arguments to pass to [grid::grid.lines()].
#'
#' @return A lines grob object. 
#'
#' @details When the resulting object is drawn, the viewport should be square.  This is not checked.
#'
#' @examples
#' endpoints <- matrix(c(-0.1, 0.3, 0.8,  ## this point will trigger a warning, by default 
#'                        0.2, 0.2, 0.6,
#'                        0.1, 0.8, 0.1),
#'                      3, 3, byrow = TRUE)
#' tplot_new()
#' grid::grid.draw(ternary_frame())
#' grid::grid.draw(ternary_lines(endpoints))
#'                       
#'
#' @author David Firth
#'
#' @export
#' 
ternary_lines <- function(nby3, neg_action = "warning", ...) {
    xy <- ternary_xy(nby3, neg_action)
    grid::linesGrob(x = xy$x, y = xy$y, ...)
}
