# Plot month-average co2 (built-in dataset), stacked by year

# what is the 'co2' dataset?
class(co2)
head(co2)

# what times corrspond to these values?
t <- as.numeric(time(co2))
head(t)

# let's chop it into one-year segments. We use floor()
# to get the next-lowest-integer, and break the time-series
# up into years that start in Jan and end in Dec

# step 1: devise a "cut" scheme.  This is the plan for subdivision.
tmin <- floor(min(t))
tmax <- 1 + floor(max(t))
tinc <- 1
tbreaks <- seq(tmin, tmax, tinc)
tcut <- cut(t, tbreaks)
# It is worth exploring tcut, before proceeding
str(tcut)

# Split the data up according to out 'tcut' scheme
co2split <- split(co2, tcut)
# Again, let's take a look at the contents
str(co2split)

# Now, for each element of 'co2split' (that is, for each year),
# compute the mean CO2 value.  The way to do this is to use
# lapply(), which is a fantastic friend to have, once you
# get acquainted with it.  The first parameter to lapply() is a
# list item, and the second parameter is the function to apply.
# So, we can compute yearly averages with
co2year <- lapply(co2split, mean)
# Let's explore it.
co2year
# Hm, it is a list.  We want to make it into a vector, so let's remove
# it's list property
co2year <- unlist(lapply(co2split, mean))
co2year
# Hm, it is now a vector, which we want, but I'm not sure we want the names,
# so let's remove them
co2year <- unname(unlist(lapply(co2split, mean)))
co2year

# OK, that's a recipe.  Let's do the same with time. I'm skipping
# some steps here.  You might want to break this up into pieces,
# as I've done above.
tyear <- unname(unlist(lapply(split(t, tcut), mean)))

# Finally, let's replot the data, with a red line for the yearly average.
if (!interactive())
    png("co2-year-average.png")
plot(co2)
lines(tyear, co2year, col=2)
if (!interactive())
    dev.off()
