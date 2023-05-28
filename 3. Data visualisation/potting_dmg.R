# Load required packages
library(ggplot2)
library(reshape2)
library(gridExtra)
library(tidyverse)
library(grid)
library(gridtext)

# Read the data file
data <- read.delim("../euka/plot_euka/euka_dmg_eager_Cervus.prof", header = TRUE, sep = "\t")

# Reshape the data from wide to long format
data_long <- melt(data, id.vars = "Position")

# Filter the data for values from 0 to 5
data_positive <- subset(data_long, Position >= 0 & Position <= 5)
# Filter the data for values from -5 to -1
data_negative <- subset(data_long, Position >= -5 & Position <= -1)

# Plotting for values from 0 to 5
plot_positive <- ggplot(data_positive, aes(x = Position, y = value, color = variable)) +
  geom_line(size = 1) +
  scale_color_manual(values = c("grey", "red", "blue", "grey", "grey", "grey", "grey", "grey", "grey", "grey", "grey", "grey"), breaks = c("A.C","C.T","G.A"), labels=c("other", "C to T", "G to A")) +
  labs(x = "", y = "Frequency", color = "Base Substitution") +
  theme_minimal()

# Plotting for values from -5 to -1
plot_negative <- ggplot(data_negative, aes(x = Position, y = value, color = variable)) +
  geom_line(size = 1) +
  scale_color_manual(values = c("grey", "red", "blue", "grey", "grey", "grey", "grey", "grey", "grey", "grey", "grey", "grey"), breaks = c("A.C","C.T","G.A"), labels=c("other", "C to T", "G to A")) +
  labs(x = "", y = "", color = "Base Substitution") +
  theme_minimal()


# Combine the plots side by side
combined_plot <- ggpubr::ggarrange(plot_positive, plot_negative, ncol = 2, common.legend = TRUE, legend = "bottom")

combined_plot <- ggpubr::annotate_figure(combined_plot, top = textGrob("Damage patterns Cervus (euka w. damage & eager)"))

# Save the combined plot to a file
ggsave("euka_dmg_eager_cervus.jpg", combined_plot, width = 10, height = 5)

