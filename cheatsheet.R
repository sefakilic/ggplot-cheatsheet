
## ------------------------------------------------------------------------
opts_chunk$set(warning=FALSE, message=FALSE, fig.width=w8, fig.height=3)


## ------------------------------------------------------------------------
library(ggplot2)


## ------------------------------------------------------------------------
set.seed(1410)  # make the sample reproducible
head(diamonds)
dsmall <- diamonds[sample(nrow(diamonds), 100), ]


## ------------------------------------------------------------------------
qplot(carat, price, data=diamonds)


## ------------------------------------------------------------------------
qplot(carat, price, data=dsmall, color=color, shape=cut, alpha=I(1/2))


## ------------------------------------------------------------------------
qplot(carat, price, data=dsmall, geom=c("point", "smooth"))


## ------------------------------------------------------------------------
qplot(carat, price, data=dsmall, geom=c("point", "smooth"), method="lm")


## ------------------------------------------------------------------------
qplot(color, price/carat, data=diamonds, geom="jitter")


## ------------------------------------------------------------------------
qplot(color, price/carat, data=diamonds, geom="boxplot")


## ------------------------------------------------------------------------
qplot(carat, data=diamonds, geom="histogram", fill=color)


## ------------------------------------------------------------------------
qplot(carat, data=diamonds, geom="density", color=color)


## ------------------------------------------------------------------------
qplot(carat, data=diamonds, geom="histogram", binwidth=1)
qplot(carat, data=diamonds, geom="histogram", binwidth=0.1)
qplot(carat, data=diamonds, geom="histogram", binwidth=0.01)


## ------------------------------------------------------------------------
qplot(color, data=diamonds, geom="bar")


## ------------------------------------------------------------------------
# bar plot of diamond color weighted by carat
qplot(color, data=diamonds, geom="bar", weight=carat) +
    scale_y_continuous("carat")


## ------------------------------------------------------------------------
head(economics)


## ------------------------------------------------------------------------
qplot(date, unemploy/pop, data=economics, geom="line")


## ------------------------------------------------------------------------
qplot(carat, data=diamonds, facets=color~.,
      geom="histogram", binwidth=0.1, xlim=c(0,3))


## ------------------------------------------------------------------------
qplot(carat, price, data=dsmall,
      xlab="Price ($)",
      ylab="Weight (carats)",
      main="Price-weight relationship")


## ------------------------------------------------------------------------
df <- data.frame(x=c(3, 1, 5), y=c(2, 4, 6), label=c("a", "b", "c"))
p <- ggplot(df, aes(x, y, label=label)) + xlab(NULL) + ylab(NULL)


## ------------------------------------------------------------------------
p + geom_point() + ggtitle("geom_point")


## ------------------------------------------------------------------------
p + geom_bar(stat="identity") + ggtitle("geom_bar(stat=\"identity\")")


## ------------------------------------------------------------------------
p + geom_line() + ggtitle("geom_line")


## ------------------------------------------------------------------------
p + geom_area() + ggtitle("geom_area")


## ------------------------------------------------------------------------
p + geom_path() + ggtitle("geom_path")


## ------------------------------------------------------------------------
p + geom_text() + ggtitle("geom_text")


## ------------------------------------------------------------------------
p + geom_tile() + ggtitle("geom_tile")


## ------------------------------------------------------------------------
p + geom_polygon() + ggtitle("geom_polygon")


## ------------------------------------------------------------------------
depth_dist <- ggplot(diamonds, aes(depth)) + xlim(58, 68)
depth_dist + geom_histogram()


## ------------------------------------------------------------------------
depth_dist + geom_histogram(aes(y = ..density..), binwidth=0.1) +
    facet_grid(cut ~ .)
depth_dist + geom_histogram(aes(fill=cut), binwidth=0.1, position="fill")
depth_dist + geom_freqpoly(aes(y = ..density.., color=cut), binwidth=0.1)


## ------------------------------------------------------------------------
qplot(cut, depth, data=diamonds, geom="boxplot")
library(plyr)
qplot(carat, depth, data=diamonds, geom="boxplot",
      group = round_any(carat, 0.1, floor), xlim=c(0, 3))


## ------------------------------------------------------------------------
qplot(class, cty, data=mpg, geom="jitter")
qplot(class, drv, data=mpg, geom="jitter")


## ------------------------------------------------------------------------
qplot(depth, data=diamonds, geom="density", xlim=c(54, 70))
qplot(depth, data=diamonds, geom="density", xlim=c(54, 70), fill=cut, alpha=I(0.2))


## ------------------------------------------------------------------------
df <- data.frame(x=rnorm(2000), y=rnorm(2000))
norm <- ggplot(df, aes(x, y))
norm + geom_point()
norm + geom_point(shape=1)
norm + geom_point(shape = ".")          # pixel-sized


## ------------------------------------------------------------------------
library(scales)
norm + geom_point(color=alpha("black", 1/3))
norm + geom_point(color=alpha("black", 1/5))
norm + geom_point(color=alpha("black", 1/10))


## ------------------------------------------------------------------------
td <- ggplot(diamonds, aes(table, depth)) + xlim(50, 70) + ylim(50, 70)
td + geom_point()
td + geom_jitter()
jit <- position_jitter(width=0.5)
td + geom_jitter(position=jit)
td + geom_jitter(position=jit, color=alpha("black", 1/10))
td + geom_jitter(position=jit, color=alpha("black", 1/50))
td + geom_jitter(position=jit, color=alpha("black", 1/200))


## ------------------------------------------------------------------------
library(maps)
data(us.cities)
big_cities <- subset(us.cities, pop>500000)
qplot(long, lat, data=big_cities) + borders("state", size=0.5)


## ------------------------------------------------------------------------
states <- map_data("state")
arrests <- USArrests
names(arrests) <- tolower(names(arrests))
arrests$region <- tolower(rownames(USArrests))

choro <- merge(states, arrests, by="region")
# reorder the rows because order matters when drawing polygons and merge
# destroys the original ordering
choro <- choro[order(choro$order), ]
qplot(long, lat, data=choro, group=group, fill=assault, geom="polygon")
qplot(long, lat, data=choro, group=group, fill=assault/murder, geom="polygon")


