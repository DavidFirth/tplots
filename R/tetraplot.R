#' Make a tetraplot grob
#'
#' @description The four faces of a tetrahedron are used in order to display 4-part compositions.
#' @param nby4 a 4-column numeric matrix.  Each row represents one point to be plotted.  Rows will be scaled to sum to 1 before plotting, so no row can contain only zeros.
#' @param neg_action a character string, either `"warning"` or `"error"`; or `NULL` if no checking of negative values is wanted.  This provides optional checking for negative values in the `nby4` matrix.
#' @param perm a permutation of the integers `1:4`, to specify which face relates to which columns of the `nby4` matrix.  The first 3 elements of the permitation will be the colunns used for the corner face, and the other faces follow from that.
#' @param type currently always `"top3"`, meaning that each point is displayed in the face that corresponds to its 3 largest components (or the first such face in the event of a tie).
#' @param scale a scalar to specify by what factor each ternary face should be scaled down.
#' @param vertex_labels either a vector of 4 text labels for the vertices of the ternary faces, or `NULL`.
#' @param labels_gp graphical parameters for vertex labels, specified via `grid::gpar()`.
#' @param points_gp graphical parameters for `ternary_points()`, specified via `grid::gpar()`.
#' @param thirds either `NULL` or a 4-vector of background colours to be used in calls to `ternary_thirds()`.
#' @param thirds_gp other graphical parameters for `ternary_thirds()`, specified via `grid::gpar()`
#' @param ... other arguments to pass to the viewport/grob constructor functions.
#'
#' @return a grob of class `gTree`.
#'
#' @details When the resulting object is drawn, the viewport should be square.  This is not checked.
#'
#' @examples
#'
#' ## The tetraplot for England, as shown in the file "poster.pdf"
#' 
#' data(UK_GE_2024)
#'
#' ## Focus on the top 4 parties in terms of vote shares in England
#' parties <- c("Con", "Lab", "LD", "RUK")
#' England <- UK_GE_2024[UK_GE_2024 $ Country.name == "England",
#'                       c("Constituency.name", "Country.name", "First.party", parties)]
#' row.names(England) <- England $ Constituency.name
#' ## Remove the Speaker's seat
#' England <- England[rownames(England) != "Chorley", ]
#' ## Sort the rows so that seats won by main parties will get plotted first
#' England <- England[order(match(England $ First.party,
#'                                c("Con", "Lab", "LD", "RUK", "Green", "Ind"))), ]
#' 
#' ## Focus on the vote shares across the top 4 parties
#' England_four_party_shares <- England[, parties[1:4]]
#' England_four_party_shares <- round(
#'     100 * England_four_party_shares / rowSums(England_four_party_shares),
#'     2)
#' England_four_party_shares <- as.matrix(England_four_party_shares)
#' 
#' ## Set up coloured backgrounds
#' paleLD <- "#fddba3"
#' palered <- "#FFcccc"
#' paleblue <- "#a8ddff"
#' palecyan <- "#cbf4fa"
#' party_backgrounds <- c(paleblue, palered, paleLD, palecyan)
#' 
#' ## Set up colours for the plotted points
#' winner_names <- c("Con", "Lab", "LD", "RUK", "Green", "Ind")
#' winner_colours <- c("#0087DC", "#E4003B", "#FAA61A", "cyan", "limegreen", "white")
#' names(winner_colours) <- winner_names
#' point_colours <- winner_colours[England $ First.party]
#' 
#' ## Draw the tetraplot
#' the_plot <- tetraplot(England_four_party_shares,
#'                       perm = c(2, 4, 1, 3),
#'                       labels_gp = grid::gpar(fontsize = 14),
#'                       thirds = party_backgrounds,
#'                       thirds_gp = grid::gpar(col = "transparent"),
#'                       points_gp = grid::gpar(fill = point_colours),
#'                       pch = 21, size = grid::unit(0.6, "char"))
#' 
#' ## Make the legend
#' legend_vp <- grid::viewport(x = 0.85, y = 0.4, width = 0.15, height = 0.2)
#' legend <- grid::gList(
#'     grid::legendGrob(paste(winner_names, "won"), pch = 21, vgap = 0.8,
#'                gp = grid::gpar(fill = winner_colours), vp = legend_vp),
#'     grid::rectGrob(vp = legend_vp))
#' 
#' ## Make some other text to use
#' headlines <- grid::gList(
#'     grid::textGrob("England", gp = grid::gpar(fontsize = 50), just = "right",
#'                   vp = grid::viewport(x = 0.95, y = 0.2, width = 0.5, height = 0.2)),
#'     grid::textGrob("542 constituencies", gp = grid::gpar(fontsize = 20), just = "right",
#'                   vp = grid::viewport(x = 0.949, y = 0.14, width = 0.5, height = 0.2)),
#'     grid::textGrob("(excludes the Speaker's seat)", gp = grid::gpar(fontsize = 14), just = "right",
#'              vp = grid::viewport(x = 0.949, y = 0.11, width = 0.5, height = 0.2))
#' )
#' ## Finally, draw everything on the current graphics device
#' tplot_new(scale = 1.1, corner = c(0, 1))
#' grid::grid.draw(the_plot)
#' grid::grid.draw(legend)
#' grid::grid.draw(headlines)
#'
#' @export
#' 

tetraplot <- function(nby4, neg_action = "warning", perm = 1:4,
                      type = "top3",
                      scale = 1.1,
                      vertex_labels = colnames(nby4),
                      labels_gp = grid::gpar(),
                      points_gp = grid::gpar(),
                      thirds = NULL,
                      thirds_gp = grid::gpar(),
                      ...){
    
    ## Checking of arguments, and handling NULL values
    ## check neg_action
    ## check nby4
    ## check perm
    ## check include
    ## check points_col
    ## check bg_col


    nby4 <- nby4[, perm]
    if (!is.null(thirds)) thirds <- thirds[perm]


## Make a 4 by 3 matrix of column selections (and associated face labels)
    faces <- matrix(
        c(4, 3, 2,  # omit 1
          3, 4, 1,  # omit 2
          2, 1, 4,  # omit 3
          1, 2, 3), # omit 4
        4, 3, byrow = TRUE)

    ## Allocate each point to one of the faces
    omit <- apply(nby4, 1, which.min)
    
    ## Make a viewport for each face
    tan15 <- tan(pi / 12)
    vp <- list(rep(NULL, 4))
    vp[[1]] <- ternary_viewport(
        x = (tan15 + 0.5)/2,
        y = (tan15 + 0.5)/2,
        width = 0.5,
        scale = scale,
        corner = c(1, 1))
    vp[[2]] <- ternary_viewport(
        x = 0.75,
        y = (tan15 + 0.5)/2,
        width = 0.5,
        scale = scale)
    vp[[3]] <- ternary_viewport(
        x = (tan15 + 0.5)/2,
        y = 0.75,
        width = 0.5,
        scale = scale)
    vp[[4]] <- ternary_viewport(
        x = 0.25,
        y = 0.25,
        width = 0.5,
        scale = scale)

    the_plot <- list(rep(NULL, 4))
    for (i in 1:4) {
        the_plot[[i]] <- grid::gList(
            thirds = {
                if (is.null(thirds)) NULL
                else ternary_thirds(vp = vp[[i]],
                                    fill = thirds[faces[i,]],
                                    gp = thirds_gp)
            },
            points = {
                if (any(omit == i)) {
                    ternary_points(nby4[omit == i, faces[i,], drop = FALSE],
                                   neg_action = neg_action,
                                   gp = subset(points_gp, omit == i),
                                   vp = vp[[i]], ...)}})
    }
    if (!is.null(vertex_labels)) {
        vertex_labels <- ternary_text(c(rep(vertex_labels[1], 3),
                                        vertex_labels[2:4]),
                                      matrix(c(1, 0, 0,
                                               0, 1, 0,
                                               0, 0, 1,
                                               0.51, 0.51, -0.02,
                                               0.51, -0.02, 0.51,
                                               -0.02, 0.51, 0.51),
                                             6, 3, byrow = TRUE),
                                      neg_action = NULL,
                                      gp = labels_gp)
        the_plot[[5]] <- vertex_labels
    }
    do.call(grid::grobTree, the_plot)
}

