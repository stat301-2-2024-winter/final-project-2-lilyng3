# Final Project - Train Final Model
# Train model based on analysis results

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("data_splits/students_split.rda"))
load(here("results/en_tuned_2.rda"))

# parallel processing
library(doMC)
registerDoMC(cores = parallel::detectCores(logical = TRUE))

# set seed
set.seed(847)

students_predict <- students_test |>
  select(target) |>
  bind_cols(predict(final_fit, students_test))

accuracy_final <- accuracy(students_predict, truth = target, estimate = .pred_class)
accuracy_final

save(accuracy_final, file = here("results/accuracy_final.rda"))

conf_matrix <- conf_mat(students_predict, truth = target, estimate = .pred_class) 
conf_matrix

save(conf_matrix, file = here("results/conf_matrix.rda"))
