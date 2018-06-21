Data mileage;
Input Driver	Model	Blend$	MPG;
datalines;
1	1	A	15.5
2	1	B	16.3
3	1	C	10.5
4	1	D	14
1	2	B	33.8
2	2	C	26.4
3	2	D	31.5
4	2	A	34.5
1	3	C	13.7
2	3	D	19.1
3	3	A	17.5
4	3	B	19.7
1	4	D	29.2
2	4	A	22.5
3	4	B	30.1
4	4	C	21.6
;
run;
Proc glm data=mileage;
Class Driver	Model	Blend;
Model MPG=Driver	Model	Blend;
output out=resids r=res;
Run;
Quit;

proc univariate normal plot;
/* Tells SAS to run tests of normality and give a QQ-plot */
var res;
run;

/*HOVTEST=BARTLETT -  specifies Bartlett test, 1937/likelihood ratio test || one way ANOVA only*/
Proc glm data=mileage;
Class Blend;
Model MPG=Blend;
means Blend/ hovtest=levene; 
output out=resids r=res;
Run;
Quit;

