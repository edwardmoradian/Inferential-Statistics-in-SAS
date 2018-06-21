data lab;
infile datalines dsd;
input Devise $ Sample Response;
datalines;
'A',1,-0.307
'A',2,-0.294
'A',3,0.079
'A',4,0.019
'A',5,-0.136
'A',6,-0.324
'B',1,-0.176
'B',2,0.125
'B',3,-0.013
'B',4,0.082
'B',5,0.091
'B',6,0.459
'C',1,0.137
'C',2,-0.063
'C',3,0.24
'C',4,-0.05
'C',5,0.318
'C',6,0.154
'D',1,-0.042
'D',2,0.69
'D',3,0.201
'D',4,0.166
'D',5,0.219
'D',6,0.407
;

proc glm data=lab;
class Devise;
model Response = Devise;
means Devise/hovtest=levene;
output   out=out  r=resid;
run;

*Check for normality;
proc univariate data=out plot normal;
   var resid;
run;
