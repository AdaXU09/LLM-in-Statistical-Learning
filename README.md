# Source attribution changes learning from LLM-generated statistics instruction

Data and analysis code for the two-study paper. Study 1 benchmarked 15 LLMs on
17 true/false items targeting three persistent statistical misconceptions
(*P*-values, 95% confidence intervals, cross-study comparison) and used blinded
instructor and student ratings to select instructionally strong explanations.
Study 2 (*N* = 175) embedded those fixed explanations in a randomized experiment
that held content constant while varying only the source label (AI, AI + Human,
or Human) across a three-stage learning sequence, with a 1-month follow-up.

Preregistration: Study 1 [osf.io/5jwtk](https://osf.io/5jwtk/overview),
Study 2 [osf.io/daphw](https://osf.io/daphw/overview).

## Repository layout

Each folder is self-contained and carries its own `readme.md` listing its
notebooks, data, and rendered outputs. Notebooks read from a `data/`
subdirectory relative to their own folder and must be rendered with that folder
as the working directory.

| Folder | Contents |
|--------|----------|
| `Study_1_Objective_Results/` | Study 1 LLM benchmark: objective accuracy and stability |
| `Study_1_Subjective_Results/` | Study 1 instructional-quality ratings (descriptives + mixed-effects models) |
| `Study_2_Main_Results/` | Study 2 initial-session analyses and demographics |
| `Study_2_FollowUp_Results/` | 1-month retention: `MAR/` (full sample *N* = 175, main) and `Follow-Up Completers Only/` (*N* = 84, robustness) |
| `Study_2_Early_Late_Correction/` | Exploratory early- vs. late-correction analysis |
| `Figures/` | Figure-generation notebooks; outputs in `Figures/figure/` |
| `Material/` | Study materials (items, prompts, rubrics) |

Within each analysis folder, outputs are organized by hypothesis under
`results/` (`Baseline/`, `H1/`, `H2/`, `H3/`); multiple-comparison-corrected
moderation results are the `*_Padjust.xlsx` workbooks in `H3/`.

## Reproducing the analyses

**Environment.** R 4.5.1; all package versions are pinned in `renv.lock`
(machine-specific `renv/library/` is not deposited). From a clean clone, the
`.Rprofile` bootstraps [`renv`](https://rstudio.github.io/renv/); then run:

```r
renv::restore()
```

Rendering `.Rmd` → HTML requires Pandoc (bundled with RStudio; otherwise ensure
`pandoc` is on `PATH`). One non-obvious dependency, **`see`**, is loaded on
demand by the easystats `report()`/`performance()` plotting methods; it is
pinned in `renv.lock` and recorded in `dependencies.R`.

**Render a notebook** with its own folder as the working directory:

```r
setwd("Study_2_Main_Results")
rmarkdown::render("Study 2 Main Results.Rmd")
```

## Claim-to-output map

Each manuscript Table, Figure, and Results claim is reproduced by the notebook /
deposited output below. Paths are relative to the repository root; folder
abbreviations: **S1-Obj** `Study_1_Objective_Results/`, **S1-Subj**
`Study_1_Subjective_Results/`, **S2-Main** `Study_2_Main_Results/`, **MAR**
`Study_2_FollowUp_Results/MAR/`, **Compl** `Study_2_FollowUp_Results/Follow-Up Completers Only/`,
**EL** `Study_2_Early_Late_Correction/`, **Fig** `Figures/`. Notebooks that print
to their rendered HTML (rather than writing a workbook) are marked *(HTML)*.

### Tables and figures

| Manuscript item | Output |
|-----------------|--------|
| Table 1 — objective accuracy and stability | S1-Obj `Study 1 Objective Descriptive Results.Rmd` *(HTML)* |
| Table 2 — quality ratings by model × rater | S1-Subj `Study 1 Subjective Decriptive Results.Rmd` *(HTML)* |
| Fig. 1 — Study 1 selection flowchart | non-analytic diagram (no deposited source asset) |
| Fig. 2 — Study 2 participant flow | non-analytic diagram (no deposited source asset) |
| Fig. 3 — LLM performance | Fig `Figure_Study1_1.Rmd` → `figure/Figure_Study1_1.{pdf,png,svg}` |
| Fig. 4 — guidance quality | Fig `Figure_Study1_2.Rmd` → `figure/Figure_Study1_2.*` |
| Fig. 5 — accuracy trajectories; early vs. late | Fig `Figure_Study2_1.Rmd` → `figure/Figure_Study2_1.*` (panel c from `data/Correction_Data.csv`) |
| Fig. 6 — confidence; perceived value | Fig `Figure_Study2_2.Rmd` → `figure/Figure_Study2_2.*` |
| Fig. 7 — AI attitudes, literacy, self-efficacy | Fig `Figure_Study2_3.Rmd` → `figure/Figure_Study2_3.*` |

### Results claims

| Claim | Output |
|-------|--------|
| Study 1 benchmark: top/bottom models; thinking-mode null; task effects | S1-Obj `Study 1 Objective Model Results.Rmd` *(HTML)*; paired Claude/Grok sensitivity → SI Text S3 |
| Study 1 quality: top > bottom (Δ = 0.24), instructor-driven, Model × Rater | S1-Subj `Study 1 Subjective Model Results.Rmd` *(HTML)* |
| H1 accuracy, Stage × Label (initial session, *N* = 175) | S2-Main `results/H1/H1_Performance_Comparison_LMM.xlsx` (+ `_Task.xlsx`) |
| H1 item-level binomial robustness | S2-Main `results/H1/H1_Performance_ItemLevel_Binomial_GLMM.xlsx` |
| Manipulation recall; passers-only / perceived-label sensitivity (Text S4) | `results/H1/*_PassersOnly_LMM.xlsx`, `*_PerceivedLabel*.xlsx` (S2-Main, MAR, Compl); recall data `EL/data/manipulation_recall.xlsx` |
| Retention, Stage × Label and follow-up vs. baseline (full sample, MAR) | MAR `results/MAR/H1/H1_Performance_Comparison_LMM.xlsx` (+ `_Task.xlsx`) |
| Retention robustness (completers, *N* = 84) | Compl `results/Follow-Up Activity/H1/H1_Stage1_Longterm_Accuracy_Comparison_LMM.xlsx` |
| Exploratory early- vs. late-correction (OR in AI + Human); Stage-1-wrongness sensitivity | EL `Comparison.Rmd` *(HTML)* |
| Confidence across stages × label (immediate) | S2-Main `results/H2/H2_Within_Task_Attitude_Perceptions.xlsx` |
| Confidence at follow-up (long-term) | MAR `results/MAR/H2/H2_Longterm_Confidence_Change.xlsx` |
| Willingness and perceived usefulness (S2 → S3) | S2-Main `results/H2/H2_Within_Task_Attitude_Perceptions.xlsx` |
| AI attitudes pre → post (trust, affect, intention) | S2-Main `results/H2/H2_Attitude_Change_Immediate_Results.xlsx` |
| AI attitudes / literacy / self-efficacy to follow-up | MAR `results/MAR/H2/H2_Attitude_Change_Longterm_PF.xlsx`, `_PPF.xlsx` |
| Label did not moderate any outcome (H3; Holm/BH-adjusted) | `results/.../H3/*Moderation*` (+ `*_Padjust*`) in S2-Main, MAR, Compl |
| Group balance: demographics and baseline AI measures (Tables S6, S7) | S2-Main `results/Baseline/Demographic_Results.xlsx`, `Baseline_Charateristics_By_Label.xlsx` |
| Attrition diagnostics (completers vs. dropouts) | MAR `Study 2 Drop Comparison.Rmd` *(HTML)*; `results/MAR/Baseline/Demographic_Results_Drop.xlsx` |

SI ANOVA and post-hoc tables (S8–S12) are produced by the same H1/H2 workbooks
above; the completers-only robustness tables (S13–S15) come from the **Compl**
`results/` folder. Each folder's `readme.md` lists its full workbook inventory.

## Notes

- **Long-running notebooks.** `Study_2_Main_Results/Study 2 Main Results.Rmd`
  and `Study_2_FollowUp_Results/MAR/Study 2 MAR Results.Rmd` are CPU-bound
  (~10–25 min from scratch). knitr chunk caches are deposited (`*_cache/`), so
  re-rendering completes in seconds unless the code or R/package versions change.

- **Duplicated inputs.** To keep notebooks self-contained, three Study 1
  workbooks are byte-identical snapshots in a second folder. Canonical copies:
  `Study_1_Objective_Data.xlsx` and `Study_1_Subjective_Data.xlsx` in their
  `Study_1_*_Results/data/` folders (snapshot in `Figures/data/`);
  `correction_raw_data.xlsx` in `Study_2_Early_Late_Correction/data/`
  (snapshot in `Study_2_Main_Results/data/`). If a canonical file changes,
  re-copy it over the snapshot.

- **Figures** render at 600 dpi in Arial via `showtext`, falling back to the
  default sans family if Arial is absent. Outputs are reproducible up to being
  visually identical; byte-for-byte divergence of PDF/PNG/SVG across machines is
  expected.

- **Auxiliary scripts.** The `p-value adjudication.Rmd` notebooks
  (`Study_2_Main_Results/additional/`, `Study_2_FollowUp_Results/MAR/`) apply
  Holm (FWER) and BH (FDR) corrections to the H3 moderation terms and write the
  `*_Padjust.xlsx` workbooks. They run standalone and are not part of the main
  render pipeline.

## Citation
If you use our data or results in your work, please cite our study.