if (!exists("emag2"))
    load("EMAG2_V3_20170530.rda")

# lon and lat are vectors
getEmag2 <- function(lon, lat, which="upcont")
{
    lon <- ifelse(lon < 0, 360+lon, lon)
    n <- length(lon)
    stopifnot(n == length(lat))
    rval <- rep(NA, n)
    for (i in seq_len(n)) {
        ilon <- which.min(abs(emag2$lon - lon[i]))
        ilat <- which.min(abs(emag2$lat - lat[i]))
        rval[i] <- emag2[[which]][ilon, ilat]
    }
    rval
}

# Halifax (approx)
getEmag2(-63, 45)

# Plot south-north slice at Halifax
lon <- rep(-63, 100)
lat <- seq(44, 45, length.out=length(lon))
sl <- getEmag2(lon, lat)
if (!interactive())
    png("05_EMAG2_lookup.png")
par(mar=c(3,3,1,1), mgp=c(2,0.7,0))
plot(lat, sl, type="o", cex=0.3, xlab="Latitude at Halifax Longitude", ylab="Sealevel Field [nT]")
grid()
mtext("Recall that 1deg latitude is about 111km")
if (!interactive())
    dev.off()
