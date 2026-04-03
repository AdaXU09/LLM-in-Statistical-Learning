library(ggplot2)
library(rlang)
library(dplyr)

data_process_result <- function(data,
                                label_col,
                                new_columns_name,
                                data_columns,
                                one_names_values,
                                one_values_values,
                                after_columns_name,
                                phase_subtitle_name,
                                phase_short_name,
                                groupby_col
){
  data_fig <- data[, label_col]
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
    mutate(
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
  
  stats_summary <- data_long %>%
    group_by(.data[[groupby_col]], .data[[one_names_values]]) %>%
    dplyr::summarise(
      mean    = mean(.data[[one_values_values]], na.rm = TRUE),
      sd_norm = sd(value_norm, na.rm = TRUE),
      n       = dplyr::n(),
      .groups = "drop"
    ) %>%
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

data_process_result_new <- function(data,
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

make_accuracy_bar <- function(
    data,
    x, y,
    fill,
    ci,
    facet = NULL,
    colors = NULL,
    legend_title = "Phase",
    y_limits = c(0, 1.13),
    y_breaks = seq(0, 1, 0.2),
    y_as_percent = TRUE,
    label_digits = 0,
    label_offset = 0.02,
    show_subtitle = FALSE,
    subtitle_var = NULL,
    subtitle_facet_value = NULL,
    subtitle_offset = 0.10,
    x_angle = 45, x_hjust = 0.7, x_vjust = 1,
    show_legend = FALSE,
    y_columns_name = NA
){
  p <- ggplot(
    data,
    aes(x = .data[[x]], y = .data[[y]], fill = .data[[fill]])
  ) +
    geom_bar(
      stat = "identity", width = 0.8,
      color = "black", linewidth = 0.5, position = position_dodge(width = 0.8)
    ) +
    geom_errorbar(
      aes(ymin = .data[[y]] - .data[[ci]],
          ymax = .data[[y]] + .data[[ci]]),
      width = 0.2, linewidth = 0.8, color = "black",
      position = position_dodge(width = 0.8)
    )
  
  has_no_follow <- "no_follow_accuracy" %in% names(data)
  
  if (has_no_follow) {
    p <- p + geom_text(
      aes(
        label = ifelse(
          is.na(.data[["no_follow_accuracy"]]),
          if (isTRUE(y_as_percent)) {
            sprintf("%.0f%%", .data[[y]] * 100)
          } else {
            sprintf("%.2f", .data[[y]])
          },
          if (isTRUE(y_as_percent)) {
            sprintf("%.0f%% (%.0f%%*)", .data[[y]] * 100, .data[["no_follow_accuracy"]] * 100)
          } else {
            sprintf("%.2f (%.2f*)", .data[[y]], .data[["no_follow_accuracy"]])
          }
        ),
        y = .data[[y]] + .data[[ci]] + label_offset
      ),
      vjust = 0, size = 5, color = "black", fontface = "bold",
      position = position_dodge(width = 0.8)
    )
  } else {
    p <- p + geom_text(
      aes(
        label = if (isTRUE(y_as_percent)) {
          sprintf("%.0f%%", .data[[y]] * 100)
        } else {
          sprintf("%.2f", .data[[y]])
        },
        y = .data[[y]] + .data[[ci]] + label_offset
      ),
      vjust = 0, size = 5, color = "black", fontface = "bold",
      position = position_dodge(width = 0.8)
    )
  }
  
  if (isTRUE(show_subtitle) && !is.null(facet) &&
      !is.null(subtitle_var) && !is.null(subtitle_facet_value)) {
    data_sub <- dplyr::filter(data, .data[[facet]] == subtitle_facet_value)
    p <- p + geom_text(
      data = data_sub,
      aes(
        x = .data[[x]],
        y = .data[[y]] + .data[[ci]] + label_offset + subtitle_offset,
        label = .data[[subtitle_var]]
      ),
      vjust = 0, size = 4.5, color = "black", family = "sans",
      position = position_dodge(width = 0.8)
    )
  }
  
  if (!is.null(facet)) {
    p <- p + facet_wrap(stats::as.formula(paste("~", facet)),
                        nrow = 1, strip.position = "bottom")
  }
  
  if (!is.null(colors)) {
    p <- p + scale_fill_manual(values = colors, name = legend_title)
  }
  
  p <- p +
    scale_y_continuous(
      breaks = y_breaks,
      labels = if (isTRUE(y_as_percent)) function(x) paste0(round(x*100), "%") else waiver(),
      expand = c(0, 0)
    )
  
  if (!is.null(y_limits)) {
    p <- p + coord_cartesian(ylim = y_limits)
  }
  
  p <- p +
    theme_classic(base_size = 12) +
    theme(
      text = element_text(family = "sans"),
      strip.text = element_text(size = 18, margin = margin(t = 0, b = 10)),
      strip.placement = "outside",
      strip.background = element_blank(),
      axis.ticks.length = unit(5, "pt"),
      axis.ticks = element_line(color = "black", size = 0.25),
      axis.line = element_line(color = 'black', size = 0.25),
      axis.text = element_text(size = 18, color = "black"),
      axis.title = element_text(size = 18, color = 'black'),
      plot.title = element_text(hjust = 0.5, size = 18, face = 'bold'),
      legend.position = if (isTRUE(show_legend)) "top" else "none",
      panel.spacing.x = unit(0.8, "lines"),
      axis.text.x = element_text(
        angle = x_angle, hjust = x_hjust, vjust = x_vjust,
        margin = margin(t = 12, b = -10)
      ),
      axis.line.x = element_line(color = NA),
      axis.title.x = element_blank(),
      axis.ticks.x = element_blank(),
      axis.title.y = element_text(size = 18, color = "black")
    ) +
    labs(title = "", x = NULL, y = y_columns_name)
  
  return(p)
}

make_accuracy_boxplot <- function(
    data,
    x    = "Label",
    y    = "Accuracy",
    fill = "Phase",
    color_group = "Phase",
    fill_colors  = NULL,
    point_colors = NULL,
    legend_title = "",
    dodge_width  = 0.8,
    box_alpha    = 0.9,
    box_size     = 0.5,
    point_size   = 2,
    point_alpha  = 0.2,
    show_mean_point = TRUE,
    mean_point_color = "red",
    mean_point_size  = 2,
    y_limits  = c(0, 1),
    y_breaks  = seq(0, 1, 0.2),
    y_as_percent = TRUE,
    base_size = 20,
    axis_text_size  = 20,
    axis_title_size = 20,
    legend_text_size = 20,
    legend_title_size = 20,
    legend_position = "top",
    legend_nrow = 2,
    y_columns_name=NA
){
  p <- ggplot(data, aes(x = .data[[x]], y = .data[[y]])) +
    geom_boxplot(
      aes(fill = .data[[fill]]),
      outlier.shape = NA,
      alpha = box_alpha,
      color = "black",
      size  = box_size,
      position = position_dodge(width = dodge_width)
    ) +
    geom_jitter(
      aes(color = .data[[color_group]]),
      position = position_jitterdodge(
        jitter.width = 0.25,
        jitter.height = 0.01,
        dodge.width = dodge_width
      ),
      alpha = point_alpha,
      size  = point_size,
      stroke = 0.5,
      show.legend = FALSE
    )
  
  if (isTRUE(show_mean_point)) {
    p <- p + stat_summary(
      aes(group = .data[[fill]]),
      fun = mean,
      geom = "point",
      shape = 19,
      size  = mean_point_size,
      color = mean_point_color,
      position = position_dodge(width = dodge_width),
      show.legend = FALSE
    )
  }
  
  if (!is.null(fill_colors)) {
    p <- p + scale_fill_manual(values = fill_colors, name = legend_title)
  }
  if (!is.null(point_colors)) {
    p <- p + scale_color_manual(values = point_colors)
  }
  
  p <- p +
    scale_y_continuous(
      breaks = y_breaks,
      labels = if (y_as_percent) function(x) paste0(round(x * 100), "%") else waiver(),
      expand = c(0, 0)
    ) +
    coord_cartesian(ylim = y_limits)
  
  p <- p +
    theme_classic(base_size = base_size) +
    theme(
      legend.position   = legend_position,
      legend.title      = element_text(size = legend_title_size),
      legend.text       = element_text(size = legend_text_size),
      plot.title        = element_text(hjust = 0.5, size = 20, face = "bold"),
      axis.title.y      = element_text(size = axis_title_size, color = "black"),
      axis.title.x      = element_text(size = axis_title_size, color = "black"),
      axis.text.x       = element_text(size = axis_text_size, color = "black"),
      axis.text.y       = element_text(size = axis_text_size, color = "black"),
      panel.border      = element_blank(),
      axis.line.x       = element_line(color = "black", size = 0.5),
      axis.line.y       = element_line(color = "black", size = 0.5)
    ) +
    guides(
      fill = guide_legend(
        nrow = legend_nrow,
        override.aes = list(alpha = 1, colour = "black")
      )
    ) +
    labs(title = "", x = "", y = y_columns_name)
  
  return(p)
}

make_accuracy_violin <- function(
    data,
    x    = "Label",
    y    = "Accuracy",
    fill = "Phase",
    color_group = "Phase",
    fill_colors  = NULL,
    point_colors = NULL,
    legend_title = "",
    violin_alpha   = 0.4,
    violin_linewidth = 0,
    violin_border_color = NA,
    violin_scale   = "area",
    dodge_width    = 0.9,
    point_size     = 1.8,
    point_alpha    = 0.1,
    show_mean_point = TRUE,
    mean_point_color = "red",
    mean_point_size  = 2,
    y_limits  = c(0, 1),
    y_breaks  = seq(0, 1, 0.2),
    y_as_percent = TRUE,
    base_size = 12,
    axis_text_size  = 16,
    axis_title_size = 18,
    legend_text_size = 18,
    legend_title_size = 18,
    legend_position = "top",
    legend_nrow = 2,
    y_columns_name=NA
){
  p <- ggplot(data, aes(x = .data[[x]], y = .data[[y]], fill = .data[[fill]])) +
    geom_violin(
      trim = FALSE,
      alpha = violin_alpha,
      linewidth = violin_linewidth,
      color = violin_border_color,
      scale = violin_scale
    ) +
    geom_jitter(
      aes(color = .data[[color_group]], fill = .data[[fill]]),
      position = position_dodge(width = dodge_width),
      size = point_size, alpha = point_alpha, stroke = 0, show.legend = FALSE
    )
  
  if (isTRUE(show_mean_point)) {
    p <- p + stat_summary(
      aes(group = .data[[fill]]),
      fun = mean, geom = "point", shape = 18,
      size = mean_point_size, color = mean_point_color,
      stroke = 1.5, position = position_dodge(width = dodge_width),
      show.legend = FALSE
    )
  }
  
  if (!is.null(point_colors)) {
    p <- p + scale_color_manual(values = point_colors, guide = "none")
  }
  if (!is.null(fill_colors)) {
    p <- p + scale_fill_manual(values = fill_colors, name = legend_title,
                               guide = guide_legend(nrow = legend_nrow, byrow = TRUE))
  }
  
  p <- p +
    scale_y_continuous(
      breaks = y_breaks,
      labels = if (y_as_percent) function(x) paste0(round(x * 100), "%") else waiver(),
      expand = c(0, 0)
    ) +
    coord_cartesian(ylim = y_limits)
  
  p <- p +
    theme_classic(base_size = base_size) +
    theme(
      legend.position = legend_position,
      legend.title    = element_text(size = legend_title_size),
      legend.text     = element_text(size = legend_text_size),
      plot.title      = element_text(hjust = 0.5, size = 18, face = "bold"),
      axis.title.x    = element_text(size = axis_title_size, color = "black"),
      axis.title.y    = element_text(size = axis_title_size, color = "black"),
      axis.text.x     = element_text(size = axis_text_size, color = "black"),
      axis.text.y     = element_text(size = axis_text_size, color = "black"),
      panel.border    = element_blank(),
      axis.line.x     = element_line(color = "black", size = 0.5),
      axis.line.y     = element_line(color = "black", size = 0.5)
    ) +
    labs(title = "", x = "Label", y = y_columns_name)
  
  p
}

save_my_plot <- function(plot, path, filename_base,
                         width = 10, height = 6, units = "in",
                         dpi_png = 400, dpi_pdf = 300) {
  if (!grepl("/$", path)) {
    path <- paste0(path, "/")
  }
  
  ggsave(paste0(path, filename_base, ".png"),
         plot = plot,
         width = width, height = height, units = units, dpi = dpi_png)
}
