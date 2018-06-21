data drug;
input sequence $ patient $ period $ response;
treatment = mod(sequence+period-2,3)+1;
datalines;
1 1	1 80.2
1 2	1 79.1
1 3	1 108.4
1 4	1 41.2
1 5	1 72.7
1 1	2 40.4
1 2	2 38.5
1 3	2 78.3
1 4	2 38.2
1 5	2 58.5
1 1	3 38.4
1 2	3 36.1
1 3	3 56.5
1 4	3 26.2
1 5	3 36.3
2 1	1 74.6
2 2	1 125.3
2 3	1 145.5
2 4	1 86.7
2 5	1 107.8
2 1	2 51.2
2 2	2 100.5
2 3	2 108.5
2 4	2 68.8
2 5	2 78.5
2 1	3 48.6
2 2	3 86.4
2 3	3 96.4
2 4	3 58.2
2 5	3 53.1
3 1	1 79.7
3 2	1 89.2
3 3	1 99.1
3 4	1 102.4
3 5	1 109.3
3 1	2 40.4
3 2	2 68.8
3 3	2 76.5
3 4	2 88.1
3 5	2 98.5
3 1	3 37.2
3 2	3 56.2
3 3	3 43.9
3 4	3 53.4
3 5	3 76.8
;
run;

data drug2; 
set drug;
carryover="0 ";
if period=2 and sequence=1 then carryover="T1";
if period=3 and sequence=1 then carryover="T2";
if period=2 and sequence=2 then carryover="T2";
if period=3 and sequence=2 then carryover="T3";
if period=2 and sequence=3 then carryover="T3";
if period=3 and sequence=3 then carryover="T1";
run;

proc sort data = drug2 out = drug3;
by sequence period;
run;

proc means data = drug3 noprint;
var response;
by sequence period;
output out = crossovermeans2 mean = means;
run;


symbol1 interpol = join value = dot;
proc gplot data = crossovermeans2;
plot means * period = sequence;
run;

proc glm data=drug2;
class sequence patient period treatment carryover;
model response = sequence patient(sequence) treatment period carryover;
random patient(sequence) /test;
run;

proc glm data=drug2;
class sequence patient period treatment;
model response=sequence patient(sequence) treatment period;
random patient(sequence) /test;
run;

data drug3;
	set drug2;
	where period = "1";
run;

proc glm data=drug3;
	class treatment;
	model response=treatment;
	means treatment / hovtest=levene;
	/* Performs the Levene test for the factor A */
	output out=resids r=res;
run;
quit;

proc univariate normal plot;
/* Tells SAS to run tests of normality and gives */
var res;
run;

proc anova data=drug3;
class treatment;
model response=treatment;
means treatment / tukey;
means treatment / tukey cldiff;
/* The CLDIFF option requests confidence intervals for both tests */
run;

