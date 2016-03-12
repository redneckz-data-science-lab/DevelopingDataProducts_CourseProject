Singular Value Decomposition
========================================================
author: Alexander Alexandrov
date: Saturday, March 12, 2016

SVD Overview
========================================================

<img src="https://upload.wikimedia.org/wikipedia/commons/e/e9/Singular_value_decomposition.gif" alt="SVD Illustration" style="float: right" />

Visualization of the SVD of a two-dimensional, real shearing matrix **M**. The SVD decomposes **M** into three simple transformations.

1. Rotation **V**<sup>*</sup>
2. Scaling **Σ**
3. Rotation **U**

Random Data
========================================================

Let's generate some random data 40x10. Then add some pattern. So most of the rows from 5 up to 10 column are shifted by some value.

![plot of chunk unnamed-chunk-1](SVD-figure/unnamed-chunk-1-1.png)

Hierarchical Clustering
========================================================

![plot of chunk unnamed-chunk-2](SVD-figure/unnamed-chunk-2-1.png)

Pattern *injected* into the random data is not evident.

Hierarchical Clustering + SVD
========================================================

![plot of chunk unnamed-chunk-3](SVD-figure/unnamed-chunk-3-1.png)

First singular vectors have *catched* most of the variance and pattern has become evident.
