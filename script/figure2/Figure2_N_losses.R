library(gridExtra)
library(grid)

library(data.table)
library(ggplot2)
data <- readxl::read_xlsx('D:/43016_2024_1076_MOESM10_ESM.xlsx',sheet = 1)
data <- as.data.table(data)

data$significance <- ifelse(data$p_value < 0.001, "***",
                            ifelse(data$p_value < 0.01, "**",
                                   ifelse(data$p_value < 0.05, "*", "")))

data$significance_pos <- ifelse(data$Parameter_estimate >= 0, data$Parameter_estimate + data$Standard_error, data$Parameter_estimate - data$Standard_error)

data$Moderator <- factor(data$Moderator, levels = unique(data$Moderator))

p1 <- ggplot(data, aes(x = Moderator, y = Parameter_estimate, fill = Moderator)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7, color = NA) +
  
  geom_errorbar(aes(ymin = Parameter_estimate - Standard_error, ymax = Parameter_estimate + Standard_error),
                position = position_dodge(width = 0.7), width = 0.1, size = 0.2, color = "gray20") +
  
  geom_text(aes(x = Moderator, y = significance_pos, label = significance),
            position = position_dodge(width = 0.7), color = "black", vjust = ifelse(data$Parameter_estimate >= 0, 0.35, 1.25),
            size = 3) +
  
  geom_hline(yintercept = 0, color = "gray40", size = 0.1) +
  
  theme(legend.position = "none") +
  
  theme_minimal() +
  theme(panel.grid = element_blank()) +
  guides(fill = FALSE) +
  
  labs(x = "Management practices & Site conditions", y = expression(atop(paste("N"[2], "O emission"), "Parameter estimate")), fill = "Moderator") +
  theme(axis.title.x = element_blank())+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8, family = "Arial", color = "black"),
        axis.text.y = element_text(hjust = 1, size = 8, family = "Arial", color = "black"),
        text = element_text(size = 12, family = "Arial", color = "black"),
        plot.title = element_text(size = 12, family = "Arial", color = "black", hjust = 0.5, vjust = 1))+
  theme(panel.background = element_rect(fill = "#F0F7FA"))

print(p1)

#
data <- readxl::read_xlsx('D:/43016_2024_1076_MOESM10_ESM.xlsx',sheet = 2)
data <- as.data.table(data)

data$significance <- ifelse(data$p_value < 0.001, "***",
                            ifelse(data$p_value < 0.01, "**",
                                   ifelse(data$p_value < 0.05, "*", "")))

data$significance_pos <- ifelse(data$Parameter_estimate >= 0, data$Parameter_estimate + data$Standard_error, data$Parameter_estimate - data$Standard_error)

data$Moderator <- factor(data$Moderator, levels = unique(data$Moderator))

p2 <- ggplot(data, aes(x = Moderator, y = Parameter_estimate, fill = Moderator)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7, color = NA) +
  
  geom_errorbar(aes(ymin = Parameter_estimate - Standard_error, ymax = Parameter_estimate + Standard_error),
                position = position_dodge(width = 0.7), width = 0.1, size = 0.2, color = "gray20") +
  
  geom_text(aes(x = Moderator, y = significance_pos, label = significance),
            position = position_dodge(width = 0.7), color = "black", vjust = ifelse(data$Parameter_estimate >= 0, 0.35, 1.25),
            size = 3) +
  
  geom_hline(yintercept = 0, color = "gray40", size = 0.1) +
  
  theme(legend.position = "none") +
  
  theme_minimal() +
  theme(panel.grid = element_blank()) +
  guides(fill = FALSE) +
  
  labs(x = "Management practices & Site conditions", y = expression(atop(paste("NH"[3], " emission"), "Parameter estimate")), fill = "Moderator") +
  theme(axis.title.x = element_blank())+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8, family = "Arial", color = "black"),
        axis.text.y = element_text(hjust = 1, size = 8, family = "Arial", color = "black"),
        text = element_text(size = 12, family = "Arial", color = "black"),
        plot.title = element_text(size = 12, family = "Arial", color = "black", hjust = 0.5, vjust = 1))+
  theme(panel.background = element_rect(fill = "#F5F5F5"))

print(p2)


#
data <- readxl::read_xlsx('D:/43016_2024_1076_MOESM10_ESM.xlsx',sheet = 3)
data <- as.data.table(data)
data$significance <- ifelse(data$p_value < 0.001, "***",
                            ifelse(data$p_value < 0.01, "**",
                                   ifelse(data$p_value < 0.05, "*", "")))

data$significance_pos <- ifelse(data$Parameter_estimate >= 0, data$Parameter_estimate + data$Standard_error, data$Parameter_estimate - data$Standard_error)

data$Moderator <- factor(data$Moderator, levels = unique(data$Moderator))

p3 <- ggplot(data, aes(x = Moderator, y = Parameter_estimate, fill = Moderator)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7, color = NA) +
  
  geom_errorbar(aes(ymin = Parameter_estimate - Standard_error, ymax = Parameter_estimate + Standard_error),
                position = position_dodge(width = 0.7), width = 0.1, size = 0.2, color = "gray20") +
  
  geom_text(aes(x = Moderator, y = significance_pos, label = significance),
            position = position_dodge(width = 0.7), color = "black", vjust = ifelse(data$Parameter_estimate >= 0, 0.35, 1.25),
            size = 3) +
  
  geom_hline(yintercept = 0, color = "gray40", size = 0.1) +
  
  theme(legend.position = "none") +
  
  theme_minimal() +
  theme(panel.grid = element_blank()) + 
  guides(fill = FALSE) +
  
  labs(x = "Management practices & Site conditions", y = expression(atop(paste("N runoff"), "Parameter estimate")), fill = "Moderator") +
  theme(axis.title.x = element_blank())+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8, family = "Arial", color = "black"),
        axis.text.y = element_text(hjust = 1, size = 8, family = "Arial", color = "black"),
        text = element_text(size = 12, family = "Arial", color = "black"),
        plot.title = element_text(size = 12, family = "Arial", color = "black", hjust = 0.5, vjust = 1))+
  theme(panel.background = element_rect(fill = "#E6F4E6"))

print(p3)


#
data <- readxl::read_xlsx('D:/43016_2024_1076_MOESM10_ESM.xlsx',sheet = 4)
data <- as.data.table(data)

data$significance <- ifelse(data$p_value < 0.001, "***",
                            ifelse(data$p_value < 0.01, "**",
                                   ifelse(data$p_value < 0.05, "*", "")))

data$significance_pos <- ifelse(data$Parameter_estimate >= 0, data$Parameter_estimate + data$Standard_error, data$Parameter_estimate - data$Standard_error)

data$Moderator <- factor(data$Moderator, levels = unique(data$Moderator))

p4 <- ggplot(data, aes(x = Moderator, y = Parameter_estimate, fill = Moderator)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.7, color = NA) +
  
  geom_errorbar(aes(ymin = Parameter_estimate - Standard_error, ymax = Parameter_estimate + Standard_error),
                position = position_dodge(width = 0.7), width = 0.1, size = 0.2, color = "gray20") +
  
  geom_text(aes(x = Moderator, y = significance_pos, label = significance),
            position = position_dodge(width = 0.7), color = "black", vjust = ifelse(data$Parameter_estimate >= 0, 0.35, 1.25),
            size = 3) +
  
  geom_hline(yintercept = 0, color = "gray40", size = 0.1) +
  
  theme(legend.position = "none") +
  
  theme_minimal() +
  theme(panel.grid = element_blank()) +  
  guides(fill = FALSE) + 
  
  labs(x = "Management practices & Site conditions", y = expression(atop( paste("N leaching"), "Parameter estimate")), fill = "Moderator") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8, family = "Arial", color = "black"),
        axis.text.y = element_text(hjust = 1, size = 8, family = "Arial", color = "black"),
        text = element_text(size = 12, family = "Arial", color = "black"),
        plot.title = element_text(size = 12, family = "Arial", color = "black", hjust = 0.5, vjust = 1))+
  theme(panel.background = element_rect(fill = "#FFE6E6"))

print(p4)

#
p_final <- grid.arrange(
  p1, p2, p3, p4,
  ncol = 1, nrow = 4,
  top = textGrob("Effects of management practices on nitrogen loss", 
                 gp = gpar(fontsize = 16, fontface = "bold", family = "SimHei")),
  bottom = textGrob("Management practices & Site conditions", 
                    gp = gpar(fontsize = 12, family = "SimHei")),
  # 手动添加 a/b/c/d 标签（需稍微调整位置，效果和 ggpubr 一致）
  left = textGrob(c("a", "b", "c", "d"), x = 1, y = c(0.875, 0.625, 0.375, 0.125), 
                  gp = gpar(fontsize = 12, fontface = "bold"), rot = 0)
)

# 保存图片（代码不变）
ggsave(
  filename = "D:/Figure2_paper3.tiff",
  plot = p_final,
  width = 179, height = 240, units = "mm",
  dpi = 300, type = "cairo"
)
  
