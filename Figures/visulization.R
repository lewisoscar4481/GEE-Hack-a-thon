# Load libraries ----
library(ggplot2)
devtools::install_github('Mikata-Project/ggthemr') # to install the ggthemr package
# if you don't have it already
library(ggthemr)  # to set a custom theme but non essential!
library(forcats)  # to reorder categorical variables
library(tidyverse)
# Set theme for the plot
ggthemr('dust', type = "outer", layout = "minimal")

# This theme will now be applied to all plots you make, if you wanted to
# get rid of it, use:
# ggthemr_reset()


getwd()
setwd("/Users/katy/Desktop/DATA SCIENCE")

forest_change <- read.csv("forest_change_Bialowieza1.csv")

# Create identifier column for gain vs loss

forest_long <- gather(forest_change[, c(32:63)],
                   key = 'Gain',
                   value = 'value')

forest_long1<- separate ( data = forest_long,
           col = 'Gain',
           into= c('type', 'year'),
           sep= '_')



(forest_barplot <- ggplot(forest_long1, aes(x = type, y = value, 
                                             fill = fct_rev(type))) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(x = NULL, y = "Forest change (% of park area)\n") +
    # Expanding the scale removes the emtpy space below the bars
    scale_y_continuous(expand = c(0, 0)) +
    theme(text = element_text(size = 16),  # makes font size larger
          legend.position = c(0.1, 0.85),  # changes the placement of the legend
          legend.title = element_blank(),  # gets rid of the legend title
          legend.background = element_rect(color = "black", 
                                           fill = "transparent",   # removes the white background behind the legend
                                           linetype = "blank"))) +
  labs(
    x= "Bialowieza Forest"
  )

ggsave(forest_barplot, filename = "forest_barplot.png",
       height = 5, width = 7)
