# Final Project - EDA
# EDA on the training data after split

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(RColorBrewer)

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("data_splits/students_split.rda"))

# set seed
set.seed(847)

# eda data

eda_students_split <- students_train |> 
  initial_split(prop = 0.8, strata = target)

eda_students_train <- eda_students_split |> training()
eda_students_test <- eda_students_split |> testing()

# eda on target variable
eda_students_train |> 
  ggplot(aes(x = target)) +
  geom_bar(fill = "pink2",color = "black") +
  theme_minimal()

# correlation eda ---------------------------------------------------------
cor_matrix <- eda_students_train |> 
  select(where(is.numeric)) |> 
  cor()

colnames(cor_matrix) <- gsub("_", " ", colnames(cor_matrix))
rownames(cor_matrix) <- gsub("_", " ", rownames(cor_matrix))

cor_plot <- ggcorrplot::ggcorrplot(cor_matrix) +
  theme(axis.text.x = element_text(size = 8), 
        axis.text.y = element_text(size = 8)) +
  labs(title = "Correlation Matrix Between Numeric Variables")


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
  geom_point() +
  theme_minimal()
# use model1 <- lm(), model2 <- lm()
# anova()
# would be ok to use corr plot evidence and then investigate variables based on intuition

# curricular_units_2nd_sem_enrolled + curricular_units_1st_sem_enrolled
interact_enrolled_plot <- eda_students_train |> 
  ggplot(aes(x = curricular_units_1st_sem_enrolled, y = curricular_units_2nd_sem_enrolled)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal() +
  labs(
      title = "Units Enrolled In For 1st & 2nd Semester",
      x = "Curricular Units Enrolled In For 1st Semester",
      y = "Curricular Units Enrolled In For 2nd Semester"
    )

# curricular_units_2nd_sem_credited + curricular_units_1st_sem_credited
interact_credited_plot <- eda_students_train |> 
  ggplot(aes(x = curricular_units_1st_sem_credited, y = curricular_units_2nd_sem_credited)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal() +
  labs(
    title = "Units Credited 1st & 2nd Semester",
    x = "Curricular Units Credited For 1st Semester",
    y = "Curricular Units Credited For 2nd Semester"
  )

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
married_plot <- eda_students_train |> 
  ggplot(aes(x = marital_status, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +  
  labs(
    title = "Maritial Status By Educational Outcome",
    x = "Maritial Status",
    y = "Number of Students",
    fill = "Educational Outcome"
  )

app_mode_plot <- eda_students_train |> 
  ggplot(aes(x = application_mode, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +
  labs(
    title = "Application Mode By Educational Outcome",
    x = "Application Mode",
    y = "Number of Students",
    fill = "Educational Outcome"
  )

# target by application_order
eda_students_train |> 
  ggplot(aes(x = application_order, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal()

# target by course
course_plot <- eda_students_train |> 
  ggplot(aes(x = course, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +
  labs(
    title = "Course By Educational Outcome",
    x = "Course",
    y = "Number of Students",
    fill = "Educational Outcome"
  )

# target by daytime_evening_attendance
time_plot <- eda_students_train |> 
  ggplot(aes(x = daytime_evening_attendance, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +
  labs(
    title = "Attendence Time of Day By Educational Outcome",
    x = "Time of Day",
    y = "Number of Students",
    fill = "Educational Outcome"
  )

# target by previous_qualification
qual_plot <- eda_students_train |> 
  ggplot(aes(x = previous_qualification, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +
  labs(
    title = "Previous Qualifications By Educational Outcome",
    x = "Previous Qualifications",
    y = "Number of Students",
    fill = "Educational Outcome"
  )

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
debt_plot <- eda_students_train |> 
  ggplot(aes(x = debtor, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +
  labs(
    title = "Debtor Status By Educational Outcome",
    x = "Debtor Status",
    y = "Number of Students",
    fill = "Educational Outcome"
  )

# target by tuition_fees_up_to_date
tuition_fees_plot <- eda_students_train |> 
  ggplot(aes(x = tuition_fees_up_to_date, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +
  labs(
    title = "Tuition Fees Up To Date By Educational Outcome",
    x = "Tuition Fees Up To Date Status",
    y = "Number of Students",
    fill = "Educational Outcome"
  )

# distribution of gender
gender_dist_plot <- eda_students_train |> 
  ggplot(aes(gender)) +
  geom_bar(color = "black", fill = "grey") +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +
  labs(
    title = "Distribution of Gender",
    x = "Gender",
    y = "Number of Students",
  )

# target by gender
gender_plot <- eda_students_train |> 
  ggplot(aes(x = gender, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +
  labs(
    title = "Gender By Educational Outcome",
    x = "Gender",
    y = "Number of Students",
    fill = "Educational Outcome"
  )

# target by scholarship_holder
scholarship_plot <- eda_students_train |> 
  ggplot(aes(x = scholarship_holder, fill = target)) +
  geom_bar(position = "dodge", color = "black") +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +
  labs(
    title = "Scholarship Holder By Educational Outcome",
    x = "Scholarship Holder Status",
    y = "Number of Students",
    fill = "Educational Outcome"
  )

# target by age_at_enrollment
age_plot <- eda_students_train |> 
  ggplot(aes(x = target, y = age_at_enrollment)) +
  geom_boxplot() +
  theme_minimal() +
  scale_fill_brewer(palette = "Paired") +
  labs(
    title = "Age At Enrollment By Educational Outcome",
    x = "Age At Enrollment",
    y = "Number of Students",
    fill = "Educational Outcome"
  )

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


save(cor_plot, interact_enrolled_plot, interact_credited_plot, age_plot, scholarship_plot, gender_plot, gender_dist_plot, tuition_fees_plot, debt_plot, qual_plot, time_plot, course_plot, app_mode_plot, married_plot, file = here("results/eda_plots.rda"))
