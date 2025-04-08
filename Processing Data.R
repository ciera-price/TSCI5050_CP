#'---
#' title: "TSCI 5050: Processing a Data Set"
#' author: 'Ciera Price'
#' abstract: |
#'  | Provide a summary of objectives, study design, setting, participants,
#'  | sample size, predictors, outcome, statistical analysis, results,
#'  | and conclusions.
#' documentclass: article
#' description: 'Manuscript'
#' clean: false
#' self_contained: true
#' number_sections: false
#' keep_md: true
#' fig_caption: true
#' output:
#'  html_document:
#'    toc: true
#'    toc_float: true
#'    code_folding: show
#' ---
#'
#+ init, echo=FALSE, message=FALSE, warning=FALSE
# init ---- 
# 
debug <- 0;nrows <-200;seed <-22;

knitr::opts_chunk$set(echo=debug>-1, warning=debug>0, message=debug>0, class.output="scroll-20", attr.output='style="max-height: 150px; overflow-y: auto;"');

library(ggplot2); # visualisation
library(GGally);
library(rio);# simple command for importing and exporting
library(pander); # format tables
#library(printr); # set limit on number of lines printed
library(broom); # allows to give clean dataset
library(dplyr); #add dplyr library

options(max.print=500);
panderOptions('table.split.table',Inf); panderOptions('table.split.cells',Inf);
prob_missing=c(.99,.01) #The c function combines individual values into a vector.

#Read in the data from Simulated Data and create a plot
#Import Data ----
datafile1 <- "Data/Simulated Data.xlsx"
simdat <- import(datafile1) %>% mutate(train=sample(c(TRUE,FALSE),n(),replace = TRUE))
#simdat <- mutate(simdat,train=sample(c(TRUE,FALSE),n(),replace = TRUE))

#Scatter Plot Matrix ----
select(simdat,!any_of(c("ID", "Specimen ID","PIN", "VISIT")))[,50:52] %>% ggpairs


# #Group and plot data Example
# set.seed(1)
# sample_df <- data.frame(
#   group = factor(rep(letters[1:3], each = 10)),
#   value = rnorm(30))
# group_means_df <- setNames(
#   aggregate(value ~ group, sample_df, mean),
#   c("group", "group_mean"))
# ggplot(data = sample_df, mapping = aes(x = group, y = value)) +
#   geom_point() +
#   geom_point(
#     mapping = aes(y = group_mean), data = group_means_df,
#     colour = 'red', size = 3) 