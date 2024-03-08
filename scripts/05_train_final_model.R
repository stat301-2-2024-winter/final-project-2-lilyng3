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

# find best model
best_en <- select_best(en_tuned_2, "roc_auc")
best_en

save(best_en, file = here("results/best_model_parameters.rda"))

# finalize workflow 
final_workflow <- en_tuned_2 |> 
  extract_workflow(en_tuned_2) |>  
  finalize_workflow(select_best(en_tuned_2, metric = "roc_auc"))

# train final model 
final_fit <- fit(final_workflow, students_train)

save(final_fit, file = here("results/final_fit.rda"))