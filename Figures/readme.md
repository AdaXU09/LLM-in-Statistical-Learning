# Figures — Study 1 and Study 2

This folder contains the R code and output files for all figures used in the paper. Figures cover both Study 1 (LLM objective and subjective performance) and Study 2 (human participant experiment results).

---

## Overview

This folder produces:

- **Study 1 figures:** LLM accuracy rankings and subjective quality ratings
- **Study 2 figures:** task accuracy, confidence, and attitude outcomes by experimental condition across stages

---

## Data Description

All input data files are located in the `data/` subdirectory.

### Input Files

| File | Description |
|------|-------------|
| `Study_1_Objective_Data.xlsx` | LLM objective accuracy data (Study 1) |
| `Study_1_Subjective_Data.xlsx` | Human subjective rating data (Study 1) |
| `Plot_Data.xlsx` | Pre-processed plot-ready data for Study 2 figures |
| `Correction_Data.csv` | Correction timing data for Study 2 early/late correction figure |

---

## Code Description

### Figure Scripts (R)

| File | Description |
|------|-------------|
| `Figure_Study1_1.Rmd` | Study 1 objective figure: LLM accuracy comparison across models and thinking modes (bar/dot plots with error bars) |
| `Figure_Study1_2.Rmd` | Study 1 subjective figure: quality rating comparison across top/bottom models by rater group |
| `Figure_Study2_1.Rmd` | Study 2 accuracy figure: task accuracy by condition (AI / AI Human / Human) across stages |
| `Figure_Study2_2.Rmd` | Study 2 confidence figure: confidence ratings by condition across stages |
| `Figure_Study2_3.Rmd` | Study 2 attitude figure: AI attitude outcomes (trust, affect, usefulness, intention) by condition |
| `plot_util_test.R` | Utility script for plot theme and formatting |

---

## Software Requirements

**R (version 4.0+):**
`tidyverse`, `readxl`, `dplyr`, `tidyr`, `ggplot2`, `cowplot`, `lemon`, `showtext`, `patchwork`, `ggrepel` *(Figure_Study1_1 only)*, `Rmisc` *(Figure_Study2_1 only)*

---

## Output Files

All figures are saved in the `figure/` subdirectory:

| File | Formats | Description |
|------|---------|-------------|
| `Figure_Study1_1` | PDF, PNG, SVG | Study 1 objective figure |
| `Figure_Study1_2` | PDF, PNG, SVG | Study 1 subjective figure |
| `Figure_Study2_1` | PDF, PNG, SVG | Study 2 accuracy figure |
| `Figure_Study2_2` | PDF, PNG, SVG | Study 2 confidence figure |
| `Figure_Study2_3` | PDF, PNG, SVG | Study 2 attitude figure |
