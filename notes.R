# notes

#for FP, pick a baseline model, then run complex models and compare to the baseline 

# in a bare minimum basic recipe, we need to step_zv, step_dummy, step_remove if needed, step_impute (remove missing values), step_normalize (NOT IN THIS ORDER)
# kitchen sink is all of this plus all the variables thrown in (.)

# naive bayes, bare min recipe is everything but not step_dummy

# put it into a fit resample, not tune grid since there is nothing to tune