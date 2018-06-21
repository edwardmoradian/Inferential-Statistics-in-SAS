data SAT;
input _stat_ $ value group $;
datalines;
n 91 comp
mean 484.45 comp
std 53.77 comp
n 91 conv
mean 487.38 conv
std 36.94 conv
;

title "Two-sample t-test";
proc ttest data=SAT; *check Folded F for equal variances;
class group;
var value;
run;
