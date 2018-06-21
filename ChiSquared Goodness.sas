data disease;
input category $ Count;
datalines;
Marked 120
Moderate 60
Slightly 10
Stat 19
;
run;

proc freq data=disease;
tables category;
weight count; *grouped data - need to weight the count;
run;

proc freq data=disease;
tables category /nocum chisq testp=(50 25 10 15);
weight count;
run;
