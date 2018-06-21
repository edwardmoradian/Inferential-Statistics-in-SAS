data paint;
input color:$2. section1-section4 @@;
datalines;
P1 28 35 27 21
P2 21 36 25	18
P3 26 38 27 17
P4 16 25 22 18
;
run;

data paint2; set paint;
length treatment $10;
treatment="section1"; outcome=section1; output;
treatment="section2"; outcome=section2; output;
treatment="section3"; outcome=section3; output;
treatment="section4"; outcome=section4; output;
keep color treatment outcome;
run;

proc glm data=paint2;
	class color;
	model outcome=color;
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
model outcome=color;
means color / lsd;
means color / tukey;
means color / lsd tukey cldiff;
/* The CLDIFF option requests confidence intervals for both tests */
run;
