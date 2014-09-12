#' 
## ------------------------------------------------------------------------
opts_chunk$set(warning=FALSE, message=FALSE)

#' 
#' # Loading ggplot
#' 
## ------------------------------------------------------------------------
library(ggplot2)

#' 
#' # Basic use with qplot
#' 
#' Load the sample data
#' 
## ------------------------------------------------------------------------
set.seed(1410)  # make the sample reproducible
head(diamonds)
dsmall <- diamonds[sample(nrow(diamonds), 100), ]

#' 
## ------------------------------------------------------------------------
qplot(carat, price, data=diamonds)

#' 
#' ## Color, size, shape and other aesthetic attributes
#' 
## ------------------------------------------------------------------------
qplot(carat, price, data=dsmall, color=color, shape=cut, alpha=I(1/2))

#' 
#' ## Plot geoms
#' 
## ------------------------------------------------------------------------
qplot(carat, price, data=dsmall, geom=c("point", "smooth"))

#' 
#' ### Adding a smoother
#' There are many different smoother that can be used with `method` argument.
#' 
## ------------------------------------------------------------------------
qplot(carat, price, data=dsmall, geom=c("point", "smooth"), method="lm")

#' 
#' ### Boxplots and jittered points
#' 
## ------------------------------------------------------------------------
qplot(color, price/carat, data=diamonds, geom="jitter")

#' 
## ------------------------------------------------------------------------
qplot(color, price/carat, data=diamonds, geom="boxplot")

#' 
#' ### Histogram and density plots
#' 
## ------------------------------------------------------------------------
qplot(carat, data=diamonds, geom="histogram", fill=color)

#' 
## ------------------------------------------------------------------------
qplot(carat, data=diamonds, geom="density", color=color)

#' 
#' Change the amount of smoothing with `binwidth` argument.
#' 
## ------------------------------------------------------------------------
qplot(carat, data=diamonds, geom="histogram", binwidth=1)
qplot(carat, data=diamonds, geom="histogram", binwidth=0.1)
qplot(carat, data=diamonds, geom="histogram", binwidth=0.01)

#' 
#' ### Bar charts
#' 
## ------------------------------------------------------------------------
qplot(color, data=diamonds, geom="bar")

#' 
## ------------------------------------------------------------------------
# bar plot of diamond color weighted by carat
qplot(color, data=diamonds, geom="bar", weight=carat) +
    scale_y_continuous("carat")

#' 
#' ### Time series
#' 
## ------------------------------------------------------------------------
head(economics)

#' 
## ------------------------------------------------------------------------
qplot(date, unemploy/pop, data=economics, geom="line")

#' 
#' ## Faceting
#' 
## ------------------------------------------------------------------------
qplot(carat, data=diamonds, facets=color~.,
      geom="histogram", binwidth=0.1, xlim=c(0,3))

#' 
#' ## Other options
#' - `xlim` and `ylim`: set limits for x- and y-axis (e.g. `xlim=c(0,20)`)
#' - `main`: main title for the plot
#' - `xlab` and `ylab`: labels for x- and y-axis
#' 
## ------------------------------------------------------------------------
qplot(carat, price, data=dsmall,
      xlab="Price ($)",
      ylab="Weight (carats)",
      main="Price-weight relationship")

#' 
