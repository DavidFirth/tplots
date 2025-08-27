#' Make a Points Grob for a Ternary Plot
#'
#' @description Three-part compositional data are converted to 2-dimensional coordinates and then displayed in a ternary plot.
#' 
#' @param nby3 a 3-column numeric matrix.  Each row represents one point to be plotted.  Rows will be scaled to sum to 1 before plotting, so no row can contain only zeros.
#' @param neg_action a character string, either `"warning"` or `"error"`; or `NULL` if no checking of negative values is wanted.  This provides optional checking for negative values in the `nby3` matrix.
#' @param gp graphical settings via [grid::gpar()]
#' @param ... arguments to pass to [grid::grid.points()].
#'
#' @return A points grob object (invisibly). 
#'
#' @details When the resulting object is drawn, the viewport should be square.  This is not checked. 
#'
#' @examples
#' ## Toy data with compositions (1/6, 2/6, 3/6) and (2/5, 2/5, 1/5)
#' tplot_new()
#' grid::grid.draw(ternary_thirds())
#' toy_data <- matrix(c(1, 2, 3,
#'                      2, 2, 1),
#'                      2, 3, byrow = TRUE)
#' grid::grid.draw(ternary_points(toy_data, gp = grid::gpar(col = c("red", "blue"))))
#' grid::grid.draw(ternary_text(label = c("(1, 2, 3)", "(2, 2, 1)"), nby3 = toy_data,
#'                        hjust = c(-0.3, 0.5), vjust = c(0.5, -1)))
#'#' 
#' @author David Firth
#'
#' @export
#'
ternary_points <- function(nby3, neg_action = "warning", gp = grid::gpar(), ...) {
    xy <- ternary_xy(nby3, neg_action)
    grid::pointsGrob(x = xy$x, y = xy$y, gp = gp, ...)
}
