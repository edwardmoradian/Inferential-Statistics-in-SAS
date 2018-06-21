data tablet;
input sample $ batch $ y;
datalines;
1	1	85
1	1	94
1	1	91
1	1	98
1	1	85
1	1	96
1	1	93
2	1	76
2	1	87
2	1	90
2	1	91
2	1	88
2	1	94
2	1	96
3	1	95
3	1	98
3	1	94
3	1	96
3	1	99
3	1	100
3	1	93
1	2	108
1	2	100
1	2	105
1	2	109
1	2	104
1	2	102
1	2	108
2	2	117
2	2	106
2	2	103
2	2	109
2	2	100
2	2	104
2	2	102
3	2	101
3	2	108
3	2	100
3	2	99
3	2	117
3	2	109
3	2	105
1	3	71
1	3	85
1	3	78
1	3	68
1	3	85
1	3	67
1	3	76
2	3	81
2	3	70
2	3	84
2	3	83
2	3	72
2	3	81
2	3	78
3	3	72
3	3	68
3	3	80
3	3	72
3	3	75
3	3	79
3	3	74
;
run;

proc glm data=tablet;
class batch sample;
model y = batch sample(batch) /E1; 
random batch sample(batch) /test;
run;

Proc varcomp method=reml data=tablet;
class batch sample;
Model y = batch sample(batch) /fixed=0;
Run;
