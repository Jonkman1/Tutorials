﻿* Encoding: UTF-8.
***********************************************************************
* Bayesian T-test in SPSS
* Lion Behrens, Naomi Schalken and Rens van de Schoot 
* Syntax file
***********************************************************************

* Loading in data (fill in your working directory).
GET DATA  /TYPE=TXT 
  /FILE="C:\your working directory\phd-delays.csv"    
  /DELCASE=LINE 
  /DELIMITERS=";" 
  /ARRANGEMENT=DELIMITED 
  /FIRSTCASE=2 
  /DATATYPEMIN PERCENTAGE=95.0 
  /VARIABLES= 
  B3_difference_extra AUTO 
  E4_having_child AUTO 
  E21_sex AUTO 
  E22_Age AUTO 
  E22_Age_Squared AUTO 
  /MAP. 
RESTORE. 
CACHE. 
EXECUTE.

* Descriptive Statistics. 
EXAMINE VARIABLES=B3_difference_extra E4_having_child
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

* Bayesian T-test. 
BAYES INDEPENDENT
  /MISSING SCOPE=ANALYSIS
  /CRITERIA CILEVEL=95 TOL=0.000001 MAXITER=2000
  /INFERENCE DISTRIBUTION=NORMAL VARIABLES=B3_difference_extra ANALYSIS=BOTH GROUP=E4_having_child
    SELECT=LEVEL(0 1)
  /PRIOR EQUALDATAVAR=FALSE VARDIST=DIFFUSE
  /ESTBF COMPUTATION=ROUDER.

* Bayesian t-test prior 1.
BAYES INDEPENDENT
  /MISSING SCOPE=ANALYSIS
  /CRITERIA CILEVEL=95 TOL=0.000001 MAXITER=2000
  /INFERENCE DISTRIBUTION=NORMAL VARIABLES=B3_difference_extra ANALYSIS=BOTH GROUP=E4_having_child 
    SELECT=LEVEL(0 1) DATAVAR=193.5 265.7
  /PRIOR EQUALDATAVAR=FALSE MEANDIST=NORMAL(9 14 13 16)
  /ESTBF COMPUTATION=ROUDER.

* Bayesian t-test prior 2.
BAYES INDEPENDENT
  /MISSING SCOPE=ANALYSIS
  /CRITERIA CILEVEL=95 TOL=0.000001 MAXITER=2000
  /INFERENCE DISTRIBUTION=NORMAL VARIABLES=B3_difference_extra ANALYSIS=BOTH GROUP=E4_having_child 
    SELECT=LEVEL(0 1) DATAVAR=193.5 265.7
  /PRIOR EQUALDATAVAR=FALSE MEANDIST=NORMAL(20 5 2 5)
  /ESTBF COMPUTATION=ROUDER.
