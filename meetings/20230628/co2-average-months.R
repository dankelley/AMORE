# Demonstrate computation of monthly means of CO2 signal
library(oce)
elninoyears <- c(1982:1983, 1997:1998, 2014:2016)
elnino <- ISOdatetime(elninoyears, 1, 2, 0, 0, 0, tz="UTC")

url <- "https://gml.noaa.gov/webdata/ccgg/trends/co2/co2_weekly_mlo.csv"
file <- gsub(".*/", "", url)
if (!file.exists(file))
    download.file(url, file)
lines <- readLines(file)
nlines <- length(lines)
headerLine <- grep("^year,", lines)
data <- read.csv(text=lines[headerLine:nlines], header=TRUE)
data$average[data$average < 0] <- NA
data$time <- ISOdatetime(data$year, data$month, data$day, 0, 0, 0, tz="UTC")
dataSplit <- split(data, cut(data$time, "year"))
if (!interactive())
    png("co2-average-months.png")
par(mfrow=c(3, 3), mar=c(2.7, 2.7, 0.5, 0.5), mgp=c(1.5, 0.4, 0))
for (i in 1:9) {
    d <- dataSplit[[i]]
    plot(d$month, d$average, type="p", xlab="Month", ylab=expression(CO[2]),
        xlim=c(1,12), xaxs="i")
    dm <- unname(sapply(split(d, cut(d$time, "month")),
            function(x) c(x$month[1], mean(x$average, na.rm=TRUE))))
    lines(dm[1,], dm[2,])
    mtext(paste(d$year[1], " "), cex=par("cex"), line=-1, adj=1)
}
if (!interactive())
    dev.off()

