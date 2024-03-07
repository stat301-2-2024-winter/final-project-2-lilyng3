# Final Project - K-Nearest Neighbors Model: Recipe 1
# Define and tune k-nearest neighbors model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# parallel processing
library(doMC)
registerDoMC(cores = parallel::detectCores(logical = TRUE))

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("data_splits/students_split.rda"))
load(here("recipes/students_recipe.rda"))

# set seed
set.seed(847)

# model specifications ----
knn_model <-
  nearest_neighbor(mode = "classification", neighbors = tune()) |>
  set_engine("kknn")

# define workflows ----
knn_workflow <- workflow() |>
  add_model(knn_model) |>
  add_recipe(main_recipe_2)

# hyperparameter tuning values ----
knn_params <- extract_parameter_set_dials(knn_model)

knn_grid <- grid_regular(knn_params, levels = 5)

# fit workflows/models ----
knn_tuned_2 <- tune_grid(
  knn_workflow,
  students_folds,
  grid = knn_grid,
  control = control_grid(save_workflow = TRUE)
)

# write out results (fitted/trained workflows) ----
save(knn_tuned_2, file = here("results/knn_tuned_2.rda"))