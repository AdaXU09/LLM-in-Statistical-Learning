# Study 2 — Follow-Up Results

This folder contains the data and R code for the follow-up wave of Study 2, which re-assessed participants on the same statistics tasks to examine retention of learning after the original three-stage experiment.

---

## Overview

This folder contains:

- Main follow-up results (learning retention, attitude outcomes)
- Follow-up demographic checks
- Additional analyses: attrition bias checks, missing-at-random (MAR) tests, drop comparison, and p-value adjustment

---

## Data Description

All data files are located in the `data/` subdirectory.

### Input Files

| File | Description |
|------|-------------|
| `Study_2_Followup_Data.xlsx` | Follow-up subsample data (participants who completed the follow-up wave) |

**Additional file used in `additional/` analyses only:**

| File | Description |
|------|-------------|
| `Study_2_Full_Data.xlsx` | Full Study 2 dataset including non-completers (for attrition/MAR analyses) |

### Key Variables

Same variables as Study 2 Main (see `Study_2_Main_Results/readme.md`), with the addition of:

| Variable | Description |
|----------|-------------|
| `drop` | Indicator for follow-up non-completion (`0` = completed, `1` = dropped out) — used in `additional/` analyses only |

Follow-up task accuracy and confidence variables parallel the `stage[1-3]` naming convention.

> **Exclusion criterion:** Participants with `stage1_task0_accuracy >= 0.9` are excluded.

---

## Code Description

### Main Analysis (R)

| File | Description |
|------|-------------|
| `Study 2 Follow-Up Only Results.Rmd` | Primary follow-up analysis: retention accuracy by condition (AI / AI Human / Human); confidence and attitude outcomes at follow-up; mixed models paralleling main study analyses |
| `Study 2 Follow-Up Only Demographic Results.Rmd` | Demographic checks for the follow-up subsample: Label, Gender, Age, Identity, Field, Stats_Background, LLM usage distributions; chi-square tests for condition balance |

### Additional Analyses (R) — `additional/` subfolder

| File | Description |
|------|-------------|
| `Study 2 Drop Comparison.Rmd` | Attrition analysis: t-tests comparing completers vs. dropouts on accuracy, confidence, and all pre/post AI attitude measures |
| `Study 2 Drop Demographic Results.Rmd` | Demographic breakdown for the full sample (completers + dropouts) with chi-square tests |
| `Study 2 MAR Results.Rmd` | Missing-at-random (MAR) tests: full Study 2 data analysis to assess whether dropout is random with respect to key outcomes |
| `p-value adjudication.Rmd` | Holm and BH corrections for follow-up moderation p-values |

---

## Software Requirements

**R (version 4.0+):**
`broom`, `car`, `DescTools`, `dplyr`, `tidyr`, `stringr`, `forcats`, `DT`, `effectsize`, `emmeans`, `ggplot2`, `interactions`, `janitor`, `lme4`, `lmerTest`, `lsr`, `MASS`, `openxlsx`, `readxl`, `ordinal`, `performance`, `report`, `bruceR` *(`additional/p-value adjudication.Rmd` only)*

---

## Output

Results are printed to R output.
