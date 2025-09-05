# Comparative Analysis of Polygenic Scores in Huntington’s Disease

This repository contains the report and analysis code for my Master’s case study project:

**Comparative Analysis of Polygenic Scores' Predictive Ability on Age at Onset in an Enroll-HD GWAS Cohort of Huntington's Disease Patients**  

## Overview

Huntington’s disease (HD) is a neurodegenerative disorder caused by an expanded CAG repeat in the *HTT* gene. While CAG length strongly predicts age at onset (AAO), there is substantial variability between individuals with the same repeat length. This project investigates whether **polygenic scores (PGS)** can explain some of this variability, focusing on:

- **Clumping and Thresholding (C+T)** with PLINK  
- **PRS-CS** (Bayesian continuous shrinkage approach)

The analysis evaluates how well these methods predict **residual AAO** (the portion of AAO not explained by CAG length) in the Enroll-HD GWAS cohort.

## Data

- **Test dataset:** Enroll-HD GWAS release 6 (GWA6), ~3,800 individuals with CAG length 40–55.  
- **LD reference:** GWA345 LD statistics for C+T; UK Biobank EUR reference panel for PRS-CS.

## Methods

1. **C+T with PLINK**  
   - SNP clumping at R² = 0.1  
   - P-value thresholds: 1e-8 to 1.0  
   - Polygenic scores computed at each threshold  

2. **PRS-CS**  
   - Chromosome-wise scoring with SLURM job array  
   - European LD reference panel  
   - Continuous shrinkage priors  

3. **Regression models**  
   - Outcome: residual AAO (after adjusting for CAG length)  
   - Covariates: sex and 4 principal components  
   - Model fit assessed via R², AIC, BIC  

> All scripts were run in the command line using Cardiff University super computer HAWK for efficient processing

## Key Findings

- **C+T outperformed PRS-CS** at stringent thresholds (p ≤ 1e-6, 1e-8), with better model fit and lower AIC/BIC.  
- **PRS-CS** was highly significant but explained less variance.  
- **Male sex** was consistently associated with earlier onset across all models.  
- Overall predictive power remained modest (max adjusted R² < 5%), suggesting non-genetic factors also contribute to AAO.  

These results support the idea that HD AAO may be influenced by a relatively sparse set of modifier loci, making simpler approaches like C+T more effective than PRS-CS in this context.

## Repository Contents

- **`report/`** – Full project report (PDF, ~2000 words)  
- **`code/`** – Pipelines and scripts for C+T and PRS-CS analyses  
- **`results/`** – Output files and summary tables  

## Acknowledgements

- **Enroll-HD** for providing GWAS data (GWA6, GWA345)  
- Tools: [PLINK](https://www.cog-genomics.org/plink/), [PRS-CS](https://github.com/getian107/PRScs)  
- Supervisors and colleagues at Cardiff University for feedback and support

