# Study 2 — Long-Term Main Analysis (MAR, Full Sample *N* = 175)

The main long-term analysis reported in the paper body. Uses the full Study 2
sample (*N* = 175) and handles missing follow-up data under a missing-at-random
(MAR) assumption — mixed-effects models that use all available data. The
completers-only sensitivity check is the sibling
[`../Follow-Up Completers Only/`](../Follow-Up%20Completers%20Only/) (*N* = 84);
both run the same H1/H2/H3 models.

## Data (`data/`)

`Study_2_Full_Data.xlsx` — full sample (*N* = 175), including follow-up non-completers.
Variables follow Study 2 Main (see `../../Study_2_Main_Results/readme.md`), plus
`drop` (follow-up non-completion: `0` = completed, `1` = dropped) used by the
attrition diagnostics.

> **Exclusion:** participants with `stage1_task0_accuracy >= 0.9` (ceiling filter).

## Notebooks

| File | Description |
|------|-------------|
| `Study 2 MAR Results.Rmd` | Main analysis: H1 long-term accuracy; H2 long-term confidence and attitude change (Pre→Follow, Pre→Post→Follow); H3 moderation — full sample under MAR |
| `Study 2 Drop Comparison.Rmd` | Attrition diagnostic: completers vs. dropouts on accuracy, confidence, and pre/post attitudes |
| `Study 2 Drop Demographic Results.Rmd` | Demographic comparison of completers vs. dropouts (chi-square) |
| `p-value adjudication.Rmd` | Holm/BH corrections for H3 moderation p-values (MAR + completer samples) |

`Study 2 MAR Results.Rmd` is CPU-bound (~10–25 min from scratch); the prebuilt
knitr cache (`Study-2-MAR-Results_cache/`) is deposited, so re-rendering takes seconds.

## Outputs (`results/MAR/`)

Frozen workbooks in per-hypothesis subfolders (`Baseline/`, `H1/`, `H2/`, `H3/`).

**`Study 2 MAR Results.Rmd`**

| Workbook | Contents |
|----------|----------|
| `H1/H1_Performance_Comparison_LMM.xlsx`, `_LMM_Task.xlsx` | H1 long-term accuracy (without / with Task): summary, ANOVA, partial η², simple-effect post-hoc |
| `H2/H2_Longterm_Confidence_Change.xlsx` | H2 long-term confidence: simple effects + post-hoc |
| `H2/H2_Attitude_Change_Longterm_PF.xlsx`, `_PPF.xlsx` | H2 attitude change Pre→Follow / Pre→Post→Follow |
| `H3/H3_Attitude_Change_Longterm_Moderation_PF.xlsx` / `_PPF.xlsx`, `H3/H3_Attitude_Longterm_Moderation_Summary_PF.xlsx` / `_PPF.xlsx` | H3 attitude moderation models + per-term F/p |
| `H3/H3_Performance_Confidence_Longterm_Moderation.xlsx` (+ `_Summary.xlsx`) | H3 performance/confidence moderation + summary |
| `H3/H3_Moderation_Padjust_PF.xlsx` / `_PPF.xlsx`, `H3/H3_Performance_Confidence_Moderation_Padjust.xlsx` | Holm/BH-adjusted moderation p-values |

**`Study 2 Drop Demographic Results.Rmd`** → `Baseline/Demographic_Results_Drop.xlsx`.
`Study 2 Drop Comparison.Rmd` prints to HTML only.

Packages (pinned in the top-level `renv.lock`): `broom`, `car`, `DescTools`,
`dplyr`, `tidyr`, `stringr`, `forcats`, `DT`, `effectsize`, `emmeans`, `ggplot2`,
`interactions`, `janitor`, `lme4`, `lmerTest`, `lsr`, `MASS`, `openxlsx`,
`readxl`, `ordinal`, `performance`, `report`.
