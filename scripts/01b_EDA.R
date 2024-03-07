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

# eda data

eda_students_split <- students_train |> 
  initial_split(prop = 0.8, strata = target)

eda_eda_students_train <- eda_students_split |> training()
eda_students_test <- eda_students_split |> testing()


# eda on target variable
eda_eda_students_train |> 
  ggplot(aes(x = target)) +
  geom_bar(fill = "pink2",color = "black") +
  theme_minimal()

# correlation eda ---------------------------------------------------------
cor_matrix <- eda_students_train |> 
  select(where(is.numeric)) |> 
  cor()
ggcorrplot::ggcorrplot(cor_matrix)

# findings:

# potential inverse relationship
# unemployment rate + gdp
eda_students_train |> 
  ggplot(aes(x = unemployment_rate, y = gdp)) +
  geom_point() +
  theme_minimal()

# potential relationship
# curricular_units_2nd_sem_grade + curricular_units_1st_sem_approved
eda_students_train |> 
  ggplot(aes(x = curricular_units_1st_sem_approved, y = curricular_units_2nd_sem_grade)) +
  geom_jitter(width = 0.1, height = 0.1) +
  theme_minimal()
# use model1 <- lm(), model2 <- lm()
# anova()
# would be ok to use corr plot evidence and then investigate variables based on intuition

# curricular_units_2nd_sem_enrolled + curricular_units_1st_sem_enrolled
eda_students_train |> 
  ggplot(aes(x = curricular_units_1st_sem_enrolled, y = curricular_units_2nd_sem_enrolled)) +
  geom_jitter(width = 0.1, height = 0.1) +
  theme_minimal()

# curricular_units_2nd_sem_credited + curricular_units_1st_sem_credited
eda_students_train |> 
  ggplot(aes(x = curricular_units_1st_sem_credited, y = curricular_units_2nd_sem_credited)) +
  geom_jitter(width = 0.1, height = 0.1) +
  theme_minimal()

# numeric eda w target ----------------------------------------------------

# eda_students_train |> 
#   ggplot(aes(x = curricular_units_1st_sem_approved, fill = target)) +
#   geom_density(alpha = 0.2) +
#   theme_minimal()

eda_students_train |> 
  ggplot(aes(x = curricular_units_1st_sem_credited, fill = target)) +
  geom_density(alpha = 0.2) +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = curricular_units_1st_sem_enrolled, fill = target)) +
  geom_boxplot() +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = curricular_units_1st_sem_evaluations, fill = target)) +
  geom_boxplot() +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = curricular_units_1st_sem_approved, fill = target)) +
  geom_boxplot() +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = curricular_units_1st_sem_grade, fill = target)) +
  geom_density(alpha = 0.2) +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = curricular_units_2nd_sem_credited, fill = target)) +
  geom_density(alpha = 0.2) +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = curricular_units_2nd_sem_enrolled, fill = target)) +
  geom_boxplot() +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = curricular_units_2nd_sem_evaluations, fill = target)) +
  geom_boxplot() +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = curricular_units_2nd_sem_approved, fill = target)) +
  geom_boxplot() +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = curricular_units_2nd_sem_grade, fill = target)) +
  geom_density(alpha = 0.2) +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = curricular_units_2nd_sem_credited, fill = target)) +
  geom_density(alpha = 0.2) +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = unemployment_rate, fill = target)) +
  geom_boxplot() +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = inflation_rate, fill = target)) +
  geom_boxplot() +
  theme_minimal()

eda_students_train |> 
  ggplot(aes(x = gdp, fill = target)) +
  geom_boxplot() +
  theme_minimal()

# categorical eda w target ------------------------------------------------
# target by marital status
eda_students_train |> 
  ggplot(aes(x = marital_status, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by application_mode
eda_students_train |> 
  ggplot(aes(x = application_mode, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by application_order
eda_students_train |> 
  ggplot(aes(x = application_order, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by course
eda_students_train |> 
  ggplot(aes(x = course, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by daytime_evening_attendance
eda_students_train |> 
  ggplot(aes(x = daytime_evening_attendance, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by previous_qualification
eda_students_train |> 
  ggplot(aes(x = previous_qualification, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by displaced
eda_students_train |> 
  ggplot(aes(x = displaced, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by educational_special_needs
eda_students_train |> 
  ggplot(aes(x = educational_special_needs, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by debtor
eda_students_train |> 
  ggplot(aes(x = debtor, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by tuition_fees_up_to_date
eda_students_train |> 
  ggplot(aes(x = tuition_fees_up_to_date, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# distribution of gender
eda_students_train |> 
  ggplot(aes(gender)) +
  geom_bar(color = "black", fill = "orchid") +
  theme_minimal()

# target by gender
eda_students_train |> 
  ggplot(aes(x = gender, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by scholarship_holder
eda_students_train |> 
  ggplot(aes(x = scholarship_holder, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by age_at_enrollment
eda_students_train |> 
  ggplot(aes(x = target, y = age_at_enrollment)) +
  geom_boxplot() +
  theme_minimal()

# target by international
eda_students_train |> 
  ggplot(aes(x = international, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by continent
eda_students_train |> 
  ggplot(aes(x = continent, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()
