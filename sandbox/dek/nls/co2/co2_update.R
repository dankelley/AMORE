library(oce)
elninoyears <- c(1982:1983, 1997:1998, 2014:2016)
elnino <- ISOdatetime(elninoyears, 1, 2, 0, 0, 0, tz = "UTC")

if (!interactive()) pdf("co2_update.pdf")
par(mfrow = c(3, 1))

url <- "https://gml.noaa.gov/webdata/ccgg/trends/co2/co2_weekly_mlo.csv"
file <- gsub(".*/", "", url)
if (!file.exists(file)) {
    download.file(url, file)
}
lines <- readLines(file)
nlines <- length(lines)
headerLine <- grep("^year,", lines)
data <- read.csv(text = lines[headerLine:nlines], header = TRUE)
data$average[data$average < 0] <- NA
data$time <- ISOdatetime(data$year, data$month, data$day, 0, 0, 0, tz = "UTC")

mar <- c(3, 3, 1, 1)
ok <- is.finite(data$average)
time <- data$time[ok]
average <- data$average[ok]
s <- smooth.spline(time, average, df = 30)
averageSmoothed <- predict(s)$y
plus <- ifelse(average >= averageSmoothed, average, averageSmoothed)
minus <- ifelse(average <= averageSmoothed, average, averageSmoothed)
oce.plot.ts(time, plus, col = 2, xaxs = "i", drawTimeRange = FALSE, ylab = "CO2 [ppm]")
abline(v = elnino, col = "forestgreen")
grid(lty = 1)

lines(time, minus, col = 4)
abline(v = elnino, col = "forestgreen")
oce.plot.ts(time, 86400 * 365.25 * predict(s, deriv = 1)$y,
    xaxs = "i",
    drawTimeRange = FALSE, ylab = "Derivative of Spline Fit [ppm/year]"
)
abline(v = elnino, col = "forestgreen")
grid(lty = 1)

anomaly <- average - averageSmoothed
plus <- ifelse(anomaly >= 0, anomaly, 0)
minus <- ifelse(anomaly <= 0, anomaly, 0)
oce.plot.ts(time, plus,
    col = 2, xaxs = "i", type = "l",
    ylim = c(-1, 1) * max(anomaly),
    ylab = "CO2 Anomaly", drawTimeRange = FALSE, mar = mar
)
lines(time, minus, col = 4)
abline(v = elnino, col = "forestgreen")
grid(lty = 1)
if (!interactive()) dev.off()
