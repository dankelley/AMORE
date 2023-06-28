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
par(mfrow=c(2, 1))
mar <- c(3, 3, 1, 1)
ok <- is.finite(data$average)
time <- data$time[ok]
average <- data$average[ok]
s <- smooth.spline(time, average, df=30)
averageSmoothed <- predict(s)$y
plus <- ifelse(average >= averageSmoothed, average, averageSmoothed)
minus <- ifelse(average <= averageSmoothed, average, averageSmoothed)
oce.plot.ts(time, plus, col=2, xaxs="i", drawTimeRange=FALSE, ylab="CO2")
grid()
lines(time, minus, col=4)
abline(v=as.POSIXct("2022-12-01"), lty="dotted")
abline(v=elnino, col="forestgreen")

anomaly <- average - averageSmoothed
plus <- ifelse(anomaly >= 0, anomaly, 0)
minus <- ifelse(anomaly <= 0, anomaly, 0)
oce.plot.ts(time, plus, col=2, xaxs="i", type="l",
    ylim=c(-1,1)*max(anomaly),
    ylab="CO2 Anomaly", drawTimeRange=FALSE, mar=mar)
grid()
lines(time, minus, col=4)
abline(v=as.POSIXct("2022-12-01"), lty="dotted")

abline(v=elnino, col="forestgreen")

stop()

Rscale <- 1
t0 <- min(time)
spy <- 365.24*24*3600
R <- Rscale * (as.numeric(data$time) - as.numeric(t0))/spy
theta <- 2*pi*(as.numeric(data$time) - as.numeric(trunc(data$time, "year")))/spy
plot(data$time,R,type="l")
plot(data$time,theta,type="l")
cm <- colormap(data$average, col=oceColorsTurbo)
plot(R*cos(theta), R*sin(theta), type="p", col=cm$zcol, pch=20, cex=1, asp=1)

R <- Rscale * (data$average - min(data$average, na.rm=TRUE))
theta <- 2*pi*(as.numeric(data$time) - as.numeric(trunc(data$time, "year")))/spy
cm <- colormap(data$average, col=oceColorsTurbo)
plot(R*cos(theta), R*sin(theta), type="l", col=1, asp=1)
#points(R*cos(theta), R*sin(theta), type="p", col=cm$zcol, pch=20, cex=1)

imagep(matrix(data$average, nrow=52), colormap=colormap(range(data$average, na.rm=TRUE)))


