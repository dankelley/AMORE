# View near Nova Scotia
# Note that decimate=FALSE to avoid decimating
decimate <- FALSE

library(oce) # for imagep(), faster than image()
data(coastlineWorldFine, package="ocedata")
data(topoWorld)
load("EMAG2_V3_20170530.rda") # emag2 holds lon, lat, sealevel and upcont

# Subset to Nova Scotia region
asp <- 1/cos(45*pi/180) # aspect ratio at 45N
D <- 10
lonLimit <- 360 + (-63 + D * c(-1, 1)*asp)
latLimit <- 45 + D * c(-1, 1)
lonLook <- lonLimit[1] <= emag2$lon & emag2$lon <= lonLimit[2]
latLook <- latLimit[1] <= emag2$lat & emag2$lat <= latLimit[2]
lon <- emag2$lon[lonLook]
lat <- emag2$lat[latLook]
sealevel <- emag2$sealevel[lonLook, latLook]
upcont <- emag2$upcont[lonLook, latLook]

# plot
if (!interactive()) png("sealevel_ns_monochrome.png",
    unit="in", width=7, height=6.67, res=1000, pointsize=9)
imagep(lon, lat, sealevel,
    asp=asp, decimate=decimate, drawTriangles=TRUE,
    zlim=quantile(sealevel, c(0.01, 0.99), na.rm=TRUE))
contour(topoWorld[["longitude"]]+360, topoWorld[["latitude"]], -topoWorld[["z"]], level=200, add=TRUE)
lines(coastlineWorldFine[["longitude"]]+360, coastlineWorldFine[["latitude"]],
    col="magenta", lwd=2)
points(360-(64+13/60), 42+53/60, col="magenta", cex=3, lwd=2) # Montagnais crater
mtext("sealevel")
if (!interactive()) dev.off()

if (!interactive()) png("upcont_ns_monochrome.png",
    unit="in", width=7, height=6.67, res=1000, pointsize=9)
imagep(lon, lat, upcont,
    asp=asp, decimate=decimate, drawTriangles=TRUE,
    zlim=quantile(upcont, c(0.01, 0.99), na.rm=TRUE))
contour(topoWorld[["longitude"]]+360, topoWorld[["latitude"]], -topoWorld[["z"]], level=200, add=TRUE)
lines(coastlineWorldFine[["longitude"]]+360, coastlineWorldFine[["latitude"]],
    col="magenta", lwd=2)
points(360-(64+13/60), 42+53/60, col="magenta", cex=3, lwd=2) # Montagnais crater
mtext("upcont")
if (!interactive()) dev.off()

