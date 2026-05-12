
# Figure 1 reproduction script - original-like layout + legend restored
# 只做三类改动：
# 1) 保留 v2 的整体布局比例，避免 d 图被压缩
# 2) 补回 Meta-analytical data / Primary data 图例，并放在地图和 b 图之间
# 3) 统一左侧 4 个纵坐标标题的字号、字重和间距
#
# 使用方法：
# source("Figure1_N_original_like.R")

required_pkgs <- c("ggplot2", "data.table", "ggpubr", "readxl", "maps", "grid")

to_install <- required_pkgs[!required_pkgs %in% installed.packages()[, "Package"]]
if (length(to_install) > 0) install.packages(to_install, dependencies = TRUE)

library(ggplot2)
library(data.table)
library(ggpubr)
library(readxl)
library(maps)
library(grid)

site_file_candidates <- c("You_paper3_S2.xlsx", "You_paper_3_S2.xlsx")
site_file <- site_file_candidates[file.exists(site_file_candidates)][1]
if (is.na(site_file)) stop("找不到 xlsx 文件。")

csv_file_candidates <- c("metaresult_paper3.csv", "metaresult_paper_3.csv")
csv_file <- csv_file_candidates[file.exists(csv_file_candidates)][1]
if (is.na(csv_file)) stop("找不到 csv 文件。")

site <- as.data.table(read_excel(site_file, sheet = 1))
site[management %in% c("OF", "CF", "RFR", "RFT", "RFP", "EE", "BC"), management := "Nutrient management"]
site[management %in% c("ROT", "CC", "RES"), management := "Crop management"]
site[management %in% c("NT", "RT"), management := "Soil management"]
setnames(site, old = "management", new = "Management practice")
site[, `Management practice` := factor(`Management practice`, levels = c(
  "Nutrient management", "Crop management", "Soil management"
))]
world <- map_data("world")
world <- subset(world, region != "Antarctica")

# a panel
p1 <- ggplot() +
  geom_map(
    data = world, map = world,
    aes(long, lat, map_id = region),
    color = "#838B8B", fill = "#E0EEEE", linewidth = 0.1
  ) +
  geom_point(
    data = site,
    aes(lon, lat, color = `Management practice`),
    alpha = 1, size = 1
  ) +
  scale_color_manual(values = c(
    "Nutrient management" = "indianred3",
    "Crop management" = "seagreen3",
    "Soil management" = "royalblue3"
  )) +
  theme_bw() +
  theme(
    panel.grid = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank(),
    axis.title = element_blank(),
    legend.position = c(0.1, 0.3),
    legend.text = element_text(size = 12, color = "black"),
    legend.background = element_blank(),
    legend.title = element_text(face = "bold", size = 12, color = "black"),
    plot.margin = margin(5.5, 5.5, 1, 5.5),
    plot.background = element_rect(fill = "white", color = NA)
  )

metaresult_group <- fread(csv_file, encoding = "UTF-8")
setnames(metaresult_group, trimws(names(metaresult_group)))

for (col in intersect(c("Group.type","Vari","Management","Group"), names(metaresult_group))) {
  metaresult_group[[col]] <- trimws(as.character(metaresult_group[[col]]))
}
for (col in intersect(c("mean","ci.lb","ci.ub","n"), names(metaresult_group))) {
  suppressWarnings(metaresult_group[[col]] <- as.numeric(metaresult_group[[col]]))
}

mgmt_order <- rev(c(
  "Reduced tillage", "No tillage", "Crop rotation", "Cover cropping",
  "Residue retention", "Biochar", "Fertilizer placement", "Fertilizer timing",
  "Fertilizer rate", "Organic fertilizer", "Combined fertilizer",
  "Enhanced efficiency"
))

pick_rows <- function(dt, group_keywords, vari_keywords) {
  x <- copy(dt)
  gt <- if ("Group.type" %in% names(x)) tolower(trimws(x$Group.type)) else rep("", nrow(x))
  vv <- if ("Vari" %in% names(x)) tolower(trimws(x$Vari)) else rep("", nrow(x))
  m1 <- Reduce(`|`, lapply(group_keywords, function(k) grepl(k, gt, fixed = TRUE)))
  m2 <- Reduce(`|`, lapply(vari_keywords, function(k) grepl(k, vv, fixed = TRUE)))
  x[m1 | m2]
}

clean_group <- function(x) {
  x <- trimws(as.character(x))
  xl <- tolower(x)
  out <- x
  out[grepl("meta", xl)] <- "Meta-analytical data"
  out[grepl("primary", xl)] <- "Primary data"
  out
}

group_levels <- c("Meta-analytical data", "Primary data")

# 图例：单独放在 e 图下方
legend_df <- data.frame(
  x = c(1, 2),
  y = c(1, 1),
  Group2 = factor(group_levels, levels = group_levels)
)

legend_plot <- ggplot(legend_df, aes(x = x, y = y, shape = Group2, fill = Group2)) +
  geom_point(size = 2, stroke = 0.1, color = "black") +
  scale_shape_manual(values = c("Meta-analytical data" = 21, "Primary data" = 23), drop = FALSE) +
  scale_fill_manual(values = c("Meta-analytical data" = "#F8766D", "Primary data" = "#00BFC4"), drop = FALSE) +
  guides(
    fill = "none",
    shape = guide_legend(nrow = 1, byrow = TRUE,
                         override.aes = list(
                           fill = c("#F8766D", "#00BFC4"),
                           color = "black", size = 2, stroke = 0.1
                         ))
  ) +
  theme_void() +
  theme(
    legend.position = "center",
    legend.direction = "horizontal",
    legend.title = element_blank(),
    legend.text = element_text(size = 10, color = "black"),
    legend.key.width = unit(0.9, "lines"),
    legend.margin = margin(0, 0, 0, 0),
    legend.box.margin = margin(0, 0, 0, 0),
    plot.margin = margin(0, 0, 0, 0),
    plot.background = element_rect(fill = "white", color = NA)
  )

legend_row <- as_ggplot(get_legend(legend_plot))

make_panel <- function(mydata, y_lab, show_x = FALSE) {
  if (nrow(mydata) == 0) {
    stop("某个子图没有匹配到数据，请检查 CSV 的 Vari / Group.type 值。")
  }

  if (!"Group" %in% names(mydata)) mydata[, Group := "Meta-analytical data"]
  mydata[, Group2 := clean_group(Group)]
  mydata[, Group2 := factor(Group2, levels = group_levels)]
  mydata[, Management := factor(Management, levels = mgmt_order)]

  p <- ggplot(mydata, aes(x = Management, y = mean, shape = Group2, fill = Group2)) +
    geom_rect(aes(ymin = -Inf, xmin = -Inf, ymax = Inf, xmax = 7.5), fill = "#E7DAD2", inherit.aes = FALSE) +
    geom_rect(aes(ymin = -Inf, xmin = 7.5, ymax = Inf, xmax = 10.5), fill = "#E0EEEE", inherit.aes = FALSE) +
    geom_rect(aes(ymin = -Inf, xmin = 10.5, ymax = Inf, xmax = Inf), fill = "#DCDCDC", inherit.aes = FALSE) +
    geom_hline(yintercept = 0, linetype = "dashed", linewidth = 0.1) +
    geom_errorbar(
      aes(ymin = ci.lb, ymax = ci.ub),
      position = position_dodge(0.7),
      width = 0.1, linewidth = 0.4
    ) +
    geom_point(position = position_dodge(0.7), size = 2, stroke = 0) +
    scale_shape_manual(values = c("Meta-analytical data" = 21, "Primary data" = 23), drop = FALSE) +
    scale_fill_manual(values = c("Meta-analytical data" = "#F8766D", "Primary data" = "#00BFC4"), drop = FALSE) +
    geom_text(
      aes(y = ci.ub + 6, label = n),
      position = position_dodge(width = 0.7),
      vjust = 0, hjust = 0.5, size = 3
    ) +
    scale_x_discrete(limits = mgmt_order, labels = mgmt_order, drop = FALSE) +
    scale_y_continuous(limits = c(-100, 100), breaks = c(-100, -50, 0, 50, 100)) +
    labs(x = "Management practice", y = y_lab) +
    theme_bw() +
    theme(
      legend.title = element_blank(),
      legend.position = "none",
      legend.key = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.title.y = element_text(size = 12, colour = "black", face = "plain", margin = margin(r = 14)),
      axis.title.x = if (show_x) element_text(size = 12, colour = "black", face = "bold") else element_blank(),
      axis.text.y = element_text(colour = "black", size = 11, margin = margin(r = 2)),
      axis.ticks.x = if (show_x) element_line() else element_blank(),
      axis.text.x = if (show_x) element_text(colour = "black", size = 12, angle = 45, hjust = 1, vjust = 1) else element_blank(),
      plot.margin = margin(10, 5.5, 10, 18),
      plot.background = element_rect(fill = "white", color = NA)
    )
  p
}

p2 <- make_panel(pick_rows(metaresult_group, c("n2o"), c("n2o")), "N₂O emission (%)", FALSE)
p3 <- make_panel(pick_rows(metaresult_group, c("nh3"), c("nh3")), "NH₃ emission (%)", FALSE)
p4 <- make_panel(pick_rows(metaresult_group, c("runoff"), c("runoff")), "N runoff (%)", FALSE)
p5 <- make_panel(pick_rows(metaresult_group, c("leaching"), c("leaching")), "N leaching (%)", TRUE)

# 保留原图布局风格：图例放到 e 图下方，同时拉开 b-e 之间的间距
p <- ggarrange(
  p1, p2, p3, p4, p5, legend_row,
  ncol = 1, nrow = 6, align = "v",
  heights = c(3, 2.15, 2.15, 2.15, 4.5, 0.38),
  labels = c("a", "b", "c", "d", "e", ""),
  label.x = 0.96, label.y = 0.9,
  font.label = list(size = 12, color = "black", face = "bold"),
  hjust = -0.2, vjust = 1
)

ggsave(
  file = "Figure1_N_original_like_v2_legend_bottom.tiff",
  plot = p,
  width = 195, height = 232, units = "mm", dpi = 300,
  bg = "white", compression = "lzw"
)

message("完成：已输出 Figure1_N_original_like_v2_legend_bottom.tiff")
