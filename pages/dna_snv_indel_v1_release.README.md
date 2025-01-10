### Release DNA SNV INDEL v1

* Name: `release_dna_snv_indel_v1` <https://swisspedhealth-pipelinedev.github.io/docs/pages/design_dna_snvindel_v1_release.html>
* Source: `design_dna_snvindel_v1` <https://swisspedhealth-pipelinedev.github.io/docs/pages/design_dna_snvindel_v1.html>
* Tree:

```
├── annotation
├── checksums.md5
├── dna_snv_indel_v1_release.out
├── dna_snv_indel_v1_release.README.md
├── dna_snv_indel_v1_release.sh.log
└── PCA
```

#### QV1 gVCF files

* `source: ${ANNOTATION_DIR}`
* `${RELEASE_DNA_SNV_INDEL_V1}/annotation/chr*_bcftools_gatk_norm_decom_maf.recode_vep_dbnsfp.vcf.gz*`

#### QV1 gVCF logs

* `source: /data/wgs/log/annotation`
* `${RELEASE_DNA_SNV_INDEL_V1}/annotation/log`

#### QV1 gVCF scripts

* `source: 14_annotation_conda.sh`
* `${RELEASE_DNA_SNV_INDEL_V1}/annotation/14_annotation_conda.sh.log`

#### PCA files

* `source: ${PCA_DATA}/PCA`

#### PCA scripts

* `${RELEASE_DNA_SNV_INDEL_V1}/PCA`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/19a_pca_prep_1kg.sh.log`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/20a_pca_1kg.sh.log`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/20c_pca_1kg_swisspedhealth.sh.log`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/19b_pca_prep_swisspedhealth.sh.log`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/20b_pca_swisspedhealth.sh.log`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/21b_pca_biplot_1kg_part3_ggplot_vcurrent.R.log`
