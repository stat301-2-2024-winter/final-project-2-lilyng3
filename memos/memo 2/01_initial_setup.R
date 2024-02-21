# Progress Memo 2 ----
# Initial data checks, data splitting, & data folding

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
students_raw <- read_csv(here("data/dataset.csv")) |> 
  janitor::clean_names()

students <- students_raw |>
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
      labels = c("evening", "daytime"),
      ordered = FALSE
    ),
    displaced = factor(
      displaced,
      levels = c(0, 1),
      labels = c("no", "yes"),
      ordered = FALSE
    ),
    educational_special_needs = factor(
      educational_special_needs,
      levels = c(0, 1),
      labels = c("no", "yes"),
      ordered = FALSE
    ),
    debtor = factor(
      debtor,
      levels = c(0, 1),
      labels = c("no", "yes"),
      ordered = FALSE
    ),
    tuition_fees_up_to_date = factor(
      tuition_fees_up_to_date,
      levels = c(0, 1),
      labels = c("no", "yes"),
      ordered = FALSE
    ),
    gender = factor(
      gender,
      levels = c(0, 1),
      labels = c("female", "male"),
      ordered = FALSE
    ),
    scholarship_holder = factor(
      scholarship_holder,
      levels = c(0, 1),
      labels = c("no", "yes"),
      ordered = FALSE
    ),
    international = factor(
      international,
      levels = c(0, 1),
      labels = c("no", "yes"),
      ordered = FALSE
    ),
  ) |>
  filter(target != "Enrolled")
