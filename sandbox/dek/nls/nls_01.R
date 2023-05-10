library(oce)
library(dod) # not on CRAN
year <- 2022
indexFile <- dod.ctd("BBMP", year=year, index=TRUE)
index <- read.csv(indexFile, header=FALSE, col.names=c("file","time"), skip=3)
if (!interactive()) pdf("nls_01.pdf", height=4)
for (i in seq_len(nrow(index))[1]) {
    cat(index$file[i], "\n")
    dod.ctd("BBMP", year=year, ID=index$file[i], debug=3) |> read.oce() |> plotProfile(xtype="density")
    mtext(i, side=1)
}
if (!interactive()) dev.off()

