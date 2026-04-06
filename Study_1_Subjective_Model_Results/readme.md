# Study 1 — Subjective Rating Mixed-Effects Models

This folder contains the data and R code for the inferential mixed-effects model analyses of human subjective quality ratings of LLM responses in Study 1.

---

## Data Description

All data files are located in the `data/` subdirectory.

### Input Files

| File | Description |
|------|-------------|
| `Study_1_Subjective_Data.xlsx` | Human ratings of LLM-generated responses |

### Key Variables

| Variable | Description |
|----------|-------------|
| `ID` | Rater identifier |
| `Model` | LLM model rated |
| `Task` | Statistics task |
| `Profession` / `RaterGroup` | Rater role (`Student` / `Instructor`) |
| `Iteration` / `Attempt` | Repeated rating index |
| `Rater` | Compound rater ID (`RaterGroup_ID`) |
| `Statistical_Accuracy`, `Clarity_and_Structure`, `Conceptual_Depth`, `Pedagogical_Effectiveness` | Four rating dimensions (numeric) |

---

## Code Description

### Analysis Files (R)

| File | Description |
|------|-------------|
| `Study 1 Subjective Model Results.Rmd` | Mixed-effects model analysis: four competing `lmer` models (varying random-effects structure for Rater and Attempt); model comparison via AIC/BIC; Type III ANOVA + eta-squared effect sizes; post-hoc `emmeans` contrasts (ModelGroup, RaterGroup, interaction); model diagnostics (residual plots, collinearity checks) |

### Model Specifications

```
Model 1: OverallQuality ~ ModelGroup * RaterGroup * Task + (1|Rater) + (1|Attempt)   [main model]
Model 2: OverallQuality ~ ModelGroup * RaterGroup + (1|Rater)
Model 3: OverallQuality ~ ModelGroup * RaterGroup + (ModelGroup|Rater)
Model 4: OverallQuality ~ ModelGroup * RaterGroup + (ModelGroup|Rater) + (1|Attempt)
```

---

## Software Requirements

**R (version 4.0+):**
`readxl`, `dplyr`, `stringr`, `lme4`, `lmerTest`, `car`, `effectsize`, `emmeans`, `performance`, `report`, `ggplot2`, `cleanrmd` *(optional, for themed HTML output)*

---

## Output

Results are printed directly to R output.
