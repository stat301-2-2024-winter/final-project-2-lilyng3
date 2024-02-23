# Progress Memo 2 - recipes
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

# need to rm too specific variables, such as parent career, etc
# engine for null is parsnip
# state which assessment metrics you will use
# null and baseline are the same thing?

students_recipe <- recipe(target ~ ., data = students_train) |> 
  step_rm(mothers_qualification, fathers_qualification, mothers_occupation, fathers_occupation) |>
  step_zv() |> 
  step_normalize() |> 
  step_dummy(all_nominal_predictors())

  # step_impute_linear(age)

prep(students_recipe) |>
  bake(new_data = NULL)

# save out recipes
save(students_recipe, file = here("memos/memo-2/results/students_recipe.rda"))