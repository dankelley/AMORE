# I don't think I am decoding 'version' correctly.  Also, the PNG explanation
# seems wrong: the bytes do not add up to 70.
#
# References:
# * for python see https://docs.python.org/3/library/struct.html
# * for R see help("unpack", package="pack")

# Python codes ("cBHIdd" seems to work)

#     header_sub_fmt = 'cBHIdd' #ecosub encoding
#     Items (byte, char, meaning)
#      1 c char
#      1 B unsigned char
#      2 H unsigned short
#      4 I unsigned int
#      8 d double
#
# R codes ("C B v V d d" seems to work)
#      a A null padded string (as of R-2.8.0, strings cannot contain embedded nulls)
#      A A space padded string
#      b An ascending bit order binary vector, (must be a multiple of 8 long)
#      B An descending bit order binary vector, (must be a multiple of 8 long)
#      C An unsigned char (octet) value
#      v An unsigned short (16-bit) in "VAX" (little-endian) order
#      V An unsigned long (32-bit) in "VAX" (little-endian) order
#      f A single-precision float
#      d A double-precision float
#      x A null byte
#      H A raw byte
#
# Values 'a', 'A', and 'H' may be followed by a repeat value. A repeat value of
# '*' will cause the remainder of the bytes in values to be placed in the last
# element.
#
# TESTS (trying item by item)
#     unpack("C", b)
#     unpack("C B", b)
#     unpack("C B H1", b)
#     unpack("C B H1 v", b) # 'v' in R is like 'i' in python (int)
#     unpack("C B H1 V", b) # 'V' in R is like 'I' in python (unsigned int)
#     unpack("C B H1 V d d", b)
#     unpack("C B v V d d", b)

library(pack)
for (f in list.files(path=".", pattern="sbd$")) {
    n <- file.size(f)
    b <- readBin(f, "raw", n)
    res <- unpack("C B v V d d", b)
    names(res) <- c("type", "version", "ecoSUBnumber", "time", "longitude", "latitude")
    res$type <- readBin(as.raw(res$type), "character", size=1, n=1)
    res$time <- as.POSIXct(res$time, origin="1970-01-01 00:00:00", tz="UTC")
    cat("# ", f, "\n")
    cat("Input (hex): ", paste(b, collapse=""), "\n")
    cat("Decoded values:\n")
    cat(str(res))
    cat("\n")
}
