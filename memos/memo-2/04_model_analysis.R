# Progress Memo 2 - model analysis
# Analyze model results

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("memos/memo-2/results/students_split.rda"))
load(here("memos/memo-2/results/null_fit.rda"))
load(here("memos/memo-2/results/logistic_fit.rda"))

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

combined_table <- bind_rows(null_predict, logistic_predict) |> 
  knitr::kable()
combined_table

