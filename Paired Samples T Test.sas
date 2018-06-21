data m1;
input Location@@; datalines;
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
; run;

data m2; input Before@@; datalines; 
10.02 10.16 9.96 10.01 9.87 10.05 10.07 10.08 10.05 10.04 10.09 10.09 9.92 10.05 10.13
; run;

 data m3; input After@@; datalines;
10.21 10.16 10.11 10.10 10.07 10.13 10.08 10.30 10.17 10.10 10.06 10.37 10.24 10.19 10.13
;
run;

data mine; 
merge m1 m2 m3; 
run;

title "Paired t-test";
proc ttest data=mine alpha=0.01 CI=equal; *h0=0.1 to specify amt of diff;
paired After*Before;
run;

*Test for Normality;

data mine; set mine;
difference=After-Before;
run;

* all the test needs to check for normality;
proc univariate data=mine normal plot;
var difference;
run;
