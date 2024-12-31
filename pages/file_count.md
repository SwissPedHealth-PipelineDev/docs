---
title: "Documentation log count"
output:
  md_document:
    variant: gfm
    preserve_yaml: true
layout: default
nav_order: 6
math: mathjax
---

# Documentation log count

Last update:

    ## [1] "2024-12-31"

This doc was built with:
`rmarkdown::render("file_count.Rmd", output_file = "../pages/file_count.md")`

Below is the latest count of documentation pages. This figure is updated
sporadically to track the current page count and estimated growth rate.
This count only considers the main sources in `./pages` but ignores
other code pages, images, etc.

![](../assets/images/file_count_plot-1.png)<!-- -->

    ## Regression Summary:

    ## 
    ## Call:
    ## lm(formula = FileCount ~ DateNumeric, data = df)
    ## 
    ## Residuals:
    ##       1       2       3       4       5       6 
    ##   0.999   6.852 -12.870  -9.514 -11.032  -0.819 
    ##       7 
    ##  26.384 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept) -1.71e+03   4.98e+02   -3.43    0.019 *
    ## DateNumeric  8.74e-02   2.50e-02    3.49    0.017 *
    ## ---
    ## Signif. codes:  
    ## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 15 on 5 degrees of freedom
    ## Multiple R-squared:  0.709,  Adjusted R-squared:  0.651 
    ## F-statistic: 12.2 on 1 and 5 DF,  p-value: 0.0175

    ## Estimated Annual Growth Rate (pages/year): 31.91

    ## Current count: 77

![](../assets/images/word-count-plots-1.png)<!-- -->
