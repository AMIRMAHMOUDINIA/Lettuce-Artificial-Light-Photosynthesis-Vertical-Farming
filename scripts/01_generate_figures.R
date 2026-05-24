# LED Spectrum Effects on Lettuce Photosynthesis and Chlorophyll Fluorescence
# Reproducible R script for regenerating the figures.
# Run from the repository root:
# source("scripts/01_generate_figures.R")

rm(list = ls())
packages <- c("ggplot2", "dplyr")
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) install.packages(pkg)
  library(pkg, character.only = TRUE)
}

data_file <- file.path("data", "utphotolab_lettuce_LED.csv")
if (!file.exists(data_file)) stop("CSV not found in data/ folder.")

df <- read.csv(data_file)
dir.create("figures", showWarnings = FALSE)

df <- df %>% mutate(
  treatment_label = factor(
    treatment,
    levels = c("R", "RB12", "RB8", "RB4", "RB1", "B"),
    labels = c("R
0% B", "R/B=12
8% B", "R/B=8
11% B", "R/B=4
20% B", "R/B=1
50% B", "B
100% B")
  )
)

caption_text <- "Data: UTPhotoLab — Photosynthesis Laboratory, University of Tehran | Supplemental LED spectrum trials"
base_theme <- theme_classic(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(colour = "grey35", size = 10),
    plot.caption = element_text(colour = "grey50", size = 7.5, hjust = 0),
    axis.text.x = element_text(size = 9.5, lineheight = 0.9, margin = margin(t = 8)),
    axis.text.y = element_text(size = 10),
    axis.title = element_text(size = 12),
    legend.position = "bottom",
    plot.margin = margin(12, 20, 14, 14)
  )

# 1. Net photosynthesis
p1 <- ggplot(df, aes(x = treatment_label, y = Pn, fill = blue_pct)) +
  geom_col(colour = "white", width = 0.58) +
  geom_errorbar(aes(ymin = Pn - Pn_se, ymax = Pn + Pn_se), width = 0.14, colour = "grey25", linewidth = 0.55) +
  scale_fill_gradient(low = "#003b82", high = "#f0db2f", name = "Blue light fraction (%)") +
  labs(title = expression("Net Photosynthetic Rate (P"[n]*") Across Red:Blue LED Treatments"), subtitle = "Lettuce controlled-environment trial", x = "LED treatment", y = expression("P"[n]*" (µmol CO"[2]*" m"^-2*" s"^-1*")"), caption = caption_text) +
  base_theme

ggsave(file.path("figures", "01_LED_Pn_by_treatment_clean.png"), p1, width = 10.5, height = 6.2, dpi = 320)

# 2. Fv/Fm
fvfm_lower <- min(df$Fv_Fm - df$FvFm_se, na.rm = TRUE) - 0.008
fvfm_upper <- max(df$Fv_Fm + df$FvFm_se, na.rm = TRUE) + 0.008
p2 <- ggplot(df, aes(x = treatment_label, y = Fv_Fm, colour = blue_pct)) +
  geom_hline(yintercept = 0.83, linetype = "dashed", colour = "#2d6a4f", linewidth = 0.8) +
  annotate("text", x = 3.5, y = 0.834, label = "Common healthy reference: Fv/Fm ≈ 0.83", colour = "#2d6a4f", size = 3.2, hjust = 0.5) +
  geom_errorbar(aes(ymin = Fv_Fm - FvFm_se, ymax = Fv_Fm + FvFm_se), width = 0.12, colour = "grey25", linewidth = 0.55) +
  geom_point(size = 3.8) +
  scale_colour_gradient(low = "#003b82", high = "#f0db2f", name = "Blue light fraction (%)") +
  coord_cartesian(ylim = c(fvfm_lower, fvfm_upper)) +
  labs(title = "Maximum Quantum Yield of PSII (Fv/Fm) Across LED Treatments", subtitle = "Zoomed y-axis used because Fv/Fm differences are physiologically small", x = "LED treatment", y = "Fv/Fm", caption = caption_text) +
  base_theme

ggsave(file.path("figures", "02_LED_FvFm_by_treatment_clean.png"), p2, width = 10.5, height = 6.2, dpi = 320)

# 3. PhiII
phiii_lower <- min(df$PhiII - df$PhiII_se, na.rm = TRUE) - 0.02
phiii_upper <- max(df$PhiII + df$PhiII_se, na.rm = TRUE) + 0.02
p3 <- ggplot(df, aes(x = treatment_label, y = PhiII, colour = blue_pct)) +
  geom_line(aes(group = 1), colour = "grey45", linewidth = 0.75, alpha = 0.65) +
  geom_errorbar(aes(ymin = PhiII - PhiII_se, ymax = PhiII + PhiII_se), width = 0.12, colour = "grey25", linewidth = 0.55) +
  geom_point(size = 3.8) +
  scale_colour_gradient(low = "#003b82", high = "#f0db2f", name = "Blue light fraction (%)") +
  coord_cartesian(ylim = c(phiii_lower, phiii_upper)) +
  labs(title = expression("Operating Efficiency of PSII ("*Phi[II]*") Across LED Treatments"), subtitle = "Fluorescence-derived indicator of realized photosynthetic performance", x = "LED treatment", y = expression(Phi[II]), caption = caption_text) +
  base_theme

ggsave(file.path("figures", "03_LED_PhiII_by_treatment_clean.png"), p3, width = 10.5, height = 6.2, dpi = 320)

# 4. Normalized Pn vs dry weight
df_norm <- df %>% mutate(Pn_relative = 100 * Pn / max(Pn, na.rm = TRUE), dry_weight_relative = 100 * dry_weight_g / max(dry_weight_g, na.rm = TRUE))
p4 <- ggplot(df_norm, aes(x = treatment_label, group = 1)) +
  geom_line(aes(y = Pn_relative, colour = "Net photosynthesis (Pn)"), linewidth = 1.15) +
  geom_point(aes(y = Pn_relative, colour = "Net photosynthesis (Pn)"), size = 3.4) +
  geom_line(aes(y = dry_weight_relative, colour = "Shoot dry weight"), linewidth = 1.15, linetype = "dashed") +
  geom_point(aes(y = dry_weight_relative, colour = "Shoot dry weight"), size = 3.4, shape = 17) +
  scale_colour_manual(values = c("Net photosynthesis (Pn)" = "#2d6a4f", "Shoot dry weight" = "#e63946")) +
  scale_y_continuous(limits = c(45, 108), breaks = seq(50, 100, by = 10)) +
  labs(title = "Photosynthesis and Biomass Responses Across LED Treatments", subtitle = "Variables normalized to their own maximum values to compare response patterns", x = "LED treatment", y = "Relative response (% of maximum)", colour = NULL, caption = caption_text) +
  base_theme + theme(legend.position = "top", legend.direction = "horizontal")

ggsave(file.path("figures", "04_Pn_vs_DryWeight_normalized_clean.png"), p4, width = 10.5, height = 6.2, dpi = 320)

write.csv(df, file.path("figures", "summary_table_for_figures.csv"), row.names = FALSE)
cat("Done. Figures saved in the figures folder.
")
