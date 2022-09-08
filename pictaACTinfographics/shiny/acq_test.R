library(here)
library(RCurl)
library(ggplot2)
library(shiny)
library(readr)
library(DT)
library(zip)
library(stringr)
library(purrr)
library(knitr)
library(glue)
library(tinytex)
library(png)

source("global.R")

purrr::walk(fs::dir_ls('functions'), function(x){print(x); source(x)})

pt_info_acq <- gen_pt_info_acq(
  display_name = "daniel",
  language = "spanish",
  today_date = "2022-09-06",
  today_acq_score = 6,
  previous_acq = 2.5,
  previous_date = "2022-08-15"
)

pt_info_acq


plot_info <- list(
  arrow_x_all = gen_x_coords_acq(pt_info_acq$language),
  image = png::readPNG(pt_info_acq$png_url)
)

plot_info$base_image_g <- grid::rasterGrob(
  plot_info$image, interpolate = TRUE
)

plot_info$plot_pth_norm <- fs::path_norm(tempfile(fileext = '.png'))
plot_info$plot_pth_unix <- gsub("\\\\", "/", plot_info$plot_pth_norm)
# plot_info$fig_pth_act_exterior <- gen_exterior_png_pth(
#   pt_info_acq$language
# )

print(glue::glue(
  "Generating base plot."
))
base_g <- geom_base_image(plot_info$base_image_g)


# find locations

x_try <- (4.70 + 60 * 1.4775)
base_g +
  geom_point(aes(x = x_try, y = 38.75)) +
  geom_point(aes(x = x_try, y = 35.25)) +
  theme(panel.grid.major = element_line(color = "red",
                                        size = 0.5,
                                        linetype = 2))
ggsave("~/Desktop/bitsi_temp.png",
       scale = 1,
       width = 11,
       height = 8.5,
       units = "in",
       dpi = 300)





print(glue::glue(
  "Generating plot from base."
))

arrow_g <- geom_score_arrows_acq(
  base_g = base_g,
  #today_acq = pt_info_acq$today_acq,
  today_acq = 6.0,
  previous_acq = pt_info_acq$previous_acq,
  previous_date = pt_info_acq$previous_date_text,
  language = pt_info_acq$language,
  x_breaks = plot_info$arrow_x_all
)
arrow_g

ggsave("~/Desktop/bitsi_arrow_tmp.png",
       scale = 1,
       width = 11,
       height = 8.5,
       units = "in",
       dpi = 300)

arrow_g <- geom_score_arrows_acq(
  base_g = base_g,
  #today_acq = pt_info_acq$today_acq,
  today_acq = 3.5,
  previous_acq = 3.5,
  previous_date = pt_info_acq$previous_date_text,
  language = pt_info_acq$language,
  x_breaks = plot_info$arrow_x_all
)
arrow_g

ggsave("~/Desktop/bitsi_previous_same_tmp.png",
       scale = 1,
       width = 11,
       height = 8.5,
       units = "in",
       dpi = 300)



## different values lower

arrow_g <- geom_score_arrows_acq(
  base_g = base_g,
  #today_acq = pt_info_acq$today_acq,
  today_acq = 3.5,
  previous_acq = 1.5,
  previous_date = pt_info_acq$previous_date_text,
  language = "spanish",
  x_breaks = plot_info$arrow_x_all
)
arrow_g

ggsave("~/Desktop/bitsi_previous_lower_tmp.png",
       scale = 1,
       width = 11,
       height = 8.5,
       units = "in",
       dpi = 300)


## different values upper

arrow_g <- geom_score_arrows_acq(
  base_g = base_g,
  #today_acq = pt_info_acq$today_acq,
  today_acq = 3.5,
  previous_acq = 5.9,
  previous_date = pt_info_acq$previous_date_text,
  language = "spanish",
  x_breaks = plot_info$arrow_x_all
)
arrow_g

ggsave("~/Desktop/bitsi_previous_upper_tmp.png",
       scale = 1,
       width = 11,
       height = 8.5,
       units = "in",
       dpi = 300)

