library(oce) # for vectorShow()
file <- "data/300434065932320_000586.sbd"
filesize <- file.size(file)
cat(vectorShow(filesize))
b <- readBin(file, "raw", filesize)
#cat("Contents: 0x", paste(b, collapse=" 0x", sep=" "), "\n", sep="")
# Table 5-1
protocolRevisionNumber <- as.character(b[1])
#cat("b: ", paste(b), "\n")
#cat("as.integer(b): ", paste(as.integer(b)), "\n")
cat(vectorShow(as.raw(b[1])))
cat(vectorShow(as.character(b[1])))
overallMessageLength <- readBin(b[2:3], "integer", size=2, n=1, endian="big")
cat(vectorShow(overallMessageLength)) # 88 but filesize=70

cat("byte 1: 0x", b[1], "\n", sep="")
cat("byte 4: 0x", b[4], "\n", sep="")
# Table 5-12 MO Location Data Format (page 42)
byte1bits <- rawToBits(b[1])
cat(vectorShow(byte1bits, n=10))
reserved <- byte1bits[1:4]
formatCode <- byte1bits[5:6]
NSI <- byte1bits[7] # 0=north 1=south
EWI <- byte1bits[8] # 0=east 1=west
isNorth <- NSI==0
isEast <- EWI==0
cat(vectorShow(reserved))
cat(vectorShow(formatCode))
cat(vectorShow(NSI))
cat(vectorShow(EWI))
cat(vectorShow(isNorth))
cat(vectorShow(isEast))

latitudeDeg <- as.integer(b[2])
cat(vectorShow(latitudeDeg))
latitudeMin <- 1e-3 * readBin(b[3:4], "integer", size=2, n=1, endian="little")
cat(vectorShow(latitudeMin))
latitude <- latitudeDeg + latitudeMin / 60
cat(vectorShow(latitude))

longitudeDeg <- as.integer(b[2])
cat(vectorShow(longitudeDeg))
longitudeMin <- 1e-3 * readBin(b[3:4], "integer", size=2, n=1, endian="little")
cat(vectorShow(longitudeMin))
longitude <- longitudeDeg + longitudeMin / 60
cat(vectorShow(longitude))

df <- data.frame(b=b, i=sapply(seq_along(b), \(i) as.integer(b[i])))
print(df)
# email: "Unit Location: Lat = 44.67108 Long = -63.59291"
cat("latitude?\n")
cat(vectorShow(which(df$i==7)))
for (w in which(df$i==7)) {
    print(readBin(b[c(w+1,w+2)], "integer", n=1, size=2))
}
cat("longitude?\n")
cat(vectorShow(which(df$i==3)))
for (w in which(df$i==3)) {
    print(readBin(b[c(w+1,w+2)], "integer", n=1, size=2))
}
#paste0(readBin(b[7:10], "char", n=4), collapse="")
#for (i in seq(1, filesize, 2)) {
#    cat("i=", i, " , preceeding=", b[i-1], ": ", readBin(b[c(i,i+1)], "integer", n=1, size=2, signed=FALSE, endian="big"), "\n")
#}
#for (i in seq(2, filesize, 2)) {
#    cat("i=", i, " , preceeding=", b[i-1], ": ", readBin(b[c(i,i+1)], "integer", n=1, size=2, signed=FALSE, endian="big"), "\n")
#}

I <- 39
cat("Hypothesis: lat starts at byte I=", I, "with lon after that\n")
latDeg <- b[I]
latMin <- 0.001 * readBin(b[c(I+1, I+2)], "integer", size=2, n=1, signed=FALSE, endian="big")
lonDeg <- b[I+3]
lonMin <- 0.001 * readBin(b[c(I+4, I+5)], "integer", size=2, n=1, signed=FALSE, endian="big")
cat("lat:", latDeg, "deg,", latMin, "min (expect 7, 1.006; think about sign later)\n")
cat("lon:", lonDeg, "deg,", lonMin, "min (expect 3, 5.921; think about sign later)\n")
cat("Q: what is at byte", I-1, "? (res/form/NSI/EWI? table 5-12)\n")
cat(vectorShow(b[I-1]))
cat(vectorShow(rawToBits(b[I-1]), n=8))
cat("Q: what is at bytes", I-3, "and", I-2, "? (expect length table 5-11)\n")
cat(vectorShow(b[I-3]))
cat(vectorShow(b[I-2]))
length <- readBin(b[c(I-3, I-2)], "integer", size=2, n=1, signed=FALSE, endian="big")
cat(vectorShow(length))

cat("Q: what is at byte", I-4, "? (expect code 0x03 5-7)\n")
cat(vectorShow(b[I-4]))
cat(vectorShow(rawToBits(b[I-4]), n=8))
cat("Q: what is at byte", I-5, "?\n")
cat(vectorShow(b[I-5]))
cat(vectorShow(rawToBits(b[I-5]), n=8))
cat("-2,-1 -> ", readBin(b[c(I-2,I-1)], "integer", size=2, n=1, signed=FALSE, endian="big"), "\n")
cat("-3,-2 -> ", readBin(b[c(I-3,I-2)], "integer", size=2, n=1, signed=FALSE, endian="big"), "\n")
cat("-4,-3 -> ", readBin(b[c(I-4,I-3)], "integer", size=2, n=1, signed=FALSE, endian="big"), "\n")
cat("-5,-4 -> ", readBin(b[c(I-5,I-4)], "integer", size=2, n=1, signed=FALSE, endian="big"), "\n")
cat("-6,-5 -> ", readBin(b[c(I-6,I-5)], "integer", size=2, n=1, signed=FALSE, endian="big"), "\n")

cat(vectorShow(which(b==0x03), n=100))
vectorShow(b[3:6])
vectorShow(readBin(b[3:6], "character", size=1, n=4))
