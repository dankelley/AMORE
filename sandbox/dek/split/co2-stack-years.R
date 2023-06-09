# Plot month-average co2 (built-in dataset), stacked by year
t <- as.numeric(time(co2))
C <- cut(t, seq(floor(t[1]), 1+floor(tail(t, 1)), 1))
CO2 <- split(co2, C)

if (!interactive())
    pdf("co2-stack-years.pdf")
plot(CO2[[1]],type="l", ylim=range(co2), lwd=2)
for (i in 2:length(CO2))
    lines(CO2[[i]], col=i, lwd=2)
if (!interactive())
    dev.off()
