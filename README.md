# tplots
R package for making ternary plots and tetraplots.

### In development

This package is still very much a work in progress.  Please file bug reports and feature requests in the "issues" section on GitHub.

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

A bit more on the motivation can be found in the file [`poster.pdf`](https://github.com/DavidFirth/tplots/blob/main/poster.pdf), which is a poster presentation for the Royal Statistical Society conference in Edinburgh, September 2025.  The data used in that poster are vote counts at the UK General Election of July 2024; the dataset is included in the _tplots_ package, and example code for drawing the ternary plots and tetraplots can be found in _R_ via `?UK_GE_2024` and `?tetraplot`.  The example code can be executed in _R_ in the usual way once the package has been installed, i.e., via `example(tetraplot)` or `example(UK_GE_2024)`.

## License

MIT license.  Please see the file `LICENSE.md` for details.

## Please cite

If you use this package in your own project, please cite appropriately.  For example,
* Firth, D (2025).  Package _tplots_.  At [https://github.com/DavidFirth/tplots](https://github.com/DavidFirth/tplots).
