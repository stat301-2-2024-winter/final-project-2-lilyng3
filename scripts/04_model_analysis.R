# Final Project - Model Analysis
# Analyze model results

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("data_splits/students_split.rda"))
load(here("results/null_fit.rda"))
load(here("results/logistic_fit.rda"))

load(here("results/bt_tuned.rda"))
load(here("results/en_tuned.rda"))
load(here("results/knn_tuned.rda"))
load(here("results/rf_tuned.rda"))

# set seed
set.seed(847)

null_predict <- collect_metrics(null_fit) |> 
  mutate(model = "null") |> 
  select(model, .metric, mean, std_err, n)
null_predict

logistic_predict <- collect_metrics(logistic_fit) |> 
  mutate(model = "logistic") |> 
  select(model, .metric, mean, std_err, n)
logistic_predict

tbl_null <- null_fit |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Null Fit")

tbl_lm <- logistic_fit |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Linear")

tbl_en <- en_tuned |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Elastic Net")

tbl_rf <- rf_tuned |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Random Forest")

tbl_bt <- bt_tuned |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Boosted Tree")

tbl_knn <- knn_tuned |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "K-nearest Neighbor")

result_table <- bind_rows(tbl_lm, tbl_bt, tbl_en, tbl_knn, tbl_null, tbl_rf) |> 
  select(model, mean, std_err, n) |> 
  arrange(mean)
result_table

# combined_table <- bind_rows(null_predict, logistic_predict) |> 
#   knitr::kable()
# combined_table

