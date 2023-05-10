# world view (note that auto-decimation removes features; see EMAG2_4.R)

library(oce) # for imagep(), faster than image()
data(coastlineWorld)
load("EMAG2_V3_20170530.rda") # emag2 holds lon, lat, sealevel and upcont

# plot
if (!interactive()) png("sealevel_world_monochrome.png",
    unit="in", width=7, height=3.5, res=300, pointsize=9)
imagep(emag2$lon, emag2$lat, emag2$sealevel,
    zlim=quantile(emag2$sealevel, c(0.01, 0.99), na.rm=TRUE))
lines(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]],
    col="magenta")
lines(coastlineWorld[["longitude"]]+360, coastlineWorld[["latitude"]],
    col="magenta")
mtext("sealevel")
if (!interactive()) dev.off()

if (!interactive()) png("upcont_world_monochrome.png",
    unit="in", width=7, height=3.5, res=300, pointsize=9)
imagep(emag2$lon, emag2$lat, emag2$upcont,
    zlim=quantile(emag2$upcont, c(0.01, 0.99), na.rm=TRUE))
lines(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]],
    col="magenta")
lines(coastlineWorld[["longitude"]]+360, coastlineWorld[["latitude"]],
    col="magenta")
mtext("upcont")
if (!interactive()) dev.off()

