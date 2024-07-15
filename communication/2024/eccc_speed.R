library(ncdf4)
library(oce)
# Get most recent image (previous day at 1800 UTC)
time <- paste0(gsub("-", "", Sys.Date() - 1), "T18Z")
uurl <- paste0(
    "https://dd.weather.gc.ca/model_ciops/east/2km/18/048/",
    time, "_MSC_CIOPS-East_SeaWaterVelocityX_DBS-0.5m_LatLon0.03x0.02_PT048H.nc"
)
vurl <- paste0(
    "https://dd.weather.gc.ca/model_ciops/east/2km/18/048/",
    time, "_MSC_CIOPS-East_SeaWaterVelocityY_DBS-0.5m_LatLon0.03x0.02_PT048H.nc"
)
ufile <- gsub(".*/", "", uurl)
vfile <- gsub(".*/", "", vurl)
# Do not re-download files that already exist
if (!file.exists(ufile)) download.file(uurl, ufile)
if (!file.exists(vfile)) download.file(vurl, vfile)
# Get the data
unc <- nc_open(ufile)
u <- ncvar_get(unc, "vozocrtx")
vnc <- nc_open(vfile)
v <- ncvar_get(vnc, "vomecrty")
speed <- sqrt(u^2 + v^2)
longitude <- ncvar_get(unc, "longitude")
latitude <- ncvar_get(unc, "latitude")
# Plot, using an aspect ratio that yields correct shapes at middle latitude
if (!interactive()) {
    png("eccc_speed.png", unit = "in", width = 7, height = 4.7, res = 140, pointsize = 9)
}
asp <- 1 / cospi(mean(range(latitude) / 180))
imagep(longitude, latitude, speed,
    asp = asp, col = oceColorsTurbo,
    missingColor = "lightgray", mar = c(2, 2, 1, 1),
    decimate = FALSE
)
mtext("Modelled Sea Surface Speed [m/s]", adj = 0, line = 0.1)
mtext(time, adj = 0.5, line = 0.1)
if (!interactive()) {
    dev.off()
}
