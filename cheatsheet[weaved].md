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
set.seed(1410)                          # make the sample reproducible
dsmall <- diamonds[sample(nrow(diamonds), 100), ]
```

## Basic use (qplot)


```r
qplot(carat, price, data=diamonds)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 
