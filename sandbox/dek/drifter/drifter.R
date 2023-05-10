# Get drifter by ID

library(oce)
data(coastlineWorldFine, package="ocedata")
data(topoWorld)

ID <- "2300234063700990"
url <- paste0("http://osmc.noaa.gov/erddap/tabledap/gdp_interpolated_drifter.csv?ID%2Clongitude%2Clatitude%2Ctime%2Ctemp&ID=%2",
    ID, "%22")
if (!file.exists("drifter.csv"))
    download.file(url, "drifter.csv")
# Column names in row 1, units (skipped) in row 2.
names <- strsplit(readLines("drifter.csv", 1), ",")[[1]]
d <- read.csv("drifter.csv", skip=2, col.names=names)
lon <- d$longitude
lat <- d$latitude
t <- as.POSIXct(d$time, format="%Y-%m-%dT%H:%M:%S", tz="UTC")
col <- 1 + (as.integer(difftime(t, t[1], unit="weeks")))%%2
if (!interactive()) pdf("drifter.pdf", height=4.5)
plot(coastlineWorldFine, mar=c(2, 2, 2, 1), col="tan",
    clon=mean(range(d$longitude)),
    clat=mean(range(d$latitude)), span=2.0*diff(range(lat))*111)
points(lon, lat, col=col, pch=20, cex=0.5)
points(lon[1], lat[1], pch=1, cex=2)
text(lon[1], lat[1], "Start", pos=4)
n <- length(lon)
points(lon[n], lat[n], pch=2, cex=2)
text(lon[n], lat[n], "end", pos=4)
contour(topoWorld[["longitude"]], topoWorld[["latitude"]], -topoWorld[["z"]],
    level=1000*seq(1, 5), add=TRUE, labcex=0.9, col="darkblue")
mtext(paste("Drifter", ID), line=0.5)
if (!interactive()) dev.off()
