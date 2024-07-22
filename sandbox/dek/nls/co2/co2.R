if (!interactive()) pdf("co2.pdf")
par(mfrow = c(4, 1), mar = c(3, 3, 1, 1), mgp = c(2, 0.7, 0)) # use thin margins
plot(co2)
# par(mfrow=c(3, 1))
t <- as.numeric(time(co2))
tt <- t - t[1]
m1 <- nls(co2 ~ A + B * exp((t - 1950) / tau), start = list(A = 300, B = 10, tau = 10))
lines(t, predict(m1), col = 2)

co2B <- co2 - predict(m1)
plot(t, co2B, type = "l")
abline(h = 0)
mtext("Remove exponential signal")

S <- sin(2 * pi * t / 1)
C <- cos(2 * pi * t / 1)
m2 <- lm(co2B ~ S + C)
plot(t, co2 - predict(m1) - predict(m2), type = "l")
abline(h = 0)
mtext("As above, but also remove 12-month signal")

S2 <- sin(2 * pi * t / 0.5)
C2 <- cos(2 * pi * t / 0.5)
m3 <- lm(co2B ~ S + C + S2 + C2)
plot(t, co2 - predict(m1) - predict(m3), type = "l")
abline(h = 0)
mtext("As above, but also remove 6-month signal")
if (!interactive()) dev.off()
