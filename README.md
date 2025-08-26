# tplots
R package for making ternary plots and tetraplots.

## Installation
With one or other of the CRAN packages `remotes` or `devtools` already installed: in an _R_ session, you can do either
```
remotes::install_github("DavidFirth/tplots")
```
or
```
devtools::install_github("DavidFirth/tplots")
```

## Motivation

This fairly small package exists mainly to facilitate the drawing of _tetraplots_, which are graphs that extend the familiar idea of a _ternary plot_ from 3-part compositions to 4-part compositions.  An incidental benefit is that the package can also be used to draw ternary plots.  While there are plenty of other _R_ packages already for drawing ternary plots, the approach taken here is different
* the `grid` graphics package (included in most installations of _R_) is used throughout, and this results in substantial flexibility
* all ternary-plot triangles are drawn in such a way (i.e., at such an angle) that their width and height are equal.  The resulting square footprint of ternary plots made via _tplots_ is very helpful for the construction of tetraplots (and likely also for some other purposes, such as matrices of ternary plots).

A bit more on the motivation can be found in the file `poster.pdf`, which is a poster presentation made at the Royal Statistical Society conference in Edinburgh, September 2025.
