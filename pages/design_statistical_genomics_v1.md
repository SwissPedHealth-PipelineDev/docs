---
layout: default
title: Design statistical genomics v1
parent: Design documents
has_children: false
nav_order: 5
---

Last update: 20241217

# Design statistical genomics v1

---
* TOC
{:toc}
---

**Protocol name**: `design_statistical_genomics_v1`

Statistical genomics to find new cohort-level associations with disease.
This documention is an incomplete placeholder.
This protocol is made up of several steps which together make the joint analysis.
Pages on individual methods include [VSAT](vsat.html), [setID](vsat_setID.html), [ACAT](acat.html), [GWAS](gwas.html).

This set of analysis use `Design DNA SNV INDEL v1` followed by `QV SNV INDEL v1` as input.
The following aims are then used to reach the joint analysis.

## Aims

| Phase   | Aim  | Status              | Task                                                         |
|:-------:|:----:|---------------------|--------------------------------------------------------------|
| Phase 2 | (0)  | Complete                       | QC, PCA, clinical covariates, outcomes            |
| Phase 2 | (1)  | In progress <br> Test complete | Single variant association test (SVAT)            |
| Phase 2 | (2)  | In progress <br> Test complete | Variant set association test (VSAT) gene-level    |
| Phase 2 | (3)  | Complete                       | ProteoMCLusteR to generate pathway setID          |
| Phase 2 | (4)  | In progress <br> Test complete | Variant set association test (VSAT) pathway-level |
| Phase 2 | (5)  | Complete                       | ACMGuru total score                               |
| Phase 2 | (6)  | In progress <br> Test complete | Multiomic ACAT                                    |
