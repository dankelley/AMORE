library(oce)
library(dod)
year <- 2022
debug <- 2 # turn on debugging, two levels deep
age <- 7 # don't bother re-downloading if local version is under 7 day sold
indexFile <- dod.ctd("BBMP", year=year, index=TRUE, age=7, debug=debug)
index <- read.csv(indexFile, header=FALSE, col.names=c("file","time"), skip=3)
if (!interactive()) pdf("nls_02.pdf", pointsize=10)
look <- 31
file <- dod.ctd("BBMP", year=year, ID=index$file[look], age=age, debug=debug)
ctd <- read.oce(file)
par(mfrow=c(2, 2))
plotProfile(ctd, xtype="CT")
plotProfile(ctd, xtype="SA")
plotTS(ctd, type="o", pch=20)
mtext(file, side=3, col=2)
plotProfile(ctd, xtype="sigma0")
st <- ctd[["sigma0"]]
p <- ctd[["pressure"]]
m <- nls(st ~ 20 + st0 + p/b + dst * tanh((p-p0)/H),
    start=list(st0=1, b=100, dst=1, p0=30, H=10))
lines(predict(m), p, col=rgb(1,0,0,0.9))
p0 <- coef(m)[["p0"]]
abline(h=p0, col=2, lty=2)
mtext(sprintf("%.1f m", p0), side=4, at=p0, cex=par("cex"))
if (!interactive()) dev.off()

