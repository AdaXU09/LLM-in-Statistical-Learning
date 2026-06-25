# Figures — Study 1 and Study 2

R notebooks generating all paper figures, with outputs in `figure/` (PDF, PNG,
SVG; rendered at 600 dpi in Arial via `showtext`, falling back to the default
sans family if Arial is absent).

## Data (`data/`)

| File | Description |
|------|-------------|
| `Study_1_Objective_Data.xlsx` | LLM objective accuracy (Study 1) |
| `Study_1_Subjective_Data.xlsx` | Human subjective ratings (Study 1) |
| `Plot_Data.xlsx` | Plot-ready data for Study 2 figures |
| `Correction_Data.csv` | Early/late correction data for the Study 2 correction figure |

## Notebooks

| File | Figure |
|------|--------|
| `Figure_Study1_1.Rmd` | Study 1 objective: LLM accuracy across models and thinking modes |
| `Figure_Study1_2.Rmd` | Study 1 subjective: quality ratings, top/bottom models by rater group |
| `Figure_Study2_1.Rmd` | Study 2 accuracy by condition across stages |
| `Figure_Study2_2.Rmd` | Study 2 confidence by condition across stages |
| `Figure_Study2_3.Rmd` | Study 2 AI attitudes (trust, affect, usefulness, intention) by condition |
| `plot_util_test.R` | Helper `data_preprocessing()`: wide→long reshape, within-subject normalisation, Cousineau–Morey 95% CIs |

Each notebook writes its figure to `figure/` in PDF, PNG, and SVG.

Packages (pinned in the top-level `renv.lock`): `tidyverse`, `readxl`, `dplyr`,
`tidyr`, `ggplot2`, `cowplot`, `lemon`, `showtext`, `patchwork`,
`ggrepel` (Figure_Study1_1 only), `Rmisc` (Figure_Study2_1 only).
