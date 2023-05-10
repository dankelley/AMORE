rm(list=ls())
p <- seq(0, 100, by=1)
temperature <- 10 - 5 * tanh((p - 30) / 10) + rnorm(length(p), sd=0.5)
if (!interactive()) pdf("nls_01_profile.pdf", height=5)
plot(temperature, p, ylim=rev(range(p)), pch=20, cex=0.5)
m <- nls(temperature ~ a + b*tanh((p-p0)/h), start=list(a=10, b=-5, p0=50, h=50))
summary(m)
lines(predict(m), p, col="magenta")
abline(h=coef(m)["p0"])
abline(h=confint(m)["p0",], col=2) # on top
if (!interactive()) dev.off()

