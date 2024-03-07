# Final Project - Random Forest Model: Recipe 1
# Define and tune random forest model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("data_splits/students_split.rda"))
load(here("recipes/students_recipe.rda"))

# set seed
set.seed(847)

# model specification ----
rf_model <- rand_forest(
  mode = "classification",
  trees = 500,
  min_n = tune(),
  mtry = tune()
) |>
  set_engine("ranger")

# define workflows ----
rf_workflow <- workflow() |> 
  add_model(rf_model) |> 
  add_recipe(tree_recipe_2)

# hyperparameter tuning values ----
rf_params <- extract_parameter_set_dials(rf_model) |> 
  update(mtry = mtry(range = c(1, 101)))

rf_grid <- grid_regular(rf_params, levels = 5)

# fit workflows/models ----
rf_tuned_2 <- tune_grid(rf_workflow,
                      students_folds,
                      grid = rf_grid,
                      control = control_grid(save_workflow = TRUE))

# write out results (fitted/trained workflows) ----
save(rf_tuned_2, file = here("results/rf_tuned_2.rda"))