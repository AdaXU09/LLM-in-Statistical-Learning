library(rlang)
library(dplyr)

# Pivot wide phase columns to long form, within-subject normalise the values,
# and compute Cousineau-Morey corrected 95% CIs per phase. When `groupby_col`
# is supplied, summaries are computed within each group as well as per phase.
data_preprocessing <- function(data,
                               label_col,
                               new_columns_name,
                               data_columns,
                               one_names_values,
                               one_values_values,
                               after_columns_name,
                               phase_subtitle_name,
                               phase_short_name,
                               groupby_col = NULL
){
  data_fig <- data[, label_col, drop = FALSE]
  names(data_fig) <- new_columns_name

  data_fig <- data_fig %>%
    dplyr::mutate(ID = dplyr::row_number()) %>%
    dplyr::select(ID, dplyr::everything())

  data_long <- data_fig %>%
    tidyr::pivot_longer(
      cols      = dplyr::all_of(data_columns),
      names_to  = one_names_values,
      values_to = one_values_values
    ) %>%
    dplyr::mutate(
      !!one_names_values := factor(.data[[one_names_values]],
                                   levels = data_columns,
                                   labels = after_columns_name)
    ) %>%
    tidyr::drop_na()

  grand_mean <- mean(data_long[[one_values_values]], na.rm = TRUE)

  subj_means <- data_long %>%
    group_by(.data[["ID"]]) %>%
    dplyr::summarise(
      subj_mean = mean(.data[[one_values_values]], na.rm = TRUE),
      .groups = "drop"
    )

  data_long <- data_long %>%
    left_join(subj_means, by = "ID") %>%
    dplyr::mutate(
      value_norm = .data[[one_values_values]] - subj_mean + grand_mean
    )

  phase_vec <- data_long[[one_names_values]]
  k <- if (is.factor(phase_vec)) nlevels(phase_vec) else length(unique(phase_vec))
  if (k <= 1) stop("Cannot compute Cousineau–Morey error bar.")
  c_morey <- sqrt(k / (k - 1))

  if (is.null(groupby_col)) {
    stats_summary <- data_long %>%
      group_by(.data[[one_names_values]]) %>%
      dplyr::summarise(
        mean    = mean(.data[[one_values_values]], na.rm = TRUE),
        sd_norm = sd(value_norm, na.rm = TRUE),
        n       = dplyr::n(),
        .groups = "drop"
      )
  } else {
    stats_summary <- data_long %>%
      group_by(.data[[groupby_col]], .data[[one_names_values]]) %>%
      dplyr::summarise(
        mean    = mean(.data[[one_values_values]], na.rm = TRUE),
        sd_norm = sd(value_norm, na.rm = TRUE),
        n       = dplyr::n(),
        .groups = "drop"
      )
  }

  stats_summary <- stats_summary %>%
    dplyr::mutate(
      se_corrected = c_morey * sd_norm / sqrt(pmax(n, 1)),
      ci95         = qt(0.975, df = pmax(n - 1, 1)) * se_corrected
    )

  label_lookup <- tibble::tibble(
    Phase          = after_columns_name,
    Phase_short    = phase_short_name,
    Phase_subtitle = phase_subtitle_name
  )

  by_vec <- setNames("Phase", one_names_values)

  stats_summary <- stats_summary %>%
    left_join(label_lookup, by = by_vec) %>%
    dplyr::mutate(
      upper_ci   = mean + ci95,
      Phase_short= factor(Phase_short, levels = unique(label_lookup$Phase_short))
    )

  return(list(
    stats_summary = stats_summary,
    data_long     = data_long
  ))
}
