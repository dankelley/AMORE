library(oce) # for imagep(), faster than image()
library(cmocean)

# Note that decimate=FALSE to avoid decimating
decimate <- FALSE
q <- 0.995 # quantile criterion for colourmap

data(coastlineWorldFine, package="ocedata")
if (!exists("emag2"))
    load("EMAG2_V3_20170530.rda") # emag2 holds lon, lat, sealevel and upcont

# Subset to Sudbury region
D <- 5
lon0 <- 360 - 80.9930
lat0 <- 46.4917
asp <- 1/cos(lat0*pi/180) # aspect ratio at plot centre
lonLimit <- lon0 + D * c(-1, 1)*asp
latLimit <- lat0 + D * c(-1, 1)
lonLook <- lonLimit[1] <= emag2$lon & emag2$lon <= lonLimit[2]
latLook <- latLimit[1] <= emag2$lat & emag2$lat <= latLimit[2]
lon <- emag2$lon[lonLook]
lat <- emag2$lat[latLook]
sealevel <- emag2$sealevel[lonLook, latLook]
upcont <- emag2$upcont[lonLook, latLook]

# There are some very high values (over 1000) so use quantile.
zscale <- quantile(abs(c(sealevel, upcont)), q, na.rm=TRUE)
print(range(c(sealevel,upcont),na.rm=TRUE))
cm <- colormap(zlim=zscale*c(-1,1), col=cmocean::cmocean("balance"))

# plot
if (!interactive()) png("upcont_sudbury.png",
    unit="in", width=7, height=6.67, res=300, pointsize=11)
imagep(lon, lat, upcont, colormap=cm, drawTriangles=TRUE,
    asp=asp, decimate=decimate)
lines(coastlineWorldFine[["longitude"]]+360, coastlineWorldFine[["latitude"]], lwd=1.8)
points(lon0, lat0, col="magenta", cex=3, lwd=2)
mtext("upcont")
if (!interactive()) dev.off()

