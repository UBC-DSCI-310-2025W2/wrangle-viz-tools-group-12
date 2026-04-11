
<!-- README.md is generated from README.Rmd. Please edit that file -->

# WrangleVizTools

<!-- badges: start -->

[![R-CMD-check](https://github.com/UBC-DSCI-310-2025W2/wrangle-viz-tools-group-12/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/UBC-DSCI-310-2025W2/wrangle-viz-tools-group-12/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## Authors:
Andy Xin </br>
Aryan Shah </br>
Lucas Ortiz Molina </br>
Taehyun Kim </br>

## About
WrangleVizTools is an R package designed to support data wrangling and visualization workflows for income classification tasks. It was developed as part of a salary income analysis project using the UCI Adult Census dataset (https://archive-beta.ics.uci.edu/dataset/2/adult), where the goal is to predict whether an individual earns ≤$50K or >$50K per year. The project can be found in https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-12. 

At a high level, the package provides utility functions to wrangle, train, and visualize data, making it easier to prepare datasets for modeling and exploratory analysis. It is especially useful for reproducible data science pipelines where consistent preprocessing and standardized visualizations are required.

Within the R ecosystem, WrangleVizTools sits as a lightweight, task-specific extension that complements established packages in the tidyverse (e.g., data manipulation and visualization tools). Rather than replacing these widely used libraries, it builds on top of them by offering tailored helper functions for common wrangling and plotting steps used in classification problems. It allows users to implament commonly used code efficiently without writting long lines of code.
## Installation

You can install the development version of WrangleVizTools from
[GitHub](https://github.com/) using:

``` r
# install.packages("pak")
pak::pak("UBC-DSCI-310-2025W2/wrangle-viz-tools-group-12")
```
or if using termnial use:
```bash
Rscript -e 'pak::pak("UBC-DSCI-310-2025W2/wrangle-viz-tools-group-12")'
```
## Usage

Once the package is installed, load it with:
``` r
library(WrangleVizTools)
```

## Package functions:
This package includes the following functions found in the R folder which are: 

- `create_confusion_matrix_plot`, generates a confusion matrix plot
- `make_dummy_col`, wrangles dataframe by making a column into dummy variables 
- `plot_correlation_heatmap`, generates a correlation heatmap
- `train_logistic_model`, trains a logistic regression model using a given dataset and a formula

These functions support various steps used in the workflow.

## License 

This project is distributed under the following license:

MIT License (see LICENSE.md for full details)
