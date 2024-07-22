library(oce) # install.packages("oce")
library(ncdf4) # install.packages("ncdf4")
library(dod) # devtools::install_github("dankelley/dod")
# dod.amsr(), from dod, downloads an AMSR satellite image
f <- dod.amsr()
# nc_open(), ncvar_get() and nc_close() are from ncdf4
o <- nc_open(f)
SST <- ncvar_get(o, "SST")
lon <- ncvar_get(o, "lon")
lat <- ncvar_get(o, "lat")
nc_close(o)
# colormap() and imagep() are defined in oce library
if (!interactive()) {
    png("netcdf_amsr%02d.png", unit = "in", width = 7, height = 3.73, res = 200)
}
cm <- colormap(zlim = c(-2, 35), col = oceColorsTurbo)
imagep(lon, lat, SST, asp = 1, colormap = cm)
if (interactive()) {
    message("click mouse to select a location")
    xy <- locator(1)
    i <- which.min(abs(xy$x - lon))
    j <- which.min(abs(xy$y - lat))
    mtext(sprintf("%.2fE %.2fN %.2f degC", lon[i], lat[j], SST[i, j]))
    points(lon[i], lat[j])
}

# Finally, show that oce's read.amsr() can make nicer images,
# colourizing land with light brown ink, ice with magenta ink,
# and missing data with gray ink.
amsr <- read.amsr(f)
plot(amsr)
if (!interactive()) {
    dev.off()
}
