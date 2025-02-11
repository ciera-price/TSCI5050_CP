#'---
#' title: "TSCI 5050: Simulating a Data Set"
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
whatisthis <- function(xx){
  list(class=class(xx),info=c(mode=mode(xx),storage.mode=storage.mode(xx)
                              ,typeof=typeof(xx)))};
# Import Data ----
datafile0 <- "Data/R test data.xlsx"
Dat0 <- import(datafile0)
Dat0[1,] #Take the 1st row of the data set
Dat0[1,2] #Row 1, Col 2
Dat0[1,2:5] #Row 1, Cols 2 through 5
Dat0[1,c(2,5)] #Row 1, Cols 2 and 5 #C command is helpful for nonsequential numbers
Dat0[c(1,1),]#Row 1 twice, All Cols
Dat0[rep(1,6),] #Row 1, repeated 6 times, All Cols 
#Rep command is helpful for repeating large amounts of data as the c command must be manually input

set.seed(seed) #Use this func to replicate the same vector of random numbers; seed was defined on line 25
rnorm(nrows, mean=900, sd=250) #Create a single column vector of random values; nrows was defined on line 25

Dat1 <- Dat0[rep(1,nrows),];#Create a new variable from Dat ) with row 1 repeated nrows times for all columns
mutate(Dat1, `CD4 ABS`=12) #Modify Dat 1 by replacing all values in column in CD4 ABS with '12'
Dat1 <-mutate(Dat1, `CD4 ABS`=rnorm(n(), mean=900, sd=250)); #Redefine Dat1 by replacing the values in CD4 ABS with random values
#n() represents the number of rows in the current block of data

Dat1 <-mutate(Dat1
              , ID= sprintf("EX-%04d",sample(1:1000,n())) # Zero pad to 4 places with prefix 'EX-'
              , `CD4 ABS`=round(rnorm(n(), mean=900, sd=250))
              , WBC=rnorm(n(), mean=4.9, sd=.26)
              , RBC=rnorm(n(), mean=8.7, sd=.24)
              )


#sprintf("name=%s, age=%d, percentile=%% %f", "Ciera", 30, 98.5)
# s = string, d = integer, f = fraction
