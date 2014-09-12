# ggplot2 cheatsheet

## Loading ggplot


```r
library(ggplot2)
```

```
## Loading required package: methods
```

## Loading sample data


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

## Basic use (qplot)


```r
qplot(carat, price, data=diamonds)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

## Color, size, shape and other aesthetic attributes


```r
qplot(carat, price, data=dsmall, color=color, shape=cut, alpha=I(1/2))
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

## Plot geoms


```r
qplot(carat, price, data=dsmall, geom=c("point", "smooth"))
```

```
## geom_smooth: method="auto" and size of largest group is <1000, so using loess. Use 'method = x' to change the smoothing method.
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

### Adding a smoother
There are many different smoother that can be used with `method` argument.


```r
qplot(carat, price, data=dsmall, geom=c("point", "smooth"), method="lm")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 

### Boxplots and jittered points


```r
qplot(color, price/carat, data=diamonds, geom="jitter")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


```r
qplot(color, price/carat, data=diamonds, geom="boxplot")
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 

### Histogram and density plots


```r
qplot(carat, data=diamonds, geom="histogram")
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


```r
qplot(carat, data=diamonds, geom="density")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 

Change the amount of smoothing with `binwidth` argument.


```r
qplot(carat, data=diamonds, geom="histogram", binwidth=1)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-111.png) 

```r
qplot(carat, data=diamonds, geom="histogram", binwidth=0.1)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-112.png) 

```r
qplot(carat, data=diamonds, geom="histogram", binwidth=0.01)
```

```
## Warning: position_stack requires constant width: output may be incorrect
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-113.png) 
