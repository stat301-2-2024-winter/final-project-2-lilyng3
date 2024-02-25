# Final Project - Recipes
# Setup pre-processing/recipes

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("memos/memo-2/results/students_split.rda"))

# set seed
set.seed(847)

# kitchen sink recipe
students_recipe <- recipe(target ~ ., data = students_train) |> 
  step_rm(mothers_qualification, fathers_qualification, mothers_occupation, fathers_occupation) |>
  step_zv() |> 
  step_normalize() |> 
  step_dummy(all_nominal_predictors())

prep(students_recipe) |>
  bake(new_data = NULL)

# save out recipes
save(students_recipe, file = here("results/students_recipe.rda"))