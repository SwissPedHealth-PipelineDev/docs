---
title: "Bayesian - Probability of a girl birth given placenta previa"
output:
  md_document:
    variant: gfm
    preserve_yaml: true
layout: default
nav_order: 5
---

<!-- This doc was built with: -->

<!-- rmarkdown::render("example1.Rmd", output_file = "../pages/your_document.md") -->

    ## [1] "2024-11-13"

# Bayesian Analysis Example: Probability of a Girl Birth Given Placenta Previa

## Introduction

In an interesting Bayesian case study, we examine the probability of a
girl birth among births with the condition placenta previa, where the
placenta obstructs a normal vaginal delivery. An early study in Germany
found that out of 980 births with placenta previa, 437 were female. We
aim to assess the evidence supporting the hypothesis that the proportion
of female births in this condition is less than the general population
proportion of 0.485.

``` r
library(ggplot2)
theme_set(theme_minimal())
# Posterior is Beta(438,544)

# seq creates evenly spaced values
df1 <- data.frame(theta = seq(0.375, 0.525, 0.001)) 
a <- 438
b <- 544

# dbeta computes the posterior density
df1$p <- dbeta(df1$theta, a, b)
# compute also 95% central interval

# seq creates evenly spaced values from 2.5% quantile
# to 97.5% quantile (i.e., 95% central interval)
# qbeta computes the value for a given quantile given parameters a and b
df2 <- data.frame(theta = seq(qbeta(0.025, a, b), qbeta(0.975, a, b), length.out = 100))

# compute the posterior density
df2$p <- dbeta(df2$theta, a, b)

# Plot posterior (Beta(438,544)) and 48.8% line for population average

ggplot(mapping = aes(theta, p)) +
  geom_line(data = df1) +
  # Add a layer of colorized 95% posterior interval
  geom_area(data = df2, aes(fill='1')) +
  # Add the proportion of girl babies in general population
  geom_vline(xintercept = 0.488, linetype='dotted') +
  # Decorate the plot a little
  labs(title='Uniform prior -> Posterior is Beta(438,544)', y = '') +
  scale_y_continuous(expand = c(0, 0.1), breaks = NULL) +
  scale_fill_manual(values = 'lightblue', labels = '95% posterior interval') +
  theme(legend.position = 'bottom', legend.title = element_blank())
```

![](../assets/images/Bayes_ex1-1.png)<!-- -->

end
