---
title: "AMORE-3-Regression"
author: "Cameron Richardson"
date: "2023-05-17"
output: pdf_document
---

## Assigning variables

Assign the variable $x$:

```{r, echo=T}
x<-c(1,3,5) #By value
```

```{r, echo=F}
x
```

```{r}
x<-1:100 #By range
```

```{r, echo=F}
x
```

```{r}
x<-seq(0,2*pi, pi/16) #By sequence
```

```{r, echo=F}
x
```

```{r}
y<-sin(x) 
```

## Including Plots

Plot $x$, $y$:

```{r}
plot(x,y) 
```

### Plot aesthetics

```{r}
plot(x,y, type="l")
grid()
lines(x,y,col=2, lwd=3)
```

### Plot margin controls

```{r}
par("mar")
par(mar=c(3,3,1,1))
```

```{r}
par(mar=c(3,3,1,1), mgp=c(2,0.7,0))
plot(x,y)
```

## Generate Data

```{r}
x<-1:10
y<-2+3*x
```

```{r}
plot(x,y)
```

### Add noise to data

```{r}
noise<-rnorm(x, mean=0,sd=3)
y<-y+noise
```

```{r, echo=F}
plot(x,y)
```

## Linear Regression

Consider the statistics printed in the regression summary (residuals, p-value, f-statistic)

```{r}
m<-lm(y~x)
summary(m)
```

### Diagnostic Plots

Utilized to evaluate the quality of the regression model $m$ as a predictor of our dataset

```{r}
plot(m)
```

### Confidence Intervals

```{r}
confint(m)
```

### Adding our linear model to the plot

```{r}
plot(x,y)
grid()
mtext(paste("model:" ,round(coef(m)[1],2), "+", round(coef(m)[2],2), "*x"))
abline(m)
abline(a=1,b=3, lty=2)
```

## Non-linear Regression

-   Where $y=xe^-$$^x$

-   We can manipulate $y$ through log-transformations

    -   Knowing $logy = A log y$ we can apply a transformation to yield $y = A x$

```{r}
x<-seq(0,10,length.out=50)
A<-1
B<-5
y<-A*x*exp(-x/B)
```

```{r,echo=F}
plot(x,y)
```

### Using nls()

```{r, error=T}
nls(y~A*x*exp(-x/B))
```

No intial value provided to the function

```{r, error=T}
# y<-y+rnorm(x,sd=0.05)
nls(y~A*x*exp(-x/B), start=list(A=1,B=40))
```

Function fits too well?

```{r}
y<-y+rnorm(x,sd=0.05)
nls(y~A*x*exp(-x/B), start=list(A=1,B=40))
```

Bad estimate for A or B coefficients

### Using nls()

```{r}
y<-y+rnorm(x,sd=0.05)
nls(y~A*x*exp(-x/B), start=list(A=1,B=4))
```

### Store and Evaluate nlm

```{r}
nlm<-nls(y~A*x*exp(-x/B), start=list(A=1,B=4))
coef(nlm)
confint(nlm)
predict(nlm)
```
