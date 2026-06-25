# Study 2 — Main (Initial-Session) Results

Initial-session analyses of the three-stage learning experiment (*N* = 175):
mixed-effects models for performance and in-task perceptions, pre→post attitude
change, moderation analyses, and demographic balance checks.

## Data (`data/`)

`Study_2_Main_Results_Data.xlsx` — participant-level data for the main sample.

**Condition:** `Label` (`AI` / `AI Human` / `Human`).

**Pre-study measures:** `Pre_GLAT_Objective_AI_Literacy`,
`Pre_AILS_CCS_Subjective_AI_Literacy`, `Pre_AI_Trust`, `Pre_AI_Usefulness`,
`Pre_AI_Affect`, `Pre_AI_Self_Efficacy`, `Pre_Behavioral_Intention`.

**Task performance** (per stage × task):

| Variable | Description |
|----------|-------------|
| `stage[1-3]_task[0-3]_accuracy` | Proportion correct (0–1) |
| `stage[1-3]_task[0-3]_confidence` | Confidence rating |
| `stage[2-3]_task[0-3]_willing` | Willingness to accept guidance/answers |
| `stage[2-3]_task[0-3]_useful` | Perceived usefulness of guidance/answers |

**Post-study:** `Post_AI_Trust`, `Post_AI_Usefulness`, `Post_AI_Affect`, `Post_Behavioral_Intention`.

**Manipulation check:** `Recalled_Label` — source the participant recalled
receiving (`AI` / `AI + Human` / `Human`), stored just before `Sign_Up`.

**Moderators:** `Gender`, `Age`, `Identity`, `Field`, `Stats_Background`, `Used_LLM_Frequency`, `Used_LLM_Hours`.

> **Exclusion:** participants with `stage1_task0_accuracy >= 0.9` (ceiling filter).

## Notebooks

| File | Description |
|------|-------------|
| `Study 2 Main Results.Rmd` | Primary analysis: mixed-effects models for accuracy, confidence, willing, and useful across stages; pre→post attitude change; moderation by stats background, LLM experience, and demographics |
| `Study 2 Main Demographic Results.Rmd` | Demographic balance: distribution tables and chi-square tests across conditions |
| `additional/p-value adjudication.Rmd` | Holm and BH corrections for moderation p-values, grouped by outcome (uses only `dplyr` / `readxl` / `openxlsx`) |

## Outputs (`results/`)

Beyond the rendered HTML, the notebooks write frozen workbooks into per-hypothesis
subfolders (`Baseline/`, `H1/`, `H2/`, `H3/`) so every manuscript/SI table can be
re-checked from a deposited file.

**`Study 2 Main Results.Rmd`**

| Workbook | Contents |
|----------|----------|
| `Baseline/Baseline_Charateristics_By_Label.xlsx` | Baseline summaries + ANOVA by condition |
| `H1/H1_Performance_Comparison_LMM.xlsx` | H1 accuracy LMM (no Task): summary, ANOVA, partial η², simple-effect post-hoc contrasts |
| `H1/H1_Performance_Comparison_LMM_Task.xlsx` | H1 accuracy LMM with Task (adds Phase×Task×Label contrasts) |
| `H1/H1_Performance_ItemLevel_Binomial_GLMM.xlsx` | H1 robustness: item-level binomial GLMM (`correct ~ Stage*Label + (1\|ID)+(1\|Item)+(1\|Task)`) |
| `H2/H2_Within_Task_Attitude_Perceptions.xlsx` | H2 within-task confidence / willing / useful |
| `H2/H2_Attitude_Change_Immediate_Results.xlsx` | H2 pre→post attitude change (change scores, ANOVA, η², post-hoc) |
| `H2/Post_Survey_Experience.xlsx` | Post-survey perceived learning, satisfaction, sign-up |
| `H3/H3_Attitude_Change_Moderation_Summary.xlsx` (+ `_Padjust`) | H3 attitude-change moderation: F/p per term (+ Holm/BH) |
| `H3/H3_Within_Task_Moderation_Summary.xlsx` (+ `_Padjust`) | H3 within-task moderation: F/p per term (+ adjusted) |
| `H3/H3_Attitude_Change_Immediate_Moderation_POSTHOC.xlsx` | H3 attitude-change per-term post-hoc |
| `H3/H3_Within_Task_Moderation_ALL_Posthoc.xlsx` | H3 within-task per-term post-hoc |
| `H3/Post_Survey_Moderation_Results.xlsx`, `_2.xlsx` | Post-survey moderation |

`_Padjust.xlsx` files come from `additional/p-value adjudication.Rmd`; all others from `Study 2 Main Results.Rmd`.

**`Study 2 Main Demographic Results.Rmd`** → `Baseline/Demographic_Results.xlsx` (per-condition distributions + chi-square tests).

Packages (pinned in the top-level `renv.lock`): `broom`, `broom.mixed`, `car`,
`DescTools`, `dplyr`, `tidyr`, `stringr`, `forcats`, `tibble`, `DT`,
`effectsize`, `emmeans`, `ggplot2`, `interactions`, `janitor`, `lme4`,
`lmerTest`, `lsr`, `MASS`, `openxlsx`, `readxl`, `ordinal`, `performance`, `report`.
