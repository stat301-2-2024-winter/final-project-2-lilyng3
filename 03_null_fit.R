# Final Project - Null Model
# Define and fit ordinary null model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("results/students_split.rda"))
load(here("results/students_recipe.rda"))

# set seed
set.seed(847)

# model specification ----
null_model <- null_model() |>
  set_engine("parsnip") |>
  set_mode("classification")

# define workflow ----
null_workflow <- workflow() |>
  add_model (null_model) |>
  add_recipe(students_recipe)

# fit workflow/model ----
null_fit <- fit_resamples(
  null_workflow,
  resamples = students_folds,
  control = control_resamples(save_workflow = TRUE,
                              parallel_over = "everything")
)

# save out recipes
save(null_fit, file = here("results/null_fit.rda"))
