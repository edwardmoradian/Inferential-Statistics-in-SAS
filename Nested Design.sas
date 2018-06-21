data nest;
do site = 1 to 2;
	do batch = 1 to 3;
		do tablet = 1 to 5;
			input y;
			output;
		end;
	end;
end;
datalines;
5.03
5.10
5.25
4.98
5.05
4.64
4.73
4.82
4.95
5.06
5.10
5.15
5.20
5.08
5.14
5.05
4.96
5.12
5.12
5.05
5.46
5.15
5.18
5.18
5.11
4.90
4.95
4.86
4.86
5.07
;

*3 different ways glm, glm, nested;

proc glm data=nest;
title "Mixed effect nested model, major effect is fixed, minor effect is random";
class site batch;
model y = site batch(site) /E1; *batch nested within site;
random batch(site) /test;
run;

*Comment:  The test H statement tells SAS how to run the F-test you want.  
*H refers to the numerator of the F-test (i.e. trt)
*E refers to the denominator of the F-test(error term);

proc glm data=nest;
class site batch; 
model y = site batch(site) /E1; *batch nested within site;
random batch(site); 
test H=site E=batch(site);
run;

/* proc glm;
class a b c d;
model y=a b(a) c(a b) d(a b c);

proc nested;
class a b c d;
var y;
*/

*proc nested shows variance component percentages;
proc nested data=nest;
title "Mixed effect nested model, major effect is fixed, minor effect is random";
class site batch; *site as major and batch as minor based on order entered = a b;
var y;
run;
quit;

*However, PROC NESTED assumes that the input data set is sorted by the classification (CLASS) variables defining the effects;
