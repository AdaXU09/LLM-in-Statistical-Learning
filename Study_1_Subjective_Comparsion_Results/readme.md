# Study 1 — Subjective Rating Descriptive Comparison

This folder contains the data and R code for the descriptive comparison of human subjective quality ratings of LLM-generated statistics explanations in Study 1, broken down by model, rater profession, and task.

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
| `Model` | LLM model rated (e.g., `ChatGPT_4o`, `Grok3`, `Gemini_2.0`, `ChatGPT_o1`) |
| `Task` | Statistics task being rated |
| `Profession` | Rater role (`Student` / `Instructor`) |
| `Iteration` | Repeated rating index |
| `Statistical_Accuracy` | Rating on statistical correctness (numeric) |
| `Clarity_and_Structure` | Rating on clarity and organization (numeric) |
| `Conceptual_Depth` | Rating on depth of explanation (numeric) |
| `Pedagogical_Effectiveness` | Rating on teaching effectiveness (numeric) |

---

## Code Description

### Analysis Files (R)

| File | Description |
|------|-------------|
| `Study 1 Subjective Decriptive Results.Rmd` | Descriptive summaries: long-format pivot across four rating dimensions; Top vs. Bottom overall mean/SD comparison; per-model, per-task mean and SD for students and instructors separately; full breakdown by Dimension × Model × Task × Profession |

---

## Software Requirements

**R (version 4.0+):**
`readxl`, `dplyr`, `tidyr`, `stringr`

---

## Output

Results are printed directly to R output.
