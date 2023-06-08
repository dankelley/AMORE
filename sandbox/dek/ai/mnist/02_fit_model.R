# nolint start infix_spaces_linter
library(tensorflow)
library(keras)
# Get data (altered later, so we also retain the originals)
mnist <- dataset_mnist()
train_images_orig <- train_images <- mnist$train$x
train_labels_orig <- train_labels <- mnist$train$y
test_images_orig <- test_images <- mnist$test$x
test_labels_orig <- test_labels <- mnist$test$y

# (2.2) initiate model
model <- keras_model_sequential(list(
    layer_dense(units=512, activation="relu"),
    layer_dense(units=10, activation="softmax")
))

# (2.3) compile model
compile(model,
    optimizer="rmsprop",
    loss="sparse_categorical_crossentropy",
    metrics="accuracy")

# (2.4) transform data from 3D to 2D, with second index 1:(28^2)
train_images <- array_reshape(train_images, c(60000, 28*28)) / 255
test_images <- array_reshape(test_images, c(10000, 28*28)) / 255

# (2.5) fit model
fit(model, train_images, train_labels, epochs=5, batch_size=128)

# (2.6) test model
N <- 36
test_digits <- test_images[1:N, ]
predictions <- predict(model, test_digits)
digit_predicted <- -1 + apply(predictions, 1, which.max)
digit_probability <- sapply(seq_len(nrow(predictions)),
    \(i) predictions[i, 1+digit_predicted[i]])
digit_actual <- test_labels[1:N]

# Plot some results
draw_test <- function(i) {
    view <- t(test_images_orig[i, 28:1, ]) # flip, then transpose
    image(view, col=rev(gray.colors(256)),
        zlim=c(0, 255), axes=FALSE, xlab="", ylab="")
    mtext(sprintf("%d (%d %.4f%%) ",
            digit_actual[i], digit_predicted[i], 100*digit_probability[i]),
        side=3, line=0.2, adj=1, cex=1.3*par("cex"))
}

if (!interactive()) png("02_fit_model.png")
par(mfrow=c(6, 6), mar=c(0.3, 0.3, 1.3, 0.3))
for (i in 1:36)
    draw_test(i)
if (!interactive()) dev.off()

# nolint end infix_spaces_linter