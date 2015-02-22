---
title       : Particle physics model fitting
subtitle    : Determining the B0 meson rest mass
author      : Guillermo Blázquez
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : zenburn      # 
widgets     : [mathjax, bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## The LHCb experiment
### The data
* The LHCb experiment collects data from collisions that produce B^0 mesons, that decay
shortly into other particles.
* Only a small fraction of the collisions produce B^0 decays.
* Data from the collisions is analyzed using machine learning techniques,
so we get data with real and false decays.

### Chi squared test
* How can we determine some parameter of the data if we have noise?
* We can fit a model to some experimental data by minimizing Pearson's chi squared test value.

$$\chi^2 = \sum_{i=1}^{N}{\frac{n_i - n_i^{model}}{\sigma_i^2}}$$


--- .class #id 

## Determining the mass

* Suppose we want to know the mass of the B^0 meson.
* We have a histogram of the data.
* We know that the data is comprised of actual decays that follow a normal distribution
with $\sigma = 100$ MeV/c^2 and noisy decays that follow an exponential distribution with $\tau = 1000$ MeV/c^2:

$$n_i^{model} = n\left[f N(\mu, \sigma) + (1-f)Exp(m, \tau)\right]$$


```r
model <- function(x, mu, f){
    m*binLength*(f*dnorm(x, mu, sd) + 
                     (1-f)*rate/(exp(-min*rate)-exp(-max*rate))*exp(-x*rate))
}
```

* The model has two unknowns, $\mu$ (the rest mass of the meson) and $f$, the fraction of real decays.
* If the model is correct, the values that minimize the $\chi^2$ will be the real parameters $\mu$ and $f$.

---

## Determining the mass

* In this case, minimizing the $\chi^2$ is the same as fitting the histogram with a density function based on
the model. For example, a not so well fitted model:


<img src="assets/fig/unnamed-chunk-3.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

---
## The app
* The app exemplifies the (simplified) process of extracting parameters from noisy data in particle physics experiments.
* Particle physics relies heavily on data analysis and machine learning techniques. Particle physicists use their own data analysis application, [ROOT](https://root.cern.ch/drupal/), for their job.
* The data for the app is processed data from the [CERN Open Data Portal](http://opendata.cern.ch/).  
</br>
</br>
* Try the app and see if you can fit the model without looking at the $\chi^2$ value!
* Once you have found the best mass, [check](http://en.wikipedia.org/wiki/B_meson) if it is the real value.
