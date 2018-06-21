data paint;
input color $ score @@;
datalines;
P1 28 P1 35 P1 27 P1 21
P2 21 P2 36 P2 25 P2 18
P3 26 P3 38 P3 27 P3 17	
P4 16 P4 25 P4 22 P4 18
;

proc glm data=paint;
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

proc anova data=paint;
class color;
model score=color;
means color / lsd;
means color / tukey;
means color / lsd tukey cldiff;
/* The CLDIFF option requests confidence intervals for both tests */
run;
