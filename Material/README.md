# Material — Survey Instrument & Rating Stimuli

Study materials: the full survey instrument and the Study 1 subjective-rating
stimulus set (the LLM-generated guidances that human raters evaluated).

| File | Description |
|------|-------------|
| `Full_Survey_English_Version.docx` | Complete English survey, in the order participants saw it: **Pre-survey** (eligibility, background/AI-experience, 20-item generative-AI quiz), **Main survey** (three-stage learning task under the assigned guidance condition), **Post-survey** (experience/attitudes), **Follow-up** (~1-month retention). Structure below. |
| `Study_1_Subjective_Evaluation.docx` | Study 1 rater materials exactly as administered: the four-dimension rubric (1–7) followed by all 36 rated guidances, **blind to model identity** and in **deidentified randomised order** under neutral codes (`Q1_1`, …). The code→model/iteration map below makes the blinding and randomisation auditable. |

## Response code → model / iteration map

In `Study_1_Subjective_Evaluation.docx` each response is coded **`Q{task}_{number}`**:
`Q1` = p-value, `Q2` = confidence interval, `Q3` = comparing p-values across two
studies; `{number}` (1–12) indexes the 4 models × 3 iterations per task, in
randomised order.

| | Q1 (p-value) | Q2 (confidence interval) | Q3 (two-study comparison) |
|---|---|---|---|
| `_1` | ChatGPT_4o / 1 | ChatGPT_4o / 1 | Grok3 / 1 |
| `_2` | Grok3 / 1 | ChatGPT_o1 / 1 | ChatGPT_4o / 2 |
| `_3` | Gemini_2.0 / 1 | Grok3 / 1 | ChatGPT_o1 / 2 |
| `_4` | Grok3 / 2 | Gemini_2.0 / 2 | ChatGPT_o1 / 3 |
| `_5` | ChatGPT_o1 / 1 | ChatGPT_o1 / 2 | Gemini_2.0 / 2 |
| `_6` | ChatGPT_4o / 2 | Grok3 / 2 | Gemini_2.0 / 3 |
| `_7` | Grok3 / 3 | ChatGPT_4o / 2 | ChatGPT_4o / 3 |
| `_8` | Gemini_2.0 / 2 | Gemini_2.0 / 1 | Grok3 / 2 |
| `_9` | ChatGPT_o1 / 2 | ChatGPT_o1 / 3 | Grok3 / 3 |
| `_10` | ChatGPT_4o / 3 | Gemini_2.0 / 3 | ChatGPT_4o / 1 |
| `_11` | ChatGPT_o1 / 3 | ChatGPT_4o / 3 | ChatGPT_o1 / 1 |
| `_12` | Gemini_2.0 / 3 | Grok3 / 3 | Gemini_2.0 / 1 |

Models rated: `ChatGPT_4o`, `ChatGPT_o1`, `Grok3`, `Gemini_2.0` — 3 iterations
each per task = 12 responses per task, 36 in total.

## Scoring rubric

Each response scored on four dimensions (1–7; full anchors in the .docx), mapping
to the columns in `Study_1_Subjective_Data.xlsx`:

| Dimension (column) | What it captures |
|--------------------|------------------|
| `Statistical_Accuracy` | Statistical correctness and precision |
| `Clarity_and_Structure` | Organisation, logical flow, readability |
| `Conceptual_Depth` | Richness and nuance of the explanation |
| `Pedagogical_Effectiveness` | Engagement, teaching strategies, memorability |

## Full survey — section structure

1. **Pre-survey.** Eligibility (statistics background; follow-up e-mail consent);
   welcome/overview (~60–80 min); Part 1 background assessment (demographics,
   self-rated statistics background, LLM-experience items); 20-item generative-AI
   knowledge quiz.
2. **Main survey (Part 2).** Random assignment to AI-only, Human-only, or
   AI + Human guidance, then a three-stage process per topic (p-value, confidence
   interval, two-study comparison): Stage 1 independent responses → Stage 2
   guidance → Stage 3 answers + final response.
3. **Post-survey (Part 3).** Condition-recall manipulation check; attitudes
   battery (1–5: trust, usefulness, attitude, behavioural intention); task
   evaluation (difficulty, perceived improvement, satisfaction); optional
   resource opt-in.
4. **Follow-up (~1 month).** Repeated true/false items on the three topics with
   per-statement confidence (1–5); re-assessment of AI attitudes and experience.
