f <- function(x, A, L)
    A * x * exp(-x/L)

A <- 2 # true value
L <- 1 # true value
x <- seq(0, 10, length.out=100)
y <- f(x, A, L) + rnorm(length(x), sd=0.05)
m <- nls(y ~ A*x*exp(-x/L), start=list(A=5, L=5))
Acoef <- coef(m)[["A"]]
Lcoef <- coef(m)[["L"]]
ci <- confint(m)
Aci <- diff(ci["A",])/2
Lci <- diff(ci["L",])/2

if (!interactive()) pdf("nls_00_xexp.pdf", height=5)
plot(x, y)
lines(x, predict(m))
mtext(sprintf("A*x*exp(-x/L) with A=%.2f+-%.2f, L=%.2f+-%.2f (95%%CI))",
            Acoef, Aci, Lcoef, Lci))
mtext(sprintf("True values: A=%.2f, L=%.2f ", A, L), line=-1, adj=1, col=2)
if (!interactive()) dev.off()
