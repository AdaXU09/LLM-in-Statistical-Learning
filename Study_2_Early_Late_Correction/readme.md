# Study 2 — Early vs. Late Correction (Exploratory)

Exploratory item-level analysis of whether misconceptions corrected early (by
Stage 2, under the explanation alone) are retained at follow-up better than those
corrected late (only after Stage 3 answer disclosure), and whether this depends
on source label.

## Data (`data/`)

`correction_raw_data.xlsx` — raw item-level responses with stage and follow-up answers.

| Variable | Description |
|----------|-------------|
| `ID` | Participant identifier |
| `Label` | Condition (`AI` / `AI Human` / `Human`) |
| `overall_accuracy_stage1` | Stage 1 overall accuracy (covariate) |
| `stage[1-3]_t[1-3]_q[1-6]` | Stage 1–3 responses per task and item |
| `follow_up_t[1-3]_q[1-6]` | Follow-up responses per task and item |

**Processed**

| Variable | Description |
|----------|-------------|
| `S1c`, `S2c`, `S3c`, `FUc` | Boolean correctness per stage |
| `CorrectionTiming` | `Early` (corrected by Stage 2) vs. `Late` (only by Stage 3) — main predictor |
| `EarlyCorrected` | 0/1 recoding (`1` = Early); outcome in the S3 selection test |
| `difficulty_c` | Item-difficulty proxy: centered Stage-1 full-sample accuracy (larger = easier) |
| `Item` / `Task` | Item and task identifiers (factors) |

**Item truth key:** t1 q1–q6 `FALSE`; t2 q1–q5 `FALSE`; t3 q1 `FALSE`, q2–q4 `TRUE`, q5 `FALSE`, q6 `TRUE`.

**Analysis subset:** `S1c == FALSE` and `(S2c | S3c)` and `!is.na(FUc)` (participants with ≥1 follow-up response).

## Notebook

`Comparison.Rmd` — item scoring and long-format pivot; difficulty-controlled
logistic mixed model for follow-up correctness, with descriptives, odds ratios
(95% CI), Type-III ANOVA, and `emmeans` contrasts (including condition-specific
Early-vs-Late odds ratios). Supplementary/sensitivity sections (S1–S7): model
without difficulty; label effects among corrected items (±difficulty); selection
test on early/late difficulty composition; early-corrected subset (±difficulty);
manipulation-passers-only; and perceived (as-recalled) label.

```r
glmer(FUc ~ CorrectionTiming * Label + Task + difficulty_c + overall_accuracy_stage1 +
        (1 | ID) + (1 | Item),
      data = analysis_diff, family = binomial)
```

Results print to the rendered HTML; no workbooks are written.

Packages (pinned in the top-level `renv.lock`): `readxl`, `dplyr`, `tidyr`,
`stringr`, `lme4`, `broom.mixed`, `car`, `emmeans`, `parameters`, `performance`.
