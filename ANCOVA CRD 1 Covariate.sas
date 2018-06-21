data health;
infile datalines dsd;
input patient $ trt $ risk cig;
datalines;
1,'C',22,0
2,'C',26,2
3,'C',49,6
4,'C',67,8
5,'C',72,12
6,'C',19,0
7,'C',28,2
8,'C',97,20
9,'C',88,18
10,'C',30,3
11,'1',7,0
12,'1',9,0
13,'1',14,3
14,'1',18,4
15,'1',30,7
16,'1',42,9
17,'1',50,12
18,'1',54,13
19,'1',70,17
20,'1',82,25
21,'2',12,0
22,'2',14,0
23,'2',17,2
24,'2',29,5
25,'2',37,7
26,'2',45,9
27,'2',53,11
28,'2',81,18
29,'2',93,21
30,'2',94,23
;
run;

proc plot data=health;
plot risk*cig=trt;
run;
quit;

proc glm; *Should the model be B1 or Bi? Y and covariate have equal slopes? Check the interaction p-value for the covariate and factors;
title "Test for homogeneity of slopes";
class trt;
model risk = trt cig trt*cig;
run;

proc glm data=health order=data; *ANCOVA;
	class trt;
	model risk=trt cig;
run;
quit;

* To obtain parameter estimates, add the solution option to the Model statement;
proc glm data=health;
class trt;
model risk=trt cig/solution;
run;

* Check for the model assumption -normality;
proc glm data=health;
class trt;
model risk=trt cig;
output out=healthM p=predict r=resid;
run;
quit;
Proc Univariate Data = healthM normal;
Var resid; run;

proc means data=health; var cig; run;

data health; set health; *parameter mean estimate for cig (covariate) and mean for cig (covariate) using means proc;
risk_adj = risk - 3.62352665*(cig-8.57);run;

proc means data=health; var risk; run;

Proc GLM data=health;
Title 'Homogeneity of variances';
Class trt;
Model risk_adj = trt;
Means trt / hovtest = Levene; 
run; quit;
