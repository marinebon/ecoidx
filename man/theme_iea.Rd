% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot.R
\name{theme_iea}
\alias{theme_iea}
\title{Plotting theme for IEA}
\usage{
theme_iea(
  base_size = 14,
  base_family = "",
  base_line_size = base_size/28,
  base_rect_size = base_size/28
)
}
\arguments{
\item{base_size}{base font size, given in pts.}

\item{base_family}{base font family}

\item{base_line_size}{base size for line elements}

\item{base_rect_size}{base size for rect elements}
}
\value{

}
\description{
Derived from \code{ggplot2::\link[ggplot2]{theme_classic}()},
a classic-looking theme with x and y axis lines and no gridlines.
Additionally dropped x and y axis labels, reduced plot margin.
}
\examples{
library(ggplot2)

# default ggplot2 theme
plot_ts(ts1) + theme_gray()

# slimmed down ggplot2 theme
plot_ts(ts1) + theme_classic()

# this custom IEA theme, the default theme to plot_ts()
plot_ts(ts1, theme_plot = theme_iea)
}
\concept{plot}
