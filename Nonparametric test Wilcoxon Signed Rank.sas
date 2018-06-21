data m1;
input Location@@; cards;
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
; run;

data m2; input Before@@; cards; 
10.02 10.16 9.96 10.01 9.87 10.05 10.07 10.08 10.05 10.04 10.09 10.09 9.92 10.05 10.13
; run;

 data m3; input After@@; cards;
10.21 10.16 10.11 10.10 10.07 10.13 10.08 10.30 10.17 10.10 10.06 10.37 10.24 10.19 10.13
;
run;
data mine; merge m1 m2 m3; run;

data mine; set mine;
difference=After-Before;
run;

proc univariate data=mine;
var difference;
run;


