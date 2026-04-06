# Study 2 — Main Experiment Results

This folder contains the data and R code for the main analyses of Study 2, a human-participant experiment examining how LLM assistance affects statistics task performance, confidence, AI attitudes, and behavioral intentions across three learning stages.

---

## Overview

This folder contains:

1. Main inferential results (mixed models, moderation analyses)
2. Demographic balance checks across conditions
3. p-value adjustment for multiple comparisons (`additional/`)

---

## Data Description

All data files are located in the `data/` subdirectory.

### Input Files

| File | Description |
|------|-------------|
| `Study_2_Main_Results_Data.xlsx` | Participant-level data for the main Study 2 sample |

### Key Variables

**Experimental condition:**

| Variable | Description |
|----------|-------------|
| `Label` | AI condition (`AI` / `AI Human` / `Human`) |

**Pre-study measures:**

| Variable | Description |
|----------|-------------|
| `Pre_GLAT_Objective_AI_Literacy` | Objective AI literacy (GLAT scale) |
| `Pre_AILS_CCS_Subjective_AI_Literacy` | Subjective AI literacy (AILS-CCS) |
| `Pre_AI_Trust` | AI trust attitude |
| `Pre_AI_Usefulness` | Perceived AI usefulness |
| `Pre_AI_Affect` | Affective response toward AI |
| `Pre_AI_Self_Efficacy` | AI self-efficacy |
| `Pre_Behavioral_Intention` | Behavioral intention to use AI |

**Task performance (per stage and task):**

| Variable | Description |
|----------|-------------|
| `stage[1-3]_task[0-3]_accuracy` | Proportion correct (0–1) |
| `stage[1-3]_task[0-3]_confidence` | Confidence rating |
| `stage[2-3]_task[0-3]_willing` | Willingness to accept AI guidance/answers |
| `stage[2-3]_task[0-3]_useful` | Perceived usefulness of AI guidance/answers |

**Post-study measures:**
`Post_AI_Trust`, `Post_AI_Usefulness`, `Post_AI_Affect`, `Post_Behavioral_Intention`

**Moderator variables:**
`Gender`, `Age`, `Identity`, `Field`, `Stats_Background`, `Used_LLM_Frequency`, `Used_LLM_Hours`

> **Exclusion criterion:** Participants with `stage1_task0_accuracy >= 0.9` are excluded (ceiling-performance filter).

---

## Code Description

### Main Analysis (R)

| File | Description |
|------|-------------|
| `Study 2 Main Results.Rmd` | Primary analysis: data loading and preprocessing; mixed-effects models for accuracy, confidence, willing, and useful across stages; pre-post attitude change analyses (AI trust, affect, usefulness, intention); moderation analyses by stats background, LLM experience, and demographics |
| `Study 2 Main Demographic Results.Rmd` | Demographic balance checks: distribution tables for Label, Gender, Age, Identity, Field, Stats_Background, LLM usage; chi-square tests for condition balance across all demographics |

### Additional Analysis (R)

| File | Description |
|------|-------------|
| `p-value adjudication.Rmd` | Applies Holm and Benjamini-Hochberg (BH) corrections to moderation effect p-values, grouped by dependent variable |

---

## Software Requirements

**R (version 4.0+):**
`broom`, `broom.mixed`, `car`, `DescTools`, `dplyr`, `tidyr`, `stringr`, `forcats`, `tibble`, `DT`, `effectsize`, `emmeans`, `ggplot2`, `interactions`, `janitor`, `lme4`, `lmerTest`, `lsr`, `MASS`, `openxlsx`, `readxl`, `ordinal`, `performance`, `report`, `bruceR` *(`additional/` only)*

---

## Output

Main results are printed to R/HTML output. The p-value adjustment script exports an adjusted results file to `results/`.
