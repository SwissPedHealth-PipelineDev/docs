---
layout: default
math: mathjax
title: DNA annotation
nav_order: 5
---

Last update: 20241216
# DNA annotation

* TOC
{:toc}

---

Variant annotation is a critical step in clinical and statistical genetics.
Popular tools for applying annotation data to VCF format genetic data include:

* Variant Effect Predictor (VEP) [link: VEP](http://www.ensembl.org/info/docs/tools/vep/index.html)
* NIRVANA [link: NIRVANA](https://illumina.github.io/NirvanaDocumentation/)
* ANNOVAR [link: ANNOVAR](https://annovar.openbioinformatics.org/en/latest/)

We are using [VEP](http://www.ensembl.org/info/docs/tools/vep/index.html) with [Conda](https://docs.conda.io/en/latest/), but we are likely to test additional methods
([licence](http://www.ensembl.org/info/about/legal/code_licence.html)).
Additionally, these tools must be paired with a set of data sources containing the annotation information which will be applied to each variant.
* [View our list of approx. 160 databases]({{ site.baseurl }}{% link pages/annotation_table.md %}).

The variant consequence may be one of the defining criteria by which variants can 
be included in analysis since they are _interpretable_ or of ostensibly _known significance_.

The consequences provided by VEP can provide a simple reference example to understand its function.
For example, HIGH impact variants might be a likely consequence for identifying candidates disease-causing:
[Ensembl Variation - Calculated variant consequences](https://grch37.ensembl.org/info/genome/variation/prediction/predicted_data.html#consequences).\

{: .note }
You may have observed cases in literature where clinical research reporting relied on variant effect consequence alone for known disease-related genes, but this practice is likely to introduce spurious results. 
It is important to use established criteria for selecting consequences of interest combined with additional filtering methods to define evidence thresholds.
See the ACMG interpretation standards for examples.

<img 
src="{{ "pages/design_doc/images/VEP_consequences.jpg" | relative_url }}"
width="100%">

