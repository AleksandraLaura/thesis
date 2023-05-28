# Load required packages
library(ggplot2)
library(reshape2)
library(gridExtra)
library(tidyverse)
library(grid)
library(gridtext)

#MALT dmg patterns plotting
MALT_dmg_eager <- read.delim("../MALT/plot_MALT/print_malt_eager_damage.txt")
MALT_dmg_plain <- read.delim("../MALT/plot_MALT/print_malt_plain_damage.txt")

# Iterate through each row and generate plots
for (i in 1:nrow(MALT_dmg_plain)) {
  # Extract the row data
  row_data <- MALT_dmg_plain[i, ]
  
  # Split the row data into two sets of columns
  data_left <- row_data[1:10]
  data_right <- row_data[11:20]
  
  # Convert the data to a data frame
  data_left <- data.frame(Position = 1:10, value = as.numeric(data_left))
  data_right <- data.frame(Position = 1:10, value = as.numeric(data_right))
  
  # Create separate plots for left and right data
  plot_left <- ggplot(data_left, aes(x = Position, y = value)) +
    geom_line(size = 1, col = "blue") +
    labs(x = "Position", y = "Frequency", title = "C to T at 5'")
  
  plot_right <- ggplot(data_right, aes(x = Position, y = value)) +
    geom_line(size = 1, col = "red") +
    labs(x = "Position", y = "Frequency", title = "G to A at 3'")
  
  # Combine the plots side by side
  combined_plot <- ggpubr::ggarrange(plot_left, plot_right, ncol = 2)
  
  # Get the row name as the plot title
  row_name <- MALT_dmg_plain$Node[i]
  
   # Add strings before and after the row name
  title_prefix <- "MALT wo. eager damage distribution for "
  plot_title <- paste0(title_prefix, row_name)

  
  combined_plot <- ggpubr::annotate_figure(combined_plot, top = plot_title)
  
  # Save the combined plot to a file
  ggsave(paste0("MALT_plain_DMGplot_", i, ".jpg"), combined_plot, width = 10, height = 5)
}
