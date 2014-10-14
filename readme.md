ggplot-cheatsheet
=================

cheatsheet for [ggplot2](http://ggplot2.org/), compiled mostly from the book,
[ggplot2: Elegant Graphics for Data Analysis](http://www.amazon.com/dp/0387981403/ref=cm_sw_su_dp?tag=ggplot2-20)

Documentation for ggplot is available [here](http://docs.ggplot2.org/current/index.html).

**Table of Contents** 

- [Loading ggplot](#loading-ggplot)
- [Basic use with qplot](#basic-use-with-qplot)
  - [Color, size, shape and other aesthetic attributes](#color-size-shape-and-other-aesthetic-attributes)
  - [Plot geoms](#plot-geoms)
    - [Adding a smoother](#adding-a-smoother)
    - [Boxplots and jittered points](#boxplots-and-jittered-points)
    - [Histogram and density plots](#histogram-and-density-plots)
    - [Bar charts](#bar-charts)
    - [Time series](#time-series)
  - [Faceting](#faceting)
  - [Other options](#other-options)
- [Build a plot layer by layer](#build-a-plot-layer-by-layer)
  - [Basic plot types](#basic-plot-types)
    - [`geom_point`](#geom_point)
    - [`geom_bar`](#geom_bar)
    - [`geom_line`](#geom_line)
    - [`geom_area`](#geom_area)
    - [`geom_path`](#geom_path)
    - [`geom_text`](#geom_text)
    - [`geom_tile`](#geom_tile)
    - [`geom_polygon`](#geom_polygon)
  - [Displaying distributions](#displaying-distributions)
    - [`geom_histogram` and `geom_freqpoly`](#geom_histogram-and-geom_freqpoly)
    - [`geom_boxplot`](#geom_boxplot)
    - [`geom_jitter`](#geom_jitter)
    - [`geom_density`](#geom_density)
  - [Deal with overplotting](#deal-with-overplotting)
  - [Surface plots](#surface-plots)
  - [Drawing maps](#drawing-maps)
    - [[Choropleth map](http://en.wikipedia.org/wiki/Choropleth_map)](#choropleth-maphttpenwikipediaorgwikichoropleth_map)
  - [Annotating a plot](#annotating-a-plot)
- [Faceting](#faceting-1)
  - [Facet grid](#facet-grid)
    - [Margins](#margins)
  - [Facet wrap](#facet-wrap)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->



```r
opts_chunk$set(warning=FALSE, message=FALSE, fig.width=8, fig.height=4)
```

# Loading ggplot


```r
library(ggplot2)
```

# Basic use with qplot

Load the sample data


```r
set.seed(1410)  # make the sample reproducible
head(diamonds)
```

```
##   carat       cut color clarity depth table price    x    y    z
## 1  0.23     Ideal     E     SI2  61.5    55   326 3.95 3.98 2.43
## 2  0.21   Premium     E     SI1  59.8    61   326 3.89 3.84 2.31
## 3  0.23      Good     E     VS1  56.9    65   327 4.05 4.07 2.31
## 4  0.29   Premium     I     VS2  62.4    58   334 4.20 4.23 2.63
## 5  0.31      Good     J     SI2  63.3    58   335 4.34 4.35 2.75
## 6  0.24 Very Good     J    VVS2  62.8    57   336 3.94 3.96 2.48
```

```r
dsmall <- diamonds[sample(nrow(diamonds), 100), ]
```


```r
qplot(carat, price, data=diamonds)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

## Color, size, shape and other aesthetic attributes


```r
qplot(carat, price, data=dsmall, color=color, shape=cut, alpha=I(1/2))
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

## Plot geoms


```r
qplot(carat, price, data=dsmall, geom=c("point", "smooth"))
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 

### Adding a smoother
There are many different smoother that can be used with `method` argument.


```r
qplot(carat, price, data=dsmall, geom=c("point", "smooth"), method="lm")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 

### Boxplots and jittered points


```r
qplot(color, price/carat, data=diamonds, geom="jitter")
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 


```r
qplot(color, price/carat, data=diamonds, geom="boxplot")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 

### Histogram and density plots


```r
qplot(carat, data=diamonds, geom="histogram", fill=color)
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 


```r
qplot(carat, data=diamonds, geom="density", color=color)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 

Change the amount of smoothing with `binwidth` argument.


```r
qplot(carat, data=diamonds, geom="histogram", binwidth=1)
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-121.png) 

```r
qplot(carat, data=diamonds, geom="histogram", binwidth=0.1)
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-122.png) 

```r
qplot(carat, data=diamonds, geom="histogram", binwidth=0.01)
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-123.png) 

### Bar charts


```r
qplot(color, data=diamonds, geom="bar")
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 


```r
# bar plot of diamond color weighted by carat
qplot(color, data=diamonds, geom="bar", weight=carat) +
    scale_y_continuous("carat")
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14.png) 

### Time series


```r
head(economics)
```

```
##         date   pce    pop psavert uempmed unemploy
## 1 1967-06-30 507.8 198712     9.8     4.5     2944
## 2 1967-07-31 510.9 198911     9.8     4.7     2945
## 3 1967-08-31 516.7 199113     9.0     4.6     2958
## 4 1967-09-30 513.3 199311     9.8     4.9     3143
## 5 1967-10-31 518.5 199498     9.7     4.7     3066
## 6 1967-11-30 526.2 199657     9.4     4.8     3018
```


```r
qplot(date, unemploy/pop, data=economics, geom="line")
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16.png) 

## Faceting


```r
qplot(carat, data=diamonds, facets=color~.,
      geom="histogram", binwidth=0.1, xlim=c(0,3))
```

![plot of chunk unnamed-chunk-17](figure/unnamed-chunk-17.png) 

## Other options
- `xlim` and `ylim`: set limits for x- and y-axis (e.g. `xlim=c(0,20)`)
- `main`: main title for the plot
- `xlab` and `ylab`: labels for x- and y-axis


```r
qplot(carat, price, data=dsmall,
      xlab="Price ($)",
      ylab="Weight (carats)",
      main="Price-weight relationship")
```

![plot of chunk unnamed-chunk-18](figure/unnamed-chunk-18.png) 

# Build a plot layer by layer

More complicated, multi-layer plots can be generated using `ggplot()`.

## Basic plot types


```r
df <- data.frame(x=c(3, 1, 5), y=c(2, 4, 6), label=c("a", "b", "c"))
p <- ggplot(df, aes(x, y, label=label)) + xlab(NULL) + ylab(NULL)
```

### `geom_point`

```r
p + geom_point() + ggtitle("geom_point")
```

![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-20.png) 

### `geom_bar`

```r
p + geom_bar(stat="identity") + ggtitle("geom_bar(stat=\"identity\")")
```

![plot of chunk unnamed-chunk-21](figure/unnamed-chunk-21.png) 

### `geom_line`

```r
p + geom_line() + ggtitle("geom_line")
```

![plot of chunk unnamed-chunk-22](figure/unnamed-chunk-22.png) 

### `geom_area`

```r
p + geom_area() + ggtitle("geom_area")
```

![plot of chunk unnamed-chunk-23](figure/unnamed-chunk-23.png) 

### `geom_path`

```r
p + geom_path() + ggtitle("geom_path")
```

![plot of chunk unnamed-chunk-24](figure/unnamed-chunk-24.png) 

### `geom_text`

```r
p + geom_text() + ggtitle("geom_text")
```

![plot of chunk unnamed-chunk-25](figure/unnamed-chunk-25.png) 

### `geom_tile`

```r
p + geom_tile() + ggtitle("geom_tile")
```

![plot of chunk unnamed-chunk-26](figure/unnamed-chunk-26.png) 

### `geom_polygon`

```r
p + geom_polygon() + ggtitle("geom_polygon")
```

![plot of chunk unnamed-chunk-27](figure/unnamed-chunk-27.png) 

## Displaying distributions

For 1d data, the geom is the histogram.

### `geom_histogram` and `geom_freqpoly`


```r
depth_dist <- ggplot(diamonds, aes(depth)) + xlim(58, 68)
depth_dist + geom_histogram()
```

![plot of chunk unnamed-chunk-28](figure/unnamed-chunk-28.png) 

To compare the distribution between groups, couple of options


```r
depth_dist + geom_histogram(aes(y = ..density..), binwidth=0.1) +
    facet_grid(cut ~ .)
```

![plot of chunk unnamed-chunk-29](figure/unnamed-chunk-291.png) 

```r
depth_dist + geom_histogram(aes(fill=cut), binwidth=0.1, position="fill")
```

![plot of chunk unnamed-chunk-29](figure/unnamed-chunk-292.png) 

```r
depth_dist + geom_freqpoly(aes(y = ..density.., color=cut), binwidth=0.1)
```

![plot of chunk unnamed-chunk-29](figure/unnamed-chunk-293.png) 

### `geom_boxplot`


```r
qplot(cut, depth, data=diamonds, geom="boxplot")
```

![plot of chunk unnamed-chunk-30](figure/unnamed-chunk-301.png) 

```r
library(plyr)
qplot(carat, depth, data=diamonds, geom="boxplot",
      group = round_any(carat, 0.1, floor), xlim=c(0, 3))
```

![plot of chunk unnamed-chunk-30](figure/unnamed-chunk-302.png) 

### `geom_jitter`


```r
qplot(class, cty, data=mpg, geom="jitter")
```

![plot of chunk unnamed-chunk-31](figure/unnamed-chunk-311.png) 

```r
qplot(class, drv, data=mpg, geom="jitter")
```

![plot of chunk unnamed-chunk-31](figure/unnamed-chunk-312.png) 

### `geom_density`


```r
qplot(depth, data=diamonds, geom="density", xlim=c(54, 70))
```

![plot of chunk unnamed-chunk-32](figure/unnamed-chunk-321.png) 

```r
qplot(depth, data=diamonds, geom="density", xlim=c(54, 70), fill=cut, alpha=I(0.2))
```

![plot of chunk unnamed-chunk-32](figure/unnamed-chunk-322.png) 

## Deal with overplotting

- Make the points smaller


```r
df <- data.frame(x=rnorm(2000), y=rnorm(2000))
norm <- ggplot(df, aes(x, y))
norm + geom_point()
```

![plot of chunk unnamed-chunk-33](figure/unnamed-chunk-331.png) 

```r
norm + geom_point(shape=1)
```

![plot of chunk unnamed-chunk-33](figure/unnamed-chunk-332.png) 

```r
norm + geom_point(shape = ".")          # pixel-sized
```

![plot of chunk unnamed-chunk-33](figure/unnamed-chunk-333.png) 

- Use alpha blending


```r
library(scales)
norm + geom_point(color=alpha("black", 1/3))
```

![plot of chunk unnamed-chunk-34](figure/unnamed-chunk-341.png) 

```r
norm + geom_point(color=alpha("black", 1/5))
```

![plot of chunk unnamed-chunk-34](figure/unnamed-chunk-342.png) 

```r
norm + geom_point(color=alpha("black", 1/10))
```

![plot of chunk unnamed-chunk-34](figure/unnamed-chunk-343.png) 

- Randomly jitter if there is some discreteness


```r
td <- ggplot(diamonds, aes(table, depth)) + xlim(50, 70) + ylim(50, 70)
td + geom_point()
```

![plot of chunk unnamed-chunk-35](figure/unnamed-chunk-351.png) 

```r
td + geom_jitter()
```

![plot of chunk unnamed-chunk-35](figure/unnamed-chunk-352.png) 

```r
jit <- position_jitter(width=0.5)
td + geom_jitter(position=jit)
```

![plot of chunk unnamed-chunk-35](figure/unnamed-chunk-353.png) 

```r
td + geom_jitter(position=jit, color=alpha("black", 1/10))
```

![plot of chunk unnamed-chunk-35](figure/unnamed-chunk-354.png) 

```r
td + geom_jitter(position=jit, color=alpha("black", 1/50))
```

![plot of chunk unnamed-chunk-35](figure/unnamed-chunk-355.png) 

```r
td + geom_jitter(position=jit, color=alpha("black", 1/200))
```

![plot of chunk unnamed-chunk-35](figure/unnamed-chunk-356.png) 

## Surface plots

## Drawing maps


```r
library(maps)
data(us.cities)
big_cities <- subset(us.cities, pop>500000)
qplot(long, lat, data=big_cities) + borders("state", size=0.5)
```

![plot of chunk unnamed-chunk-36](figure/unnamed-chunk-36.png) 

### [Choropleth map](http://en.wikipedia.org/wiki/Choropleth_map)

```r
states <- map_data("state")
arrests <- USArrests
names(arrests) <- tolower(names(arrests))
arrests$region <- tolower(rownames(USArrests))

choro <- merge(states, arrests, by="region")
# reorder the rows because order matters when drawing polygons and merge
# destroys the original ordering
choro <- choro[order(choro$order), ]
qplot(long, lat, data=choro, group=group, fill=assault, geom="polygon")
```

![plot of chunk unnamed-chunk-37](figure/unnamed-chunk-371.png) 

```r
qplot(long, lat, data=choro, group=group, fill=assault/murder, geom="polygon")
```

![plot of chunk unnamed-chunk-37](figure/unnamed-chunk-372.png) 

## Annotating a plot

Just extra data

- adding one at a time
- many at once


```r
unemp <- qplot(date, unemploy, data=economics, geom="line",
               xlab="", ylab="No. unemployed (1000s)")

presidential <- presidential[-(1:3), ]

yrng <- range(economics$unemploy) 
xrng <- range(economics$date)
unemp + geom_vline(aes(xintercept=as.numeric(start)), data=presidential)
```

![plot of chunk unnamed-chunk-38](figure/unnamed-chunk-381.png) 

```r
unemp + geom_rect(aes(NULL, NULL, xmin=start, xmax=end, fill=party),
                  ymin=yrng[1], ymax=yrng[2], data=presidential) +
    scale_fill_manual(values=alpha(c("blue", "red"), 0.2))
```

![plot of chunk unnamed-chunk-38](figure/unnamed-chunk-382.png) 

```r
last_plot() + geom_text(aes(x=start, y=yrng[1], label=name),
                        data=presidential, size=3, hjust=0, vjust=0)
```

![plot of chunk unnamed-chunk-38](figure/unnamed-chunk-383.png) 

```r
caption <- paste(strwrap("Unemployment rates in the US have varied
alot over the years", 40), collapse="\n")
unemp + geom_text(aes(x, y, label=caption),
                  data=data.frame(x=xrng[2], y=yrng[2]),
                  hjust=1, vjust=1, size=4)
```

![plot of chunk unnamed-chunk-38](figure/unnamed-chunk-384.png) 

```r
highest <- subset(economics, unemploy==max(unemploy))
unemp + geom_point(data=highest, size=3, color=alpha("red", 0.3))
```

![plot of chunk unnamed-chunk-38](figure/unnamed-chunk-385.png) 

# Faceting

## Facet grid


```r
qplot(cty, hwy, data=mpg) + facet_grid(. ~ cyl)
```

![plot of chunk unnamed-chunk-39](figure/unnamed-chunk-391.png) 

```r
qplot(cty, data=mpg, geom="histogram", binwidth=2) + facet_grid(cyl ~ .)
```

![plot of chunk unnamed-chunk-39](figure/unnamed-chunk-392.png) 

```r
qplot(cty, hwy, data=mpg) + facet_grid(drv ~ cyl)
```

![plot of chunk unnamed-chunk-39](figure/unnamed-chunk-393.png) 

### Margins


```r
p <- qplot(displ, hwy, data=mpg) + geom_smooth(method="lm", se=F)
p + facet_grid(cyl ~ drv)
```

![plot of chunk unnamed-chunk-40](figure/unnamed-chunk-401.png) 

```r
p + facet_grid(cyl ~ drv, margins=T)
```

![plot of chunk unnamed-chunk-40](figure/unnamed-chunk-402.png) 

## Facet wrap


```r
library(plyr)
movies$decade <- round_any(movies$year, 10, floor)
qplot(rating, ..density.., data=subset(movies, decade > 1890),
      geom="histogram", binwidth=0.5) +
    facet_wrap(~ decade, ncol=6)
```

![plot of chunk unnamed-chunk-41](figure/unnamed-chunk-41.png) 

