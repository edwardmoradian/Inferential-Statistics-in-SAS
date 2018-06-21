data paint;
input color:$2. score1-score4 @@;
datalines;
P1 28 35 27 21
P2 21 36 25	18
P3 26 38 27 17
P4 16 25 22 18
;
run;

proc transpose data=paint out=paint2 (rename=(COL1=score) drop=_name_);
by color;
var score1-score4;
run;

proc glm data=paint2;
	class color;
	model score=color;
	means color / hovtest=levene;
	/* Performs the Levene test for the factor A */
	output out=resids r=res;
run;
quit;

proc univariate normal plot;
/* Tells SAS to run tests of normality and gives */
var res;
run;

proc anova data=paint2;
class color;
model score=color;
means color / lsd;
means color / tukey;
means color / lsd tukey cldiff;
/* The CLDIFF option requests confidence intervals for both tests */
run;
