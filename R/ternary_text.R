#' Make a Text Grob for a Ternary Plot
#'
#' @description Text labels can be added to a ternary plot through this function.
#'
#' @param label a character vector of text labels.
#' @param nby3 a 3-column numeric matrix.  Each row represents the plotting position of one label.  Rows will be scaled to sum to 1 before plotting, so no row can contain only zeros.
#' @param neg_action a character string, either `"warning"` or `"error"`; or `NULL` if no checking of negative values is wanted.  This provides optional checking for negative values in the `compos` matrix.
#' @param ... other arguments to pass to [grid::grid.text()].
#'
#' @return A text grob object.
#'
#' @details 
#'
#' The current viewport should be square when the grob gets drawn.  This is not checked.
#'
#' @examples
#'
#' ## Labelled thirds
#' tplot_new()
#' grid::grid.draw(ternary_thirds())
#' grid::grid.draw(ternary_text(label = c("part 1", "part 2", "part 3"),
#'                              nby3 = 0.7 * diag(3) + 0.1))
#' 
#' ## Labelled vertices
#' tplot_new(scale = 1.3)
#' grid::grid.draw(ternary_frame())
#' grid::grid.draw(ternary_text(label = c("part 1", "part 2", "part 3"),
#'                        nby3 = diag(3) - 0.03,
#'                        neg_action = NULL))
#'
#' ## Labelled points
#' ## Toy data with compositions (1/6, 2/6, 3/6) and (2/5, 2/5, 1/5)
#' tplot_new()
#' grid::grid.draw(ternary_thirds())
#' toy_data <- matrix(c(1, 2, 3,
#'                      2, 2, 1),
#'                      2, 3, byrow = TRUE)
#' grid::grid.draw(ternary_points(toy_data, gp = grid::gpar(col = c("red", "blue"))))
#' grid::grid.draw(ternary_text(label = c("(1, 2, 3)", "(2, 2, 1)"), nby3 = toy_data,
#'                              hjust = c(-0.3, 0.5), vjust = c(0.5, -1)))
#'
#' @author David Firth
#'
#' @export
#' 
ternary_text <- function(label, nby3, neg_action = "warning", ...) {
    xy <- ternary_xy(nby3, neg_action)
    grid::textGrob(label = label,
                   x = xy$x,
                   y = xy$y,
                   ...)
}
