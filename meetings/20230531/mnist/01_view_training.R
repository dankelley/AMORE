library(tensorflow)
library(keras)
# Plotting functions
draw_train <- function(i) {
    view <- t(train_images[i, 28:1, ]) # flip, then transpose
    image(view, col=rev(gray.colors(256)), zlim=c(0, 255), axes=FALSE, xlab="", ylab="")
    mtext(paste0(train_labels[i], " "), line=-1.2, col=4, adj=1, font=2, cex=2*par("cex"))
}
# Get data (Note that the train and test items get altered later
mnist <- dataset_mnist()
train_images <- mnist$train$x
train_labels <- mnist$train$y
if (!interactive()) png("01_view_training.png")
par(mfrow=c(6, 6), mar=c(0.3, 0.3, 0.3, 0.3))
for (i in 1:36)
    draw_train(i)
if (!interactive()) dev.off()
