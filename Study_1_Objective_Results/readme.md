# Study 1 — Objective LLM Performance Analysis

This folder contains the data and R code for the objective performance analyses in Study 1, examining how LLM accuracy and response stability differ across models and thinking modes on statistics tasks.

---

## Data Description

All data files are located in the `data/` subdirectory.

### Input Files

| File | Description |
|------|-------------|
| `Study_1_Objective_Data.xlsx` | Item-level accuracy data for all LLMs |

### Key Variables

| Variable | Description |
|----------|-------------|
| `software` | LLM platform (`chatgpt` / `deepseek` / `tongyi` / `gemini` / `claude` / `Grok`) |
| `model` | Specific model version (e.g., `gpt-4o`, `DeepSeek-R1`) |
| `Thinking_Model` | Whether thinking/reasoning mode was enabled (`1` = Yes, `0` = No) |
| `question` | Statistics question identifier |
| `iteration` | Repeated-run index (for stability estimation) |
| `accuracy_rate` | Proportion correct across scored items (0–1); derived from `sum_score / 6` or `score1`–`score6` if not pre-computed |

---

## Code Description

### Analysis Files (R)

| File | Description |
|------|-------------|
| `Study 1 Objective Descriptive Results.Rmd` | Descriptive summary table (Table 1): ranks all models by mean accuracy; flags top and bottom models used in Study 2 |
| `Study 1 Objective Model Results.Rmd` | Mixed-effects models for accuracy and stability (SD): tests effect of thinking mode, question type, and platform on logit-transformed proportion correct and SD |

---

## Software Requirements

**R (version 4.0+):**
`readxl`, `dplyr`, `stringr`, `lme4`, `lmerTest`, `emmeans`, `effectsize`, `report`

---

## Output

Both scripts print results directly to the R output.
