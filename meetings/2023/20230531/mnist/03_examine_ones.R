library(tensorflow)
library(keras)
# Get data (Note that the train and test items get altered later
mnist <- dataset_mnist()
train_images <- mnist$train$x
train_labels <- mnist$train$y
look <- train_labels == 1
train_images <- train_images[look,,]
# Plotting functions
draw_train <- function(i) {
    view <- t(train_images[i, 28:1, ]) # flip, then transpose
    image(view, col=rev(gray.colors(256)),
        zlim=c(0, 255), axes=FALSE, xlab="", ylab="")
}

if (!interactive()) pdf("03_examine_ones.pdf")
par(mfrow=c(6, 6), mar=c(0.3, 0.3, 0.3, 0.3))
n <- dim(train_images)[1] # 6742
for (i in seq_len(dim(train_images)[1]))
    draw_train(i)
if (!interactive()) dev.off()

