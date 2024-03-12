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
  step_dummy(all_nominal_predictors()) |> 
  step_zv(all_predictors()) |> 
  step_normalize(all_predictors()) 

prep(main_recipe_1) |>
  bake(new_data = NULL)

# kitchen sink recipe parametric
tree_recipe_1 <- recipe(target ~ ., data = students_train) |> 
  step_rm(mothers_qualification, fathers_qualification, mothers_occupation, fathers_occupation) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |> 
  step_zv(all_predictors()) |> 
  step_normalize(all_predictors()) 

prep(tree_recipe_1) |>
  bake(new_data = NULL)

# feature engineering recipe non-parametric

# FIRST DRAFT RECIPE
# main_recipe_2 <- recipe(target ~ ., data = students_train) |>
#   step_rm(mothers_qualification, fathers_qualification, mothers_occupation, fathers_occupation) |>
#   step_nzv() |>
#   step_normalize() |>
#   step_dummy(all_nominal_predictors())|>
#   step_interact(terms = ~ curricular_units_1st_sem_approved * curricular_units_2nd_sem_grade) |>
#   step_interact(terms = ~ curricular_units_1st_sem_enrolled * curricular_units_2nd_sem_enrolled) |>
#   step_interact(terms = ~ curricular_units_1st_sem_credited * curricular_units_2nd_sem_credited)

# SECOND DRAFT
# main_recipe_2 <- recipe(target ~ curricular_units_1st_sem_grade + curricular_units_1st_sem_approved + curricular_units_2nd_sem_grade + curricular_units_2nd_sem_approved + marital_status + application_mode + course + daytime_evening_attendance + previous_qualification + debtor + tuition_fees_up_to_date + gender + scholarship_holder + age_at_enrollment + curricular_units_1st_sem_enrolled + curricular_units_2nd_sem_enrolled + curricular_units_1st_sem_credited + curricular_units_2nd_sem_credited, data = students_train) |>
#   step_zv() |>
#   step_normalize() |>
#   step_dummy(all_nominal_predictors())|>
#   step_interact(terms = ~ curricular_units_1st_sem_approved * curricular_units_2nd_sem_grade) |>
#   step_interact(terms = ~ curricular_units_1st_sem_enrolled * curricular_units_2nd_sem_enrolled) |>
#   step_interact(terms = ~ curricular_units_1st_sem_credited * curricular_units_2nd_sem_credited)

main_recipe_2 <- recipe(target ~ curricular_units_1st_sem_grade + curricular_units_1st_sem_approved + curricular_units_2nd_sem_grade + curricular_units_2nd_sem_approved + marital_status + application_mode + course + daytime_evening_attendance + previous_qualification + debtor + tuition_fees_up_to_date + gender + scholarship_holder + age_at_enrollment + curricular_units_1st_sem_enrolled + curricular_units_2nd_sem_enrolled + curricular_units_1st_sem_credited + curricular_units_2nd_sem_credited, data = students_train) |>
  step_dummy(all_nominal_predictors()) |>
  step_interact(terms = ~ curricular_units_1st_sem_approved * curricular_units_2nd_sem_grade) |>
  step_interact(terms = ~ curricular_units_1st_sem_enrolled * curricular_units_2nd_sem_enrolled) |>
  step_interact(terms = ~ curricular_units_1st_sem_credited * curricular_units_2nd_sem_credited) |> 
  step_zv(all_predictors()) |>
  step_normalize(all_predictors()) |>
  step_corr(all_predictors())
  
# step_pca()?
# step_other() categorical non binary

view <- prep(main_recipe_2) |>
  bake(new_data = NULL)

# feature engineering recipe parametric
# FIRST DRAFT
# tree_recipe_2 <- recipe(target ~ ., data = students_train) |> 
#   step_rm(mothers_qualification, fathers_qualification, mothers_occupation, fathers_occupation) |>
#   step_nzv() |> 
#   step_normalize() |> 
#   step_dummy(all_nominal_predictors(), one_hot = TRUE)

# SECOND DRAFT
# tree_recipe_2 <- recipe(target ~ curricular_units_1st_sem_grade + curricular_units_1st_sem_approved + curricular_units_2nd_sem_grade + curricular_units_2nd_sem_approved + marital_status + application_mode + course + daytime_evening_attendance + previous_qualification + debtor + tuition_fees_up_to_date + gender + scholarship_holder + age_at_enrollment, data = students_train) |> 
#   step_zv() |> 
#   step_normalize() |> 
#   step_dummy(all_nominal_predictors(), one_hot = TRUE)

tree_recipe_2 <- recipe(target ~ curricular_units_1st_sem_grade + curricular_units_1st_sem_approved + curricular_units_2nd_sem_grade + curricular_units_2nd_sem_approved + marital_status + application_mode + course + daytime_evening_attendance + previous_qualification + debtor + tuition_fees_up_to_date + gender + scholarship_holder + age_at_enrollment, data = students_train) |>
  step_dummy(all_nominal_predictors(), one_hot = TRUE) |> 
  step_zv(all_predictors()) |>
  step_normalize(all_predictors()) |>
  step_corr(all_predictors()) |> 
  step_pca(all_numeric_predictors(), num_comp = 20)

prep(tree_recipe_2) |>
  bake(new_data = NULL)

# save out recipes
save(main_recipe_1, tree_recipe_1, main_recipe_2, tree_recipe_2, file = here("recipes/students_recipe.rda"))
