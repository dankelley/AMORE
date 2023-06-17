library(yaml)
library(oce)
read.spot <- function(file)
{
    lines <- readLines(file)
    nlines <- length(lines)
    sep <- grep("^[-]+$", lines)
    header <- yaml::read_yaml(text=lines[seq(1L, sep-1L)])
    # Hint: this is not needed here, but it's good to know about
    #     names(read.csv(text=lines[sep + 1L]))
    col.names <- strsplit(lines[sep + 1L], ",")[[1]]
    col.names <- gsub(" \\(UTC\\)", "", col.names)
    linesData <- lines[seq(sep+2L, nlines)]
    data <- read.delim(text=linesData, sep="\t", col.names=col.names)
    data$Time <- as.POSIXct(data$Time, format="%Y-%m-%dT%H:%M:%S", tz="UTC")
    rval <- list(header=header, data=data)
    class(rval) <- "spot"
    rval
}

spot <- read.spot("20140702_spot036.txt")
str(spt)

#with(data, plot(Time, Longitude))
#with(data, oce.plot.ts(Time, Longitude))
#with(data, plot(Longitude, Latitude, asp=1/cos(mean(Latitude)*pi/180)))
