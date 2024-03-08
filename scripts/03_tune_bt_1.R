# Final Project - Boosted Tree Model: Recipe 1
# Define and tune boosted tree model

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

# model specification ----
bt_model <- boost_tree(
  mode = "classification",
  mtry = tune(),
  min_n = tune(),
  learn_rate = tune()
) |>
  set_engine("xgboost")

# define workflow ----
bt_workflow <- workflow() |>
  add_model (bt_model) |>
  add_recipe(tree_recipe_1)

# hyperparameter tuning values ----
bt_params <- extract_parameter_set_dials(bt_model) |>
  update(mtry = mtry(range = c(1, 40)),
         min_n = min_n(range = c(2, 40)),
         learn_rate = learn_rate(range = c(-5, -0.2)))

bt_grid <- grid_regular(bt_params, levels = 5)

# fit workflows/models ----
bt_tuned <- tune_grid(
  bt_workflow,
  students_folds,
  grid = bt_grid,
  control = control_grid(save_workflow = TRUE)
)

# write out results (fitted/trained workflows) ----
save(bt_tuned, file = here("results/bt_tuned.rda"))