data Before;
input Before@@;
datalines;
22.86 7.74 15.49 9.97 1.44 9.39 11.40 1.86 -6.71 6.42
; 
run;

data After;
input After@@;
datalines;
6.11 -4.02 8.04 3.29 -0.77 6.99 10.19 2.09 11.40 10.70
; 
run;

data total;
merge Before After; 
run;

proc ttest data=total alpha=0.05 CI=equal;
paired Before*After; 
run;

*Test for Normality;
data mine; 
set total;
difference=Before-After;
run;

*all the test needs to check for normality;
proc univariate data=mine normal plot alpha=.05;
var difference;
run;
