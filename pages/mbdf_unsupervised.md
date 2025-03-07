---
layout: default
title: MBDF unsupervised
nav_order: 5
math: mathjax
---

# MBDF unsupervised analysis

Last update: 20250307

This document presents an unsupervised multiblock analysis using ComDim, which extracts common dimensions from multiple data blocks. In this case, gene expression and lipid concentration data from the nutrimouse study are combined, creating a single data matrix with known block sizes. The analysis centres on computing global components, $T_g$, by performing a multiblock weighted principal components analysis. In effect, each global component is computed as a linear combination of the original variables via weights, i.e.  
$$
T_g = XW_g,
$$  
where $X$ is the concatenated data matrix and $W_g$ represents the global weights.

The output from the ComDim analysis includes several key elements. The matrix of saliences contains block-specific weights that reveal each block's contribution to the global components. Global scores ($Scor.g$) project the original samples into the common space, while global loadings ($Load.g$) indicate the contribution of each variable to these components. Additionally, the explained inertia is provided both per block and cumulatively, allowing one to assess the proportion of total variance captured by the components.

By visualising the scores on different dimensions (for example, plotting Dim.1 vs Dim.2 or Dim.3 vs Dim.4), the analysis identifies clusters of samples and highlights the main sources of variation in the data. Loadings plots further reveal which genes and lipids drive these variations. The document also shows how the analysis can be repeated on specific subsets (e.g. wild-type or PPAR samples only) to explore group-specific data structures.

This unsupervised multiblock analysis with ComDim offers a comprehensive way to integrate and explore the shared structure of complex datasets by extracting common dimensions and examining the contributions of each data block.

