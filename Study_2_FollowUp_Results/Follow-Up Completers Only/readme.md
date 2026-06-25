# Study 2 — Long-Term Robustness Check (Completers Only, *N* = 84)

Sensitivity check for the main long-term analysis. Restricts to follow-up
completers (*N* = 84) and re-runs the same H1/H2/H3 long-term models as the
full-sample MAR analysis in [`../MAR/`](../MAR/). Agreement between the two
indicates the conclusions are not driven by differential attrition.

## Data (`data/`)

`Study_2_Followup_Data.xlsx` — follow-up completer subsample (*N* = 84).
Variables follow Study 2 Main (see `../../Study_2_Main_Results/readme.md`).

> **Exclusion:** participants with `stage1_task0_accuracy >= 0.9` (ceiling filter).

## Notebooks

| File | Description |
|------|-------------|
| `Study 2 Follow-Up Only Results.Rmd` | Retention accuracy by condition; long-term confidence and attitude change; H3 moderation — same specifications as MAR, restricted to completers |
| `Study 2 Follow-Up Only Demographic Results.Rmd` | Demographic balance for the completer subsample (chi-square) |

## Outputs (`results/Follow-Up Activity/`)

Frozen workbooks in per-hypothesis subfolders (`Baseline/`, `H1/`, `H2/`, `H3/`).

**`Study 2 Follow-Up Only Results.Rmd`**

| Workbook | Contents |
|----------|----------|
| `H1/H1_Stage1_Longterm_Accuracy_Comparison_LMM.xlsx` | H1 long-term accuracy LMM: summary, ANOVA, η², simple-effect post-hoc |
| `H2/H2_Longterm_Confidence_Change.xlsx` | H2 long-term confidence: simple effects + post-hoc |
| `H2/H2_Attitude_Change_Longterm_PF.xlsx`, `_PPF.xlsx` | H2 attitude change Pre→Follow / Pre→Post→Follow |
| `H2/Continued_Use_Application.xlsx` | Continued-use / application outcomes |
| `H3/H3_Attitude_Change_Longterm_Moderation_PF.xlsx` / `_PPF.xlsx`, `H3/H3_Attitude_Longterm_Moderation_Summary_PF.xlsx` / `_PPF.xlsx` | H3 attitude moderation models + per-term F/p |
| `H3/H3_Performance_Confidence_Longterm_Moderation.xlsx` (+ `_Summary.xlsx`) | H3 performance/confidence moderation + summary |
| `H3/H3_Moderation_Padjust_PF.xlsx` / `_PPF.xlsx`, `H3/H3_Performance_Confidence_Moderation_Padjust.xlsx` | Holm/BH-adjusted moderation p-values (from the MAR folder's `p-value adjudication.Rmd`) |

**`Study 2 Follow-Up Only Demographic Results.Rmd`** → `Baseline/Demographic_Results_Followup_Only.xlsx`.

Packages (pinned in the top-level `renv.lock`): `broom`, `car`, `DescTools`,
`dplyr`, `tidyr`, `stringr`, `forcats`, `DT`, `effectsize`, `emmeans`, `ggplot2`,
`interactions`, `janitor`, `lme4`, `lmerTest`, `lsr`, `MASS`, `openxlsx`,
`readxl`, `ordinal`, `performance`, `report`.
