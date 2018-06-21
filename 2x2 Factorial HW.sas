data tv;
input product $ age $ outcome @@;
datalines;
P1	A1	19	P1	A2	19	P1	A3	37
P1	A1	36	P1	A2	35	P1	A3	6
P1	A1	40	P1	A2	22	P1	A3	28
P1	A1	30	P1	A2	28	P1	A3	4
P1	A1	4	P1	A2	1	P1	A3	32
P1	A1	10	P1	A2	27	P1	A3	16
P1	A1	30	P1	A2	27	P1	A3	8
P1	A1	5	P1	A2	16	P1	A3	41
P1	A1	34	P1	A2	3	P1	A3	29
P1	A1	21	P1	A2	18	P1	A3	18
P2	A1	39	P2	A2	30	P2	A3	51
P2	A1	18	P2	A2	47	P2	A3	52
P2	A1	32	P2	A2	6	P2	A3	43
P2	A1	22	P2	A2	27	P2	A3	48
P2	A1	16	P2	A2	44	P2	A3	39
P2	A1	2	P2	A2	26	P2	A3	33
P2	A1	36	P2	A2	33	P2	A3	56
P2	A1	43	P2	A2	48	P2	A3	43
P2	A1	7	P2	A2	23	P2	A3	40
P2	A1	16	P2	A2	21	P2	A3	51
;

proc glm data=tv;
class age product;
model outcome=age product age*product /solution;
output out=resids r=res p=yhat;
run;
quit;

*Test for constant variances with residual plot;
proc gplot data=resids;
plot res*yhat;
run;

*Check for normality condition;
proc univariate normal plot;
var res;
run;

