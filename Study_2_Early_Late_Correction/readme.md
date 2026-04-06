# Study 2 — Early vs. Late Correction Analysis

This folder contains the data and R code for the correction timing analysis in Study 2, examining whether participants who corrected a wrong answer early (by Stage 2) retain that knowledge better at follow-up than those who corrected it later (by Stage 3 only).

---

## Data Description

All data files are located in the `data/` subdirectory.

### Input Files

| File | Description |
|------|-------------|
| `correction_raw_data.xlsx` | Raw item-level response data with stage and follow-up answers for all participants |
| `correction_processed_data.xlsx` | Preprocessed version of the correction dataset |

### Key Variables (in `correction_raw_data.xlsx`)

| Variable | Description |
|----------|-------------|
| `ID` | Participant identifier |
| `Label` | Experimental condition (`AI` / `AI Human` / `Human`) |
| `overall_accuracy_stage1` | Stage 1 overall accuracy (covariate) |
| `stage1_t[1-3]_q[1-6]` | Stage 1 responses per task and item |
| `stage2_t[1-3]_q[1-6]` | Stage 2 responses per task and item |
| `stage3_t[1-3]_q[1-6]` | Stage 3 responses per task and item |
| `follow_up_t[1-3]_q[1-6]` | Follow-up responses per task and item |

**Processed variables:**

| Variable | Description |
|----------|-------------|
| `S1c`, `S2c`, `S3c`, `FUc` | Boolean correctness indicators per stage |
| `EarlyCorrected` | `1` = corrected by Stage 2; `0` = corrected only by Stage 3 |
| `Item` / `Task` | Item and task identifiers (factors) |

**Item truth key:**

| Task | Items | Correct Answer |
|------|-------|----------------|
| t1 | q1–q6 | All `FALSE` |
| t2 | q1–q5 | All `FALSE` |
| t3 | q1 | `FALSE` |
| t3 | q2–q4 | `TRUE` |
| t3 | q5 | `FALSE` |
| t3 | q6 | `TRUE` |

**Inclusion criteria:**
- Only participants with at least one follow-up response are included
- Analysis subset: `S1c == FALSE` and `(S2c | S3c)` and `!is.na(FUc)`

---

## Code Description

### Analysis Files (R)

| File | Description |
|------|-------------|
| `Comparison.Rmd` | Full correction timing analysis: data loading, item scoring, and long-format pivot; subset to early/late correctors with follow-up; descriptive table of follow-up accuracy by `Label` and `EarlyCorrected` group; primary logistic mixed model (GLMM) for follow-up correctness with `EarlyCorrected * Label + Task + Stage 1 accuracy + (1\|ID) + (1\|Item)`; odds ratios with 95% CIs; Type III ANOVA and post-hoc `emmeans` contrasts; model comparison (with/without Task interaction) |

**Primary model formula:**

```r
glmer(FUc ~ EarlyCorrected * Label + Task + overall_accuracy_stage1 +
        (1 | ID) + (1 | Item),
      data = analysis, family = binomial)
```

---

## Software Requirements

**R (version 4.0+):**
`readxl`, `dplyr`, `tidyr`, `stringr`, `lme4`, `broom.mixed`, `car`, `emmeans`, `parameters`, `performance`

---

## Output

Results are printed directly to R output.
