# -*- coding: utf-8 -*-
"""
1 * (Convolution + Max_pool) + 1 * Full-connected
"""
import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data
from random import sample
import matplotlib.pyplot as plt
from time import time


def weight_variable(shape):
    initial = tf.truncated_normal(shape, stddev=0.3)
    #initial = tf.random_uniform(shape=shape, minval=-1, maxval=1)
    return tf.Variable(initial)


def bias_variable(shape):
    #initial = tf.constant(0.1, shape=shape)
    #initial = tf.random_uniform(shape=shape, minval=-1, maxval=1)
    initial = tf.truncated_normal(shape, stddev=0.3)
    return tf.Variable(initial)


def conv2d(x, W):
    return tf.nn.conv2d(x, W, strides=[1, 1, 1, 1], padding='VALID')


def max_pool_2x2(x):
    return tf.nn.max_pool(x, ksize=[1, 2, 2, 1],
                          strides=[1, 2, 2, 1], padding='VALID')


if __name__ == '__main__':
    # Read in MNIST data
    mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
    ind = sample(range(mnist.train.images.shape[0]), 10000)
    train = tf.contrib.learn.datasets.mnist.DataSet(
        mnist.train.images[ind,:], mnist.train.labels[ind,:], one_hot=True, reshape=False)

    # Placeholders of training attributes and labels
    x = tf.placeholder(tf.float32, [None, 784])
    y_ = tf.placeholder(tf.float32, [None, 10])

    # Reshape images from 728*1 to 28*28
    x_image = tf.reshape(x, [-1, 28, 28, 1])

    # Convolutional layer
    W_conv1 = weight_variable([5, 5, 1, 6])
    b_conv1 = bias_variable([6])
    h_conv1 = tf.nn.relu(conv2d(x_image, W_conv1) + b_conv1)
    h_pool1 = max_pool_2x2(h_conv1)

    # Full-connected layer, ReLU
    W_fc1 = weight_variable([12 * 12 * 6, 300])
    b_fc1 = bias_variable([300])
    h_pool1_flat = tf.reshape(h_pool1, [-1, 12 * 12 * 6])
    h_fc1 = tf.nn.relu(tf.matmul(h_pool1_flat, W_fc1) + b_fc1)

    # Placeholder of keep_prob for dropout
    keep_prob = tf.placeholder(tf.float32)

    # Output layer with 10 classes
    W_fc2 = weight_variable([300, 10])
    b_fc2 = bias_variable([10])
    h_fc1_drop = tf.nn.dropout(h_fc1, keep_prob)
    y_conv = tf.matmul(h_fc1_drop, W_fc2) + b_fc2

    # Compute cost: Cross entropy after softmax
    cross_entropy = tf.reduce_mean(
        tf.nn.softmax_cross_entropy_with_logits(labels=y_, logits=y_conv))

    # Learning step, optimized by Adam
    train_step = tf.train.AdamOptimizer(1e-3, 0).minimize(cross_entropy)

    # Define accuracy
    correct_prediction = tf.equal(tf.argmax(y_conv, 1), tf.argmax(y_, 1))
    accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

    # Create Session and initialize variables
    sess = tf.InteractiveSession()
    sess.run(tf.global_variables_initializer())

    # Training process
    iteration = 5000
    err = []
    start_time = time()
    for i in range(iteration):
        batch = train.next_batch(50)
        # Report the accuracy on training set every 100 steps
        if i % 100 == 0:
            train_accuracy = accuracy.eval(feed_dict={
                x: train.images, y_: train.labels, keep_prob: 1.0})
            print("step %d, train accuracy %g" % (i, train_accuracy))
            err.append(1-train_accuracy)
        train_step.run(feed_dict={x: batch[0], y_: batch[1], keep_prob: 1.0})

    end_time = time()
    print('Training time: {}s'.format(end_time-start_time))

    # Accuracy on test set
    print("test accuracy %g" % accuracy.eval(feed_dict={
        x: mnist.test.images, y_: mnist.test.labels, keep_prob: 1.0}))

    # Plot training error
    plt.plot(range(len(err)), err)
    plt.title('Train Error')
    plt.xlabel(r'$\times100$ Iterations')
    plt.ylabel('Error Rate (%)')
    plt.xticks([i*iteration/1000 for i in range(11)])
    plt.yticks([e*0.05 for e in range(21)], [e*5 for e in range(21)])
    plt.show()
