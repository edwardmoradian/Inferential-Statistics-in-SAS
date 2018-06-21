Title ’Comparing Group Means’;
data scores;
input Gender $ Score @@;
datalines;
f 75 f 76 f 80 f 77 f 80 f 77 f 73
m 82 m 80 m 85 m 85 m 78 m 87 m 82
;
run;

*$: in the INPUT statement indicates Gender is a character variable;
*@@ enable the procedure to read more than one observation per line;

title "Two sample t-test";
proc ttest data=scores; 
class Gender;
var Score;
run;

*Test for Normality;

data female; 
input Score@@; 
datalines; 
75 76 80 77 80 77 73
; run;

 data male; 
input Score@@; 
datalines;
82 80 85 85 78 87 82
;

*all the test needs to check for normality;
proc univariate data=female normal plot;
var Score;
run;

proc univariate data=male normal plot;
var Score;
run;
