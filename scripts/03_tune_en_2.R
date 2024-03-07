# Final Project - Elastic Net Model: Recipe 1
# Define and tune elastic net model

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
en_model <-
  logistic_reg(mode = "classification",
               penalty = tune(),
               mixture = tune()) |>
  set_engine("glmnet")

# define workflows ----
en_workflow <- workflow() |>
  add_model(en_model) |>
  add_recipe(main_recipe_2)

# hyperparameter tuning values ----
en_params <- extract_parameter_set_dials(en_model)

en_grid <- grid_regular(en_params, levels = 5)

# fit workflows/models ----
en_tuned_2 <- tune_grid(
  en_workflow,
  students_folds,
  grid = en_grid,
  control = control_grid(save_workflow = TRUE)
)

# write out results (fitted/trained workflows) ----
save(en_tuned_2, file = here("results/en_tuned_2.rda"))