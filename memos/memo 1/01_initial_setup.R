# INITIAL SETUP ----
# this file contains data quality checks, a little data cleaning, and exploration of the target variable

# load packages
library(tidyverse)
library(tidymodels)
library(readxl)
library(here)

# read data in
students_raw <- read_csv(here("data/dataset.csv")) |> 
  janitor::clean_names()

# data quality check ----
summary_only <- skim(data) %>%
  select(summary)

students <- students_raw |> 
  mutate(
    target = factor(target),
  )

# checking for missingness
vis_miss(students)

# target variable analysis
students |> 
  ggplot(aes(x = target)) +
  geom_bar(fill = "darkblue") +
  theme_minimal() +
  labs(
    title = "Distribution of Student Enrollment Status",
    x = "Status",
    y = "Count"
  )

