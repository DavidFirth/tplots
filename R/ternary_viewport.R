#' Make a Square Viewport for a Ternary Plot
#'
#' This function creates a viewport with fixed aspect ratio, suitable for drawing a ternary plot or a tetraplot.  The arguments give control over orientation and scaling of the plot.
#' 
#' @param width the width of the viewport (whose height will be the same).
#' @param corner one of `c(0, 0)`, `c(1, 0)`, `c(0, 1)`, `c(1, 1)`, specifying the orientation of ternary objects to be drawn in the viewport.
#' @param scale a strictly positive number (usually greater than or equal to 1), to specify the size of the viewport relative to ternary objects drawn inside the viewport.  If the value is 1, then all ternary objects will have the same width and height as the viewport.
#' @param ... other arguments to be passed to [grid::viewport()].
#'
#' @return A viewport object.
#'
#' @details This is a simple wrapper for a call to [grid::viewport()], which produces a square viewport whose `xscale` and `yscale` components are determined by `corner` and `scale`.  Ternary plots can be drawn in such a viewport with one of four orientations, specified by the viewport corner towards which one of the ternary plot's vertices will point.  Ternary plots are drawn at a size specified by the reciprocal of `scale`, relative to the width of the viewport; the position of the centroid of the triangle remains fixed under scaling.  
#'
#' @examples
#' ## Two viewports that differ only in the value of `scale`.
#' ## The square boundary of both viewports is the same (shown in green).
#'
#' # The first viewport, oriented towards top right, is made through a call to tplot_new():
#' tplot_new(corner = c(1, 1))
#' grid::grid.rect(gp = grid::gpar(col = "green", lwd = 10))
#' grid::grid.draw(ternary_frame())
#' # The second viewport has the same orientation, corner = c(1, 1), but now scale > 1:
#' grid::pushViewport(ternary_viewport(corner = c(1, 1), scale = 1.2))
#' grid::grid.draw(ternary_frame(gp = grid::gpar(lty = "dashed")))
#' 
#' @author David Firth
#'
#' @export
#' 
ternary_viewport <- function(width = grid::unit(1, "snpc"),
                             corner = c(0, 0),
                             scale = 1,
                             
                             ...) {
    ## Some argument checks
    # if (!grid::is.unit(width)) stop("width must be a grid unit object")
    if (length(corner) != 2) stop("invalid corner specification")
    if (!all(corner %in% c(0, 1))) stop("invalid corner specification")
    if (scale <= 0) stop("scale must be a positive number")

    ## Make the transformation that reflects the corner and scale settings
    centroid <- as.numeric(ternary_xy(matrix(1/3, 1, 3))$x)
      ## the x (= y) coordinate of simplex centroid
    xsc <- ysc <- c(0, 1)  ## the default
    xsc <- xsc + corner[1] * c(1, -1)
    ysc <- ysc + corner[2] * c(1, -1)
    xsc <- centroid + (xsc - centroid) * scale
    ysc <- centroid + (ysc - centroid) * scale

    ## Make and return the viewport
    vp <- grid::viewport(width = width, height = width,
                         xscale = xsc, yscale = ysc, default.units = "native", ...)
    return(vp)
}
