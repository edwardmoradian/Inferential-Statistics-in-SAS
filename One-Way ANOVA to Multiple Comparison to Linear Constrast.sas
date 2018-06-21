data one;
input student control piano computer instructor;
datalines;
1     -3.4  -0.2  7.7   12
2     -2.8  5.2   5.5   4.1
3     2.2   6.6   -0.8  5.9
4     -0.8  5.2   7.4   13.5
5     2.8   -0.6  0.1   7.5
6     -5.9  5.4   11.7  9.3
7     7.8   3.1   1.2   7.1
8     -3.5  6.5   3.8   -0.9
9     2.9   2.4   5.1   8.3
10    1.9   6.2   4.3   9.8
11    -0.2  7.9   3.9   11.1
12    1.5   7.9   6.9   4.9
13    0.4   6.6   2.8   5.8
14    -0.5  0.2   5.4   2.8
15    1.1   1.9   2.5   12
16    5.3   1.3   5.2   8.6
17    -4    1.8   3.1   2
18    -1.3  3.1   6.6   5.9
19    2.6   1.4   0.2   5.6
20    -0.9  2.1   7.1   11.6
21    -0.6  6.6   9.2   7.8
22    -5    7     3     7.2
23    2.4   -0.7  2.3   8.3
24    -0.1  4.1   10.2  6.5
25    -4.7  3.8   4.7   8.3
;

/*changing from unstacked data to stacked*/

data two; set one;
length treatment $12;
treatment="control"; score=control; output;
treatment="piano"; score=piano; output;
treatment="computer"; score=computer; output;
treatment="instructor"; score=instructor; output;
keep student treatment score;
run;

proc glm data=two;
	class treatment;
	model score=treatment;
	means treatment / hovtest=levene;
	/* Performs the Levene test for the factor A */
	output out=resids r=res;
run;
quit;

proc univariate normal plot;
/* Tells SAS to run tests of normality and gives a QQ Plot */
var res;
run;

proc anova data=two;
class treatment;
model score=treatment;
means treatment / lsd;
means treatment / tukey;
means treatment / lsd tukey cldiff;
/* The CLDIFF option requests confidence intervals for both tests */
run;

/*Linear Contrast Statement*/
Proc glm data=two;
class treatment;
model score=treatment;
ESTIMATE "Computer vs Piano"
treatment 1 0 0 -1;
ESTIMATE "Instructor vs Control"
treatment 0 -1 1 0;
ESTIMATE "All three methods vs control"
treatment 1 -3 1 1;
run;
