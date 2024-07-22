# Demonstrating (a) writing to SQLITE3 database and (b) reading back
# from that database.
library(DBI)
library(RSQLite)

# First, create some data
x <- seq(0, 4, 0.1)
y <- x * exp(-x)
plot(x, y)
df <- data.frame(x = x, y = y)

# We will write to this file (remove it first, if it exists
# from previous testing)
f <- "sqlite.db"
unlink(f)

# PART a: writing
con <- dbConnect(RSQLite::SQLite(), dbname = f)
dbWriteTable(con, "xy", df)
dbDisconnect(con)

# PART b: reading
CON <- dbConnect(RSQLite::SQLite(), dbname = f)
DF <- dbReadTable(CON, "xy")
dbDisconnect(CON)

# PART c: check results
stopifnot(identical(df, DF))
