# Final Project - EDA
# EDA on the training data after split

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

# numeric eda
cor_matrix <- students_train |> 
  select(where(is.numeric)) |> 
  cor()

ggcorrplot::ggcorrplot(cor_matrix)
# potential inverse relationship
# unemployment rate + gdp
# potential relationship
# curricular_units_2nd_sem_grade + curricular_units_1st_sem_approved
# curricular_units_2nd_sem_enrolled + curricular_units_1st_sem_enrolled
# curricular_units_2nd_sem_credited + curricular_units_1st_sem_credited

# categorical eda

# distribution of gender
students_train |> 
  ggplot(aes(gender)) +
  geom_bar(color = "black", fill = "orchid") +
  theme_minimal()

# target by gender
students_train |> 
  ggplot(aes(x = target, fill = gender)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by marital status
students_train |> 
  ggplot(aes(x = marital_status, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()




