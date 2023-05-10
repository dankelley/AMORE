library(oce)
library(dod)
indexFile <- dod.ctd("BBMP", index=TRUE)
index <- read.csv(indexFile, header=FALSE, col.names=c("file","time"), skip=3)
ctdFile <- dod.ctd("BBMP", ID=index$file[15])
read.oce(ctdFile) |> plotTS(type="l")

data(section)
stations <- section[["station"]]
pdf("nls_01.pdf", height=4)
for (i in seq_along(stations)) {
    plotProfile(section[["station", i]], "sigma0", type="o")
    mtext(i, side=1)
}

