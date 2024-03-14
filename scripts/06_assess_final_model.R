# Final Project - Train Final Model
# Train model based on analysis results

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(knitr)

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("data_splits/students_split.rda"))
load(here("results/en_tuned_2.rda"))
load(here("results/final_fit.rda"))

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

students_predict_rocauc <- students_test |> 
  select(target) |> 
  bind_cols(predict(final_fit, students_test, type = "prob"))
students_predict_rocauc

roc_curve <- roc_curve(students_predict_rocauc, target, .pred_Dropout)

roc_plot <- autoplot(roc_curve)
roc_plot

roc_final <- roc_auc(students_predict_rocauc, target, .pred_Dropout)
roc_final

save(accuracy_final, roc_plot, roc_final, file = here("results/metrics_final.rda"))

conf_matrix <- conf_mat(students_predict, truth = target, estimate = .pred_class) 
conf_matrix

conf_matrix_plot <- autoplot(conf_matrix, type = "heatmap") +
  scale_fill_gradient(low="#b2df8a", high = "#33a02c")
conf_matrix_plot

save(conf_matrix, conf_matrix_plot, file = here("results/conf_matrix.rda"))
