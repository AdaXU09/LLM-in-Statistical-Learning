# Study 1 — Objective LLM Performance

Objective accuracy and response stability of 15 LLMs across models and thinking
modes on the three statistical-reasoning tasks.

## Data (`data/`)

`Study_1_Objective_Data.xlsx` — item-level accuracy for all LLMs.

| Variable | Description |
|----------|-------------|
| `software` | Platform (`chatgpt` / `deepseek` / `tongyi` / `gemini` / `claude` / `Grok`) |
| `model` | Model version (e.g., `gpt-4o`, `DeepSeek-R1`) |
| `Thinking_Model` | Thinking/reasoning mode enabled (`1` = yes, `0` = no) |
| `question` | Question identifier |
| `iteration` | Repeated-run index (for stability) |
| `accuracy_rate` | Proportion correct (0–1); from `sum_score / 6`, or `score1`–`score6` if not pre-computed |

## Notebooks

| File | Description |
|------|-------------|
| `Study 1 Objective Descriptive Results.Rmd` | Table 1: models ranked by mean accuracy; flags top/bottom models carried into Study 2 |
| `Study 1 Objective Model Results.Rmd` | Mixed-effects models for accuracy and stability (SD) testing thinking mode, question type, and platform |

Results print to the rendered HTML; no workbooks are written.

Packages (versions pinned in the top-level `renv.lock`): `readxl`, `dplyr`,
`stringr`, `lme4`, `lmerTest`, `emmeans`, `effectsize`, `report`.
