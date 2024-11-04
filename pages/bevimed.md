---
layout: default
math: mathjax
title: BeviMed
nav_order: 5
---

Last update: 20241104
# BeviMed

* TOC
{:toc}

{: .note }
This page is a work in progress and thus contains content quoted directly from:
Greene, Daniel et al. "A Fast Association Test for Identifying Pathogenic Variants Involved in Rare Diseases." *The American Journal of Human Genetics*, Volume 101, Issue 1, pages 104 - 114. [http://dx.doi.org/10.1016/j.ajhg.2017.05.015](http://dx.doi.org/10.1016/j.ajhg.2017.05.015).

## Talks on the topics

* <https://www.youtube.com/watch?v=0SFGjWeGI0I>
* <https://www.youtube.com/watch?v=9f4BOQvN_E4>


## Introduction

In principle, Bayesian inference lends itself well to rare variant association analysis because it provides a coherent framework for sharing information across variants and provides a natural way of incorporating prior information on variant pathogenicity. The variational Bayes discrete mixture method (vbdm),[^6] the Bayesian risk index,[^7] and the Bayesian rare variant detector (BRVD)[^8] all model a mixture of pathogenic and non-pathogenic variants in a locus, but they employ additive models of disease risk or severity more suited to complex rather than rare diseases caused by dominant or recessive inheritance of one or two pathogenic alleles.
Here we present a Bayesian model in which disease risk depends on the genotypes at rare variants in a locus, a latent mode of inheritance, and a latent partition of variants into pathogenic and non-pathogenic subsets. Different modes of inheritance are modeled by conditioning the probability of case status on the number of pathogenic alleles and the ploidy for each individual at the variants. Thus, disease risk due to compound heterozygosity or X-linked inheritance is explicitly accommodated. Prior knowledge concerning variant pathogenicity can be incorporated in the form of shifts in the log odds of pathogenicity relative to a global mean. By placing a vague prior distribution on the scale of these shifts, the usefulness or otherwise of these co-data are accounted for flexibly to maximize power.
For a given set of variants, inference is performed by comparing the model described above with a baseline model in which disease risk is independent of the genotypes. The mode of inheritance and the pathogenicity of each variant, conditional on an association, can be inferred through the posterior distributions of parameters in the model. Particular classes of variants in a locus may be the only ones that confer disease risk. For example, only variants in the 50 UTR region or only high-impact coding variants may be involved. Our method can compare models fitted to different classes of variants in order to infer which ones are responsible for disease. Typically the inference process would be repeated over many sets of variants selected from different loci throughout the genome. The procedures are implemented in an efficient R package called BeviMed, which stands for Bayesian evaluation of variant involvement in Mendelian disease.

## Material and Methods

### Model Specification

Let $$ y $$ be a binary vector of length $$ N $$ indicating whether individual $$ i $$ is a case ($$ y_i = 1 $$) or a control ($$ y_i = 0 $$) subject with respect to a particular disease. Suppose $$ k $$ rare variants are under consideration (typically in a particular genomic region) and the genotype for individual $$ i $$ at variant $$ j $$ is coded in the $$ i $$th row and $$ j $$th column of the genotype matrix $$ G $$. A genotype of 0 or 2 denotes homozygosity for the common or minor allele, respectively, and a genotype of 1 denotes heterozygosity. Under a baseline model, labeled $$ \gamma = 0 $$, $$ y $$ is independent of $$ G $$ and all individuals have a probability of being a case $$ \tau_0 $$. Under the association model, labeled $$ \gamma = 1 $$, individuals either have or do not have a pathogenic configuration of alleles and have probabilities of being a case subject $$ \pi $$ and $$ \tau $$, respectively. Whether or not an individual has a pathogenic configuration of alleles depends on a function $$ f $$ of the genotypes $$ G_i $$ of that individual, a latent binary vector $$ z $$ indicating which of the $$ k $$ variants are pathogenic, a value $$ s_i $$ equal to the ploidy of the individual at the variant sites, and a variable $$ m $$ representing the mode of inheritance governing the disease etiology though the $$ k $$ variants:

$$
\gamma = 0 : \mathbb{P}(y_i = 1) = \tau_0,
$$

$$
\gamma = 1 : \mathbb{P}(y_i = 1) = 
\begin{cases} 
\tau & \text{if } f(G_{i \cdot}, z, s_i, m) = 2, \\
\pi & \text{if } f(G_{i \cdot}, z, s_i, m) = 1.
\end{cases}
$$

The function $$ f $$ can represent a dominant inheritance model or a recessive inheritance model that accounts for sex-dependent differences in ploidy on the X chromosome (i.e., X-linked recessive inheritance), depending on variable $$ m \in \{m_{\text{dom}}, m_{\text{rec}}\} $$:

$$
f(G_{i \cdot}, z, s_i, m_{\text{dom}}) = 1 \left( \sum_j G_{ij} z_j \geq 1 \right),
$$

$$
f(G_{i \cdot}, z, s_i, m_{\text{rec}}) = 1 \left( \sum_j G_{ij} z_j \geq s_i \right).
$$

Thus, the interpretation of $$ z $$ depends on the mode of inheritance. In order to have a pathogenic allele configuration, individual $$ i $$ requires at least one allele at a variant for which $$ z_j = 1 $$ under a dominant model, but $$ s_i $$ alleles under a recessive model. If genotypes are phased, then a requirement that the $$ s_i $$ pathogenic alleles are on different haplotypes can be imposed. Recent relatedness is a potential confounder because it is correlated with both case/control status and genotype and, therefore, only unrelated individuals should be included in the model.

We place beta priors on all three parameters representing risk of disease:

$$
\tau_0 \sim \text{Beta}(\alpha_0, \beta_0),
$$

$$
\tau \sim \text{Beta}(\alpha_\tau, \beta_\tau),
$$

$$
\pi \sim \text{Beta}(\alpha_\pi, \beta_\pi).
$$

The mean risk of disease for individuals without a pathogenic combination of alleles in the variants under consideration is uncertain under both models, and thus we place uniform priors on $$ \tau_0 $$ and $$ \tau $$ by default. However, as pathogenic combinations of alleles typically confer a high disease risk, we suggest setting the hyperparameters for $$ \pi $$ to $$ \alpha_\pi = 6 $$ and $$ \beta_\pi = 1 $$ (i.e., with a mean of $$ \frac{6}{7} $$). However, the prior mean could be adapted, for example, to reflect the consistency with which the disease manifests within families.



We adopt a logistic regression framework for the prior probability that the variants are pathogenic. The logit of the prior probabilities are shrunk toward a common mean, $$ \omega $$. If prior information that discriminates between the likely pathogenicity of variants is available, it can be incorporated in the form of a covariate $$ c $$ with regression coefficient $$ \phi $$ in the regression equation:

$$
z_j \sim \text{Bernoulli}(p_j),
$$

$$
\text{logit}(p_j) = \omega + \phi c_j.
$$

One would typically place a Gaussian prior on the intercept $$ \omega $$ but, for computational purposes, we prefer to use a logit-beta prior with hyperparameters $$ \alpha_\omega $$ and $$ \beta_\omega $$ (see [Appendix A](#app-1)). The prior mean of $$ \omega $$ should reflect the expected proportion of variants that are pathogenic, conditional on an association, and may depend on the filtering procedures used to select the variants to include in the model. By default, 

$$
p(\omega) = 0.20
$$

reflects a prior expectation that 20% of variants are pathogenic and a prior probability of only 0.01 that the proportion of pathogenic variants exceeds 0.54. This prior is well suited to missense variants but a distribution with a higher mean should be specified if most variants are expected to be pathogenic. This would be the case if the variants under consideration are all protein truncating and thought to be functionally equivalent to each other. To ensure that $$ \omega $$ can be interpreted as the global mean log odds of pathogenicity, the $$ c $$ are required to sum to zero. Thus, any user-supplied weights,

$$
c_j = \tilde{c}_j - \left(\frac{1}{k}\right) \sum_{l} \tilde{c}_l
$$

are centered such that. We place a log-normal prior on the regression coefficient $$ \phi $$ to force the effects of the $$ c_j $$ to be the same as their signs. The prior mean of $$ \phi $$ is set to 1 so that the $$ c_j $$ are interpretable as prior shifts in the log odds of pathogenicity relative to the mean. A prior variance on $$ \phi $$ of 0.35 ensures that the effect of the co-data can be diminished if the co-data are not informative and increased if they improve the model fit.

Finally, the prior probability on the mode of inheritance parameter $$ m $$ and the model indicator parameter $$ \gamma $$ need to be specified. By default, we set the prior probabilities for each mode of inheritance given an association to be the same, i.e.,

$$
\mathbb{P}(m = m_{\text{dom}} | \gamma = 1) = 0.5,
$$

and we assume that there is only a 1% chance a priori of an association, i.e.,

$$
\mathbb{P}(\gamma = 1) = 0.01.
$$

However, for a particular set of variants, the choice of values for these parameters could be based on the scientific literature or reference variant databases, for example.


### Inference

The principal quantity of interest is the posterior probability of the model indicator $$ \gamma $$, which can be derived from a Bayes factor comparing the two models and $$ \mathbb{P}(\gamma) $$. The Bayes factor has two components: the evidence under $$ \gamma = 0 $$ and the evidence under $$ \gamma = 1 $$. A closed-form expression exists for the evidence under either model and can be computed rapidly under $$ \gamma = 0 $$, irrespective of $$ y $$. However, the expression for the evidence under $$ \gamma = 1 $$ contains a sum over every possible value of $$ z $$, of which there are $$ 2^k $$, and $$ k $$ is usually large enough to render this sum computationally intractable.

To tackle this problem, we reviewed various methods for estimating the evidence of a model[^9] and chose the method of power posteriors[^10], which enables the evidence to be estimated by Markov chain Monte Carlo (MCMC) sampling. In this method, the MCMC is tempered, which is helpful in a variable selection setting such as ours because it makes exploration of the space of sets of pathogenic variants more efficient. Samples are drawn from a series of related distributions called power posteriors. Each power posterior has a temperature $$ t $$ between 0 and 1 and is proportional to the likelihood of the parameters to the power of $$ t $$ times the prior. These samples can be combined to obtain an estimate of the integrated likelihood (see [Appendix A](#app-1)).

Sampling for our model can be done very efficiently because an MCMC update to $$ z_j $$ entails changes only in $$ f(G_{i \cdot}, z, s_i, m) $$ for individuals for whom $$ G_{ij} > 0 $$. For convenience, we estimate the evidence conditional on $$ m $$ but we can integrate over it through simple summation. Once the MCMC samples have been collected, the marginal posterior probability of $$ z $$ given $$ \gamma $$ and $$ m $$ can be obtained directly and used for ranking variants by their likely pathogenicity. The estimated number of pathogenic variants and the expected posterior number of case subjects explained by the pathogenic variants, given $$ \gamma = 1 $$, can also be computed (see [Appendix A](#app-1)). The posterior probability of $$ \gamma $$ provides a natural means of ranking sets of variants from different loci across the genome.

The model above assumes that the prior probabilities of variant pathogenicity are conditionally independent. However, particular classes of variants in a locus may confer disease risk, while others may be benign. We can impose a prior correlation structure on the $$ z $$ reflecting these competing hypotheses by fitting a different association model for each class of variant. If one of the hypotheses matches the true etiology of disease, then this modeling approach can improve model fit and thus increase power. Let $$ \gamma \in \{1, 2, \ldots, g\} $$ index the association models and let $$ I_{uv} $$ indicate whether variant $$ v $$ is included in association model $$ u $$. Then, we can compute the probability of association across the competing models as:

$$
\mathbb{P}(\gamma > 0 | y, G, c, I) = \frac{\sum_{u=1}^g \mathbb{P}(y | \gamma = u, G^{(u)}, c^{(u)}) \mathbb{P}(\gamma = u)}{\sum_{u=0}^g \mathbb{P}(y | \gamma = u, G^{(u)}, c^{(u)}) \mathbb{P}(\gamma = u)},
$$

where $$ G^{(u)} = G \cdot \{v : I_{uv} = 1\} $$ and $$ c^{(u)} = c \{v : I_{uv} = 1\} $$. The prior on the model indicator, $$ \mathbb{P}(\gamma) $$, can be informed by external data. For example, if a gene has a high probability of loss-of-function intolerance[^11], then the prior corresponding to a model of high-impact variants in that gene could be up-weighted relative to competing models. We can also compute the posterior probability of variant pathogenicity averaged over all association models using the following expression:

$$
\mathbb{P}(z | \gamma > 0, y, G, c, I) = \frac{\sum_{u=1}^g \mathbb{P}(z | \gamma = u, y, G^{(u)}, c^{(u)}) \mathbb{P}(\gamma = u | y, G^{(u)}, c^{(u)})}{\sum_{u=1}^g \mathbb{P}(\gamma = u | y, G^{(u)}, c^{(u)})}.
$$

Other quantities of interest, such as the expected posterior number of cases explained by pathogenic variants, can be averaged over models in the same way.

# References
<https://cran.r-project.org/web/packages/BeviMed/>

[^6]: Logsdon, B.A., Dai, J.Y., Auer, P.L., et al., NHLBI GO Exome Sequencing Project. A variational Bayes discrete mixture test for rare variant association. Genet. Epidemiol. 2014; 38:21-30.
[^7]: Quintana, M.A., Berstein, J.L., Thomas, D.C., et al. Incorporating model uncertainty in detecting rare variants: the Bayesian risk index. Genet. Epidemiol. 2011; 35:638-649.
[^8]: Liang, F., Xiong, M. Bayesian detection of causal rare variants under posterior consistency. PLoS ONE. 2013; 8:e69633.
[^9]: Friel, N., Wyse, J. Estimating the evidence–a review. Stat. Neerl. 2012; 66:288-308.
[^10]: Friel, N., Pettitt, A.N. Marginal likelihood estimation via power posteriors. J. R. Stat. Soc. Series B Stat. Methodol. 2008; 70:589-607.
[^11]: Lek, M., Karczewski, K.J., Minikel, E.V., et al., Exome Aggregation Consortium. Analysis of protein-coding genetic variation in 60,706 humans. Nature. 2016; 536:285-291.
[^12]: Lin, W.-Y. Beyond rare-variant association testing: pinpointing rare causal variants in case-control sequencing study. Sci. Rep. 2016; 6:21824.


