# Progress Memo 2 - logistic model fit
# Define and fit ordinary logistic model

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("memos/memo-2/results/students_split.rda"))
load(here("memos/memo-2/results/students_recipe.rda"))

# set seed
set.seed(847)

# model specification ----
logistic_model <- logistic_reg() |>
  set_engine("glm") |>
  set_mode("classification")

# define workflow ----
logistic_workflow <- workflow() |>
  add_model(logistic_model) |>
  add_recipe(students_recipe)

# fit workflow/model ----
logistic_fit <- fit_resamples(
  logistic_workflow,
  resamples = students_folds,
  control = control_resamples(save_workflow = TRUE,
                              parallel_over = "everything")
)

# save out recipes
save(logistic_fit, file = here("memos/memo-2/results/logistic_fit.rda"))