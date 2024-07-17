library(oce)
lon <- runif(100, 0, 360)
lat <- runif(100, -90, 90)
plot(lon, lat)
data("coastlineWorld")
?`coastline-class`
plot(coastlineWorld)
plot(lon, lat)
?plot
plot(lon, lat, asp=5)
plot(coastlineWorld)
data(argo)
lon <- argo[['longitude']]
lat <- argo[['latitude']]
plot(lon, lat)
plot(coastlineWorld)
points(lon, lat)
plot(coastlineWorld)
points(lon, lat, cex=0.2)
locator(1)
plot(coastlineWorld, clongitude=-42, clatitude=56)
plot(coastlineWorld, clongitude=-42, clatitude=56, span=10)
plot(coastlineWorld, clongitude=-42, clatitude=56, span=100)
plot(coastlineWorld, clongitude=-42, clatitude=56, span=1000)
plot(coastlineWorld, clongitude=-42, clatitude=56, span=10000)
plot(coastlineWorld, clongitude=-42, clatitude=56, span=5000)
plot(coastlineWorld, clongitude=-42, clatitude=80, span=5000)
plot(coastlineWorld, clongitude=-42, clatitude=70, span=5000)
plot(coastlineWorld, clongitude=-42, clatitude=70, span=5000)
points(lon, lat)
data("topoWorld")
?contour
oceContour(topoWorld)
?oceContour
oceContour(topoWorld[['longitude']], topoWorld[['latitude']], topoWorld[['z']])
plot(coastlineWorld, clongitude=-42, clatitude=70, span=5000)
points(lon, lat)
oceContour(topoWorld[['longitude']], topoWorld[['latitude']],
topoWorld[['z']], add=TRUE)
?mapPlot
mapPlot(coastlineWorld)
mapPlot(coastlineWorld, projection = '+proj=robin')
mapPlot(coastlineWorld)
mapPlot(coastlineWorld, projection = '+proj=robin')
points(lon, lat)
par('usr')
mapPoints(lon, lat)
mapPlot(coastlineWorld, projection = '+proj=robin')
mapPoints(lon, lat, cex=0.2)
locator(1)
mapLocator(1)
mapPlot(coastlineWorld, projection = "+proj=stere")
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0, +lat_0=-90")
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0 +lat_0=-90")
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-60, -90))
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-60, -90), longitudelim = c(-180, 180))
mapPlot(coastlineWorld, projection = '+proj=robin')
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-60, -90), longitudelim = c(-180, 180))
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-50, -90), longitudelim = c(-180, 180))
mapGrid()
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-50, -90), longitudelim = c(-180, 180))
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-50, -90), longitudelim = c(-180, 180),
grid = FALSE)
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-50, -90), longitudelim = c(-180, 180),
grid = 5)
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-50, -90), longitudelim = c(-180, 180),
grid = c(5, 5)
)
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-50, -90), longitudelim = c(-180, 180),
grid = FALSE)
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-50, -90), longitudelim = c(-180, 180),
grid = FALSE)
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-60, -90), longitudelim = c(-180, 180),
grid = FALSE)
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-60, -90), longitudelim = c(-180, 180))
dev.new()
mapPlot(coastlineWorld, projection = "+proj=stere +lon_0=0
+lat_0=-90", latitudelim = c(-60, -90), longitudelim = c(-180, 180))
mapGrid()
mapPlot(coastlineWorld, projection="+proj=stere +lon_0=-90 +lat_0=90",
longitudelim = c(-120, -60), latitudelim = c(60, 85), col='grey')
mapPlot(coastlineWorld, projection="+proj=stere +lon_0=-90",
longitudelim = c(-120, -60), latitudelim = c(60, 85), col='grey')
mapPlot(coastlineWorld, projection="+proj=stere +lon_0=-90 +lat_0=50",
longitudelim = c(-120, -60), latitudelim = c(60, 85), col='grey')
mapPlot(coastlineWorld, projection = "+proj=merc")
mapPlot(coastlineWorld, projection = "+proj=merc", grid=FALSE)
mapPlot(coastlineWorld, projection = "+proj=merc", grid=FALSE,
longitudelim = c(-80, 80))
mapPlot(coastlineWorld, projection = "+proj=merc", grid=FALSE,
latitudelim = c(-80, 80))
mapPlot(coastlineWorld, projection = "+proj=merc", grid=FALSE,
latitudelim = c(-80, 80), longitudelim=c(-180, 180))
mapPlot(coastlineWorld, projection = "+proj=lcc", grid=FALSE,
latitudelim = c(40, 80), longitudelim=c(-130, -50))
mapPlot(coastlineWorld, projection = "+proj=aea", grid=FALSE,
latitudelim = c(40, 80), longitudelim=c(-130, -50))
mapPlot(coastlineWorld, projection = "+proj=aea +lat_1=45",
grid=FALSE, latitudelim = c(40, 80), longitudelim=c(-130, -50))
mapPlot(coastlineWorld, projection = "+proj=aea +lat_1=45 +lat_2=45",
grid=FALSE, latitudelim = c(40, 80), longitudelim=c(-130, -50))
mapPlot(coastlineWorld, projection = "+proj=aea +lat_1=45 +lat_2=70",
grid=FALSE, latitudelim = c(40, 80), longitudelim=c(-130, -50))
mapPlot(coastlineWorld, projection = "+proj=aea +lat_1=45 +lat_2=70
+lon_0=-63", grid=FALSE, latitudelim = c(40, 80), longitudelim=c(-130,
-50))
library(ocedata)
data("coastlineWorldFine")
mapPlot(coastlineWorldFine, projection = "+proj=aea +lat_1=45
+lat_2=70 +lon_0=-63", grid=FALSE, latitudelim = c(40, 80),
longitudelim=c(-130, -50))
mapPlot(coastlineWorldFine, projection = "+proj=aea +lat_1=44
+lat_2=47 +lon_0=-63", grid=FALSE, latitudelim = c(40, 50),
longitudelim=c(-130, -50))
mapPlot(coastlineWorldFine, projection = "+proj=aea +lat_1=44
+lat_2=47 +lon_0=-63", grid=FALSE, latitudelim = c(40, 50),
longitudelim=c(-70, -50))
mapPlot(coastlineWorldFine, projection = "+proj=aea +lat_1=44
+lat_2=47 +lon_0=-63", grid=FALSE, latitudelim = c(40, 50),
longitudelim=c(-60, -55))
mapPlot(coastlineWorldFine, projection = "+proj=aea +lat_1=44
+lat_2=47 +lon_0=-63", grid=FALSE, latitudelim = c(40, 50),
longitudelim=c(-70, -60))
mapPlot(coastlineWorldFine, projection = "+proj=aea +lat_1=44
+lat_2=47 +lon_0=-63", grid=FALSE, latitudelim = c(42, 48),
longitudelim=c(-70, -60))

