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
main_recipe_1 <- recipe(target ~ ., data = students_train) |> 
  step_rm(mothers_qualification, fathers_qualification, mothers_occupation, fathers_occupation) |>
  step_zv() |> 
  step_normalize() |> 
  step_dummy(all_nominal_predictors())

prep(main_recipe_1) |>
  bake(new_data = NULL)

tree_recipe_1 <- recipe(target ~ ., data = students_train) |> 
  step_rm(mothers_qualification, fathers_qualification, mothers_occupation, fathers_occupation) |>
  step_zv() |> 
  step_normalize() |> 
  step_dummy(all_nominal_predictors(), one_hot = TRUE)

prep(tree_recipe_1) |>
  bake(new_data = NULL)

# save out recipes
save(main_recipe_1, tree_recipe_1, file = here("recipes/students_recipe.rda"))
