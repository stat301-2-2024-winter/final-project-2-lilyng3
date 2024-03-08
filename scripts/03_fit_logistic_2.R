# Final Project - Logistic Model
# Define and fit logistic model

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
logistic_model <- logistic_reg() |>
  set_engine("glm") |>
  set_mode("classification")

# define workflow ----
logistic_workflow <- workflow() |>
  add_model(logistic_model) |>
  add_recipe(main_recipe_2)

# fit workflow/model ----
logistic_fit_2 <- fit_resamples(
  logistic_workflow,
  resamples = students_folds,
  control = control_resamples(save_workflow = TRUE,
                              parallel_over = "everything")
)

# save out recipes
save(logistic_fit_2, file = here("results/logistic_fit_2.rda"))
