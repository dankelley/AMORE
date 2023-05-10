# Read csv (which takes 530 seconds to load, consuming 14.8 GB memory) and
# resave as rda (which takes 7.9 seconds to load, consuming 2.7 GB memory).

f <- "EMAG2_V3_20170530.csv"
names <- c("i","j","lon","lat","sealevel","upcont","code","error")
d <- read.csv(f, header=FALSE, col.names=names)

# Ensure that we have all the data, producing an error and stopping, otherwise.
N <- nrow(d)
imax <- range(d$i)[2]
jmax <- range(d$j)[2]
stopifnot(2*jmax == imax)

# Create lon, lat and data matrices
lon <- seq(min(d$lon), max(d$lon), length.out=imax)
lat <- seq(min(d$lat), max(d$lat), length.out=jmax)
sealevel <- matrix(d$sealevel, ncol=jmax) # dim=10800 5400
sealevel[sealevel ==  99999] <- NA
upcont <- matrix(d$upcont, ncol=jmax)
upcont[upcont ==  99999] <- NA
emag2 <- list(lon=lon, lat=lat, sealevel=sealevel, upcont=upcont)
save(emag2, file="EMAG2_V3_20170530.rda")

