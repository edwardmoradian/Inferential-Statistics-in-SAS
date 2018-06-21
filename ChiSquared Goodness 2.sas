data genetics;
input type:$12. count;
datalines;
TallCut 926
DwarfCut 293
TallPotato 288
DwarfPotato 104
;
run;

title "Chi-Square Goodness of Fit";
proc freq data=genetics order=data;
weight count;
tables type /nocum chisq testp=(56.25 18.75 18.75 06.25);
run;
