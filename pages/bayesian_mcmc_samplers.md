---
title: "Bayes MCMC samplers"
layout: default
nav_order: 5
math: mathjax
---

Last update: 20241204

# The Markov-chain Monte Carlo (MCMC) sampler gallery


This page is cloned from Chi Feng at <https://github.com/chi-feng/mcmc-demo> to have an important references for MCMC samplers. 


The following demo shows a multimodal dataset with Gibbs sampling. 

<iframe src="https://chi-feng.github.io/mcmc-demo/app.html?algorithm=GibbsSampling&target=multimodal" style="width:100%; height:600px;" frameborder="0">
    Your browser does not support iframes.
</iframe>

Click on an algorithm below to view interactive demo:

- [Random Walk Metropolis Hastings](app.html?algorithm=RandomWalkMH&target=banana)
- [Adaptive Metropolis Hastings](app.html?algorithm=AdaptiveMH&target=banana) [[1]](#ref-1)
- [Hamiltonian Monte Carlo](app.html?algorithm=HamiltonianMC&target=banana) [[2]](#ref-2)
- [No-U-Turn Sampler](app.html?algorithm=NaiveNUTS&target=banana) [[2]](#ref-2)
- [Metropolis-adjusted Langevin Algorithm (MALA)](app.html?algorithm=MALA&target=banana) [[3]](#ref-3)
- [Hessian-Hamiltonian Monte Carlo (H2MC)](app.html?algorithm=H2MC&target=banana) [[4]](#ref-4)
- [Gibbs Sampling](app.html?algorithm=GibbsSampling&target=banana)
- [Stein Variational Gradient Descent (SVGD)](app.html?algorithm=SVGD&target=banana&delay=0) [[5]](#ref-5)
- [Nested Sampling with RadFriends (RadFriends-NS)](app.html?algorithm=RadFriends-NS&target=banana) [[6]](#ref-6)
- [Differential Evolution Metropolis (Z)](app.html?algorithm=DE-MCMC-Z&target=banana) [[7]](#ref-7)
- [Microcanonical Hamiltonian Monte Carlo](app.html?algorithm=MiMicrocanonicalHamiltonianMC&target=banana) [[8]](#ref-8)

View the source code on GitHub: [https://github.com/chi-feng/mcmc-demo](https://github.com/chi-feng/mcmc-demo).

## References

- [1] H. Haario, E. Saksman, and J. Tamminen, [An adaptive Metropolis algorithm](http://projecteuclid.org/euclid.bj/1080222083) (2001)
- [2] M. D. Hoffman, A. Gelman, [The No-U-Turn Sampler: Adaptively Setting Path Lengths in Hamiltonian Monte Carlo](http://arxiv.org/abs/1111.4246) (2011)
- [3] G. O. Roberts, R. L. Tweedie, [Exponential Convergence of Langevin Distributions and Their Discrete Approximations](http://www2.stat.duke.edu/~scs/Courses/Stat376/Papers/Langevin/RobertsTweedieBernoulli1996.pdf) (1996)
- [4] Li, Tzu-Mao, et al. [Anisotropic Gaussian mutations for metropolis light transport through Hessian-Hamiltonian dynamics](https://people.csail.mit.edu/tzumao/h2mc/) ACM Transactions on Graphics 34.6 (2015): 209.
- [5] Q. Liu, et al. [Stein Variational Gradient Descent: A General Purpose Bayesian Inference Algorithm](http://www.cs.dartmouth.edu/~dartml/project.html?p=vgd) Advances in Neural Information Processing Systems. 2016.
- [6] J. Buchner [A statistical test for Nested Sampling algorithms](https://arxiv.org/abs/1407.5459) Statistics and Computing. 2014.
- [7] Cajo J. F. ter Braak & Jasper A. Vrugt [Differential Evolution Markov Chain with snooker updater and fewer chains](https://link.springer.com/article/10.1007/s11222-008-9104-9) Statistics and Computing. 2008.
- [8] Jakob Robnik, G. Bruno De Luca, Eva Silverstein, Uroš Seljak [Microcanonical Hamiltonian Monte Carlo](https://arxiv.org/abs/2212.08549)

