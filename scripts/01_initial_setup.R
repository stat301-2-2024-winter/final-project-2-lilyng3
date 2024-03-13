# Final Project - Initial Setup
# Initial data checks, data splitting, & data folding for the assessment metric of 'target'

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(readxl)

# handle common conflicts
tidymodels_prefer()

# set seed
set.seed(847)

# load data
students_raw <- read_csv(here("data/students.csv")) |> 
  janitor::clean_names()

# clean data --------------------------------------------------------------
students <- students_raw |>
  filter(target != "Enrolled") |> 
  mutate(
    target = factor(target),
    marital_status = factor(
      marital_status,
      levels = c(1, 2, 3, 4, 5, 6),
      labels = c(
        "single",
        "married",
        "widower",
        "divorced",
        "facto union",
        "legally separated"
      ),
      ordered = FALSE
    ),
    daytime_evening_attendance = factor(
      daytime_evening_attendance,
      levels = c(0, 1),
      labels = c("evening", "daytime")
    ),
    displaced = factor(
      displaced,
      levels = c(0, 1),
      labels = c("no", "yes")
    ),
    educational_special_needs = factor(
      educational_special_needs,
      levels = c(0, 1),
      labels = c("no", "yes")
    ),
    debtor = factor(
      debtor,
      levels = c(0, 1),
      labels = c("no", "yes")
    ),
    tuition_fees_up_to_date = factor(
      tuition_fees_up_to_date,
      levels = c(0, 1),
      labels = c("no", "yes")
    ),
    gender = factor(
      gender,
      levels = c(0, 1),
      labels = c("female", "male")
    ),
    scholarship_holder = factor(
      scholarship_holder,
      levels = c(0, 1),
      labels = c("no", "yes")
    ),
    international = factor(
      international,
      levels = c(0, 1),
      labels = c("no", "yes")
    ),
    continent = factor(
      nacionality,
      levels = c(1:21),
      labels = c("Europe", "Europe", "Europe", "Europe", "Europe", "Europe", "Europe", "Africa", "Europe", "Africa", "Africa", "Africa", "Europe", "South America", "Europe", "Europe", "North America", "Europe", "Europe", "North America", "South America")
    ),
    application_mode = as.character(application_mode),
    application_order = factor(
      application_order,
      levels = c(1:9),
      ordered = TRUE
    ),
    course = as.character(course),
    previous_qualification = as.character(previous_qualification)
  )

save(students, file = here("data/students_clean.rda"))

# explore target variable --------------------------------------------------------------
students |> 
  

# split data and create folds --------------------------------------------------------------
students_split <- students |>
  initial_split(prop = 0.8, strata = target)

students_train <- students_split |> training()
students_test <- students_split |> testing()

students_folds <-
  vfold_cv(students_train,
           v = 10,
           repeats = 5,
           strata = target)

save(students_train, students_test, students_folds, file = here("data_splits/students_split.rda"))
