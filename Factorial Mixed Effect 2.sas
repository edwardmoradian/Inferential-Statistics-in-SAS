data ants;
input location $ chemical $ numkilled;
datalines;
1	1	7.2
1	1	9.6
2	1	8.5
2	1	9.6
3	1	9.1
3	1	8.6
4	1	8.2
4	1	9.0
5	1	7.8
5	1	8.0
1	2	4.2
1	2	3.5
2	2	2.9
2	2	3.3
3	2	1.8
3	2	2.4
4	2	3.6
4	2	4.4
5	2	3.7
5	2	3.9
1	3	9.5
1	3	9.3
2	3	8.8
2	3	9.2
3	3	7.6
3	3	7.1
4	3	7.3
4	3	7.0
5	3	9.2
5	3	8.3
1	4	5.4
1	4	3.9
2	4	6.3
2	4	6.0
3	4	6.1
3	4	5.6
4	4	5.0
4	4	5.4
5	4	6.5
5	4	6.9
;

proc glm;
	title "Mixed Effect Model";
	class chemical location;
	model numkilled = chemical|location / solution;
	random location chemical*location /test ; *SAS computes for mixed effect not all divided by MSE, correct F values;
	output out=resids r=res p=yhat;
run;
quit;

*Test for constant variances with residual plot;
proc gplot data=resids;
plot res*yhat;
run;

*Check for normality condition;
Proc Univariate normal plot;
var res; 
run;

proc mixed data=ants;
    class chemical location;
*only fixed effect shows up at model statement;
    model numkilled = chemical;
    random location chemical*location;
run;
quit;

Proc varcomp method=reml data=ants;
class chemical location;
Model numkilled = chemical|location /fixed=1;
Run;


