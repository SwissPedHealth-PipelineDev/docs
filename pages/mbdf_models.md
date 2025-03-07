---
layout: default
title: MBDF models 
nav_order: 5
math: mathjax
---

<!-- date: 2024-08-27 00:00:01 -->

Last update: 20250307


{: .no_toc }
<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
- TOC
{:toc}
</details>

---

# Multiblock data fusion model options

This document outlines three levels of data fusion methods:

## High-level Data Fusion

- **Approach**: Integration of outcomes from individual models.
- **Key features**:
  - Treat each data block separately.
  - Combine summary statistics or predictions.
  - Utilise ensemble learning or voting schemes.
- **Use case**: When joint interpretation of biomarker patterns or decision fusion is desired.

## Mid-level Data Fusion

- **Approach**: Extract and integrate features from each data block.
- **Key features**:
  - Dimensionality reduction methods (e.g. PCA, PLS) to obtain scores.
  - Two-step procedure:
    - *Middle-Up*: Reduce dimensions then concatenate scores.
    - *Middle-Down*: Select key variables then concatenate subsets.
- **Use case**: When intermediate patterns or characteristics are needed for further analysis.

## Low-level Data Fusion

- **Approach**: Direct integration of raw signals or data.
- **Key features**:
  - Analyse relationships across data blocks.
  - Factor analysis or multiblock modelling to create components.
  - Optimise for both within-block representation and between-block correlation.
- **Use case**: When it is necessary to capture detailed inter-variable and inter-block relationships.

