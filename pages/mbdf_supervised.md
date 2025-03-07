---
layout: default
title: MBDF supervised
nav_order: 5
math: mathjax
---

# MBDF supervised analysis

Last update: 20250307

This document presents a supervised multiblock analysis to discriminate between two genotypes (wild-type and PPAR) by integrating gene expression and lipid data. In this analysis, a block PLS-DA model is constructed using the function `block.plsda()`, where the predictor matrices (genes and lipids) are combined into a multiblock structure and the response is a categorical variable. The model builds latent variables, often denoted by $t$, which are computed as linear combinations of the predictors, i.e.  
$$
t = Xw,
$$  
where $X$ is the data matrix and $w$ is a weight vector. These latent variables are used to explain the variance in the response and to achieve discrimination.

Once the model is built, the next step is to select the optimal number of latent components. This is done using the `perf()` function, which evaluates performance metrics such as the classification error rate, $R^2$, and the average variance explained ($AVE_X$) through cross-validation. The idea is to balance model complexity with predictive accuracy, ensuring that additional components contribute meaningfully to the discrimination.

The model’s significance is then assessed via permutation tests, implemented with `DIABLO.test()`. Here, the null hypothesis posits that the observed discrimination is no better than what could be expected by chance. By comparing the classification error rate (CER) and other metrics from the original model to those from models built on permuted data, one can derive a p-value indicating statistical significance.

An important aspect of the analysis is the examination of variance explained by each block and the overall model. For each block, the metric $AVE_X$ quantifies how much of the original variance is captured by the latent variables, while a global measure, $AVE_{outer}$, summarises the performance across blocks. This allows one to evaluate both the contribution of individual data types and the integrated model.

Visualisation plays a key role in interpreting the results. Scores plots are used to display the position of each sample in the latent variable space, facilitating the assessment of group separation. Similarly, loadings plots reveal which genes and lipids contribute most strongly to the discrimination, with variables showing high absolute loading values being of particular interest.

An alternative approach is taken with Consensus OPLS-DA, where the data blocks are scaled and integrated in a consensus framework. The model produces a predictive component, $p_1$, linked to the outcome, and an orthogonal component, $o_1$, which captures variability unrelated to the outcome. This method further refines the identification of discriminative features and validates the model performance through cross-validation and permutation-based statistics.

Key questions addressed in this analysis include:  
- Can the integrated gene and lipid data successfully discriminate between wild-type and PPAR samples?  
- What is the optimal number of latent variables required to balance complexity and performance?  
- Is the observed model statistically significant compared to random chance?  
- Which variables, among genes and lipids, are most important in driving the discrimination?

By systematically building the model, selecting the optimal number of latent variables, testing significance through permutations, and visualising both sample distributions and variable contributions, this approach provides a comprehensive framework for discriminant analysis using multiblock data.

