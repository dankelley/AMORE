library(DBI)
library(RSQLite)
x <- seq(0, 4, 0.1)
y <- x * exp(-x)
plot(x, y)
df <- data.frame(x = x, y = y)

# we will write to this file (remove it first, if it exists
# from previous testing)
f <- "sqlite_demo.db"
unlink(f)

# demo writing
con <- dbConnect(RSQLite::SQLite(), dbname = f)
dbWriteTable(con, "xy", df)
dbDisconnect(con)

# demo reading
CON <- dbConnect(RSQLite::SQLite(), dbname = f)
DF <- dbReadTable(CON, "xy")
dbDisconnect(CON)
points(DF$x, DF$y, col = 2, cex=2)
