# Final Project - Recipes
# Setup pre-processing/recipes

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("data_splits/students_split.rda"))

# set seed
set.seed(847)

# kitchen sink recipe non-parametric
students_recipe <- recipe(target ~ ., data = students_train) |> 
  step_rm(mothers_qualification, fathers_qualification, mothers_occupation, fathers_occupation) |>
  step_zv() |> 
  step_normalize() |> 
  step_dummy(all_nominal_predictors())

prep(students_recipe) |>
  bake(new_data = NULL)

students_recipe_tree <- recipe(target ~ ., data = students_train) |> 
  step_rm(mothers_qualification, fathers_qualification, mothers_occupation, fathers_occupation) |>
  step_zv() |> 
  step_normalize() |> 
  step_dummy(all_nominal_predictors(), one_hot = TRUE)

prep(students_recipe_tree) |>
  bake(new_data = NULL)

# save out recipes
save(students_recipe, students_recipe_tree, file = here("recipes/students_recipe.rda"))
