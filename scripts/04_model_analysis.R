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
load(here("results/null_fit_2.rda"))

load(here("results/logistic_fit.rda"))
load(here("results/logistic_fit_2.rda"))

load(here("results/bt_tuned.rda"))
load(here("results/bt_tuned_2.rda"))

load(here("results/en_tuned.rda"))
load(here("results/en_tuned_2.rda"))

load(here("results/knn_tuned.rda"))
load(here("results/knn_tuned_2.rda"))

load(here("results/rf_tuned.rda"))
load(here("results/rf_tuned_2.rda"))

# set seed
set.seed(847)

# ROC AUC METRICS
tbl_null <- null_fit |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Null Fit")

tbl_null_2 <- null_fit_2 |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Null Fit 2")

tbl_lm <- logistic_fit |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Linear")

tbl_lm_2 <- logistic_fit_2 |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Linear 2")

tbl_en <- en_tuned |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Elastic Net")

tbl_en_2 <- en_tuned_2 |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Elastic Net 2")

tbl_rf <- rf_tuned |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Random Forest")

tbl_rf_2 <- rf_tuned_2 |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Random Forest 2")

tbl_bt <- bt_tuned |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Boosted Tree")

tbl_bt_2 <- bt_tuned_2 |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Boosted Tree 2")

tbl_knn <- knn_tuned |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "K-nearest Neighbor")

tbl_knn_2 <- knn_tuned_2 |> 
  show_best("roc_auc") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "K-nearest Neighbor 2")

result_table_roc_auc <- bind_rows(tbl_lm, tbl_bt, tbl_en, tbl_knn, tbl_null, tbl_rf, tbl_knn_2, tbl_lm_2, tbl_bt_2, tbl_en_2, tbl_null_2, tbl_rf_2) |> 
  select(model, mean, std_err, n) |> 
  arrange(mean)
result_table_roc_auc

# ACCURACY METRICS
tbl_null_accuracy <- null_fit |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Null Fit")

tbl_null_2_accuracy <- null_fit_2 |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Null Fit 2")

tbl_lm_accuracy <- logistic_fit |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Linear")

tbl_lm_2_accuracy <- logistic_fit_2 |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Linear 2")

tbl_en_accuracy <- en_tuned |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Elastic Net")

tbl_en_2_accuracy <- en_tuned_2 |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Elastic Net 2")

tbl_rf_accuracy <- rf_tuned |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Random Forest")

tbl_rf_2_accuracy <- rf_tuned_2 |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Random Forest 2")

tbl_bt_accuracy <- bt_tuned |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Boosted Tree")

tbl_bt_2_accuracy <- bt_tuned_2 |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "Boosted Tree 2")

tbl_knn_accuracy <- knn_tuned |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "K-nearest Neighbor")

tbl_knn_2_accuracy <- knn_tuned_2 |> 
  show_best("accuracy") |> 
  slice_max(mean) |> 
  select(mean, n, std_err) |> 
  mutate(model = "K-nearest Neighbor 2")

result_table_accuracy <- bind_rows(tbl_lm_accuracy, tbl_bt_accuracy, tbl_en_accuracy, tbl_knn_accuracy, tbl_null_accuracy, tbl_rf_accuracy, tbl_knn_2_accuracy, tbl_lm_2_accuracy, tbl_bt_2_accuracy, tbl_en_2_accuracy, tbl_null_2_accuracy, tbl_rf_2_accuracy) |> 
  select(model, mean, std_err, n) |> 
  arrange(mean)
result_table_accuracy

save(result_table_roc_auc, result_table_accuracy, file = here("results/metrics.rda"))

# CHECKING BEST METRICS VIA AUTOPLOT
bt_autoplot <- autoplot(bt_tuned, metric = "accuracy")
bt_autoplot
en_autoplot <- autoplot(en_tuned, metric = "accuracy")
en_autoplot
knn_autoplot <- autoplot(knn_tuned, metric = "accuracy")
knn_autoplot
rf_autoplot <- autoplot(rf_tuned, metric = "accuracy")
rf_autoplot

save(bt_autoplot, en_autoplot, knn_autoplot, rf_autoplot, file = here("results/autoplots.rda"))