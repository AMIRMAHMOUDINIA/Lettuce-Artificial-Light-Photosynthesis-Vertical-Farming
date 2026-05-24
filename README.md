# LED Spectrum Effects on Lettuce Photosynthesis and Chlorophyll Fluorescence

This repository contains a small reproducible R-based plant physiology project on how red:blue LED spectra affect lettuce photosynthesis, chlorophyll fluorescence traits, and biomass response under controlled-environment conditions.

The aim is to demonstrate a complete, transparent analysis workflow: organized data, documented variables, reproducible R code, publication-style figures, and a concise biological interpretation.

## Project question

How do different red:blue LED ratios influence photosynthetic performance, fluorescence-based indicators, and biomass response in lettuce?

## Dataset

The dataset is provided in:

```text
data/utphotolab_lettuce_LED.csv
```

Main variables:

- `Pn`: net photosynthetic rate
- `Fv_Fm`: maximum quantum yield of photosystem II
- `PhiII`: operating efficiency of photosystem II
- `dry_weight_g`: shoot dry weight
- `blue_pct`: blue-light fraction in the LED spectrum

A full variable description is provided in `docs/DATA_DICTIONARY.md`.

## Figures

### 1. Net photosynthetic rate

![Net Photosynthetic Rate](figures/01_LED_Pn_by_treatment_clean.png)

### 2. Maximum quantum yield of PSII

![Fv/Fm](figures/02_LED_FvFm_by_treatment_clean.png)

### 3. Operating efficiency of PSII

![PhiII](figures/03_LED_PhiII_by_treatment_clean.png)

### 4. Photosynthesis and biomass response

![Pn vs Dry Weight](figures/04_Pn_vs_DryWeight_normalized_clean.png)

## Short interpretation

Net photosynthesis increased under mixed red:blue spectra compared with red-only light. The strongest photosynthetic response occurred under intermediate red:blue conditions, while shoot dry weight followed a different pattern. This suggests that controlled-environment lighting should be assessed using photosynthesis, chlorophyll fluorescence indicators, and growth outcomes together, rather than relying on a single physiological variable.

## How to regenerate the figures

Open RStudio, set this repository folder as the working directory, and run:

```r
source("scripts/01_generate_figures.R")
```

The figures will be saved in the `figures/` folder.

## Repository structure

```text
.
├── README.md
├── data/
│   └── utphotolab_lettuce_LED.csv
├── figures/
│   ├── 01_LED_Pn_by_treatment_clean.png
│   ├── 02_LED_FvFm_by_treatment_clean.png
│   ├── 03_LED_PhiII_by_treatment_clean.png
│   ├── 04_Pn_vs_DryWeight_normalized_clean.png
│   └── summary_table_for_figures.csv
├── scripts/
│   └── 01_generate_figures.R
└── docs/
    ├── DATA_DICTIONARY.md
    └── GITHUB_UPLOAD_STEPS.md
```

## Data provenance

The measurements in this dataset were collected during a vertical 
farming internship I completed in 2022 as part of my Bachelor's 
degree. We were growing lettuce under different LED lighting 
setups in a controlled environment, and I recorded photosynthetic 
and fluorescence readings across the red:blue treatment levels. 
I later used these observations to build this analysis in R, 
mainly to practice working with plant physiology data in a 
reproducible and documented way.

## Note

This is a portfolio project. The analysis was done independently 
after the internship, and the goal was to apply quantitative 
skills to real controlled-environment data rather than leave the 
measurements sitting in a notebook.
