library(yaml)
readSpot <- function(filename)
{
    lines <- readLines(filename)
    nlines <- length(lines)
    sepLine <- grep("^[-]+$", lines)
    #lines[sepLine]
    headerLines <- lines[seq(1, sepLine-1)]
    metadata <- read_yaml(text=headerLines)
    col.names <- tolower(gsub(" \\(UTC\\)", "", strsplit(lines[sepLine+1], ",")[[1]]))
    dataLines <- lines[seq(sepLine + 2, nlines)]
    data <- read.delim(text=dataLines, sep="\t", col.names=col.names, header=FALSE)
    data$time <- as.POSIXct(data$time, format="%Y-%m-%dT%H:%M:%S")
    rval <- list(metadata=metadata, data=data)
    class(rval) <- "spot" # set up S3 class
    rval
}

plot.spot <- function(spot, cex=1, pch=20, col=4, which=1)
{
    if (which == 1) {
        with(spot$data,
            plot(longitude, latitude, asp=1/cos(mean(latitude)*pi/180),
                col=col, pch=pch, cex=cex))
    } else {
        stop("unknown 'which' value")
    }
}

summary.spot <- function(spot)
{
    cat(paste(spot$metadata[["Drifter type"]], "\n"))
}

s <- readSpot("data/20140702_spot036.txt")
plot(s, cex=0.3, pch=20)
summary(s)
