data paint;
input batch percent;
datalines;
1	4.18
1	2.29
1	1.40
1	8.69
1	1.01
2	5.60
2	4.74
2	1.86
2	6.29
2	2.25
3	7.59
3	7.46
3	5.79
3	5.09
3	5.47
4	4.25
4	5.39
4	4.81
4	7.75
4	6.10
5	2.18
5	5.88
5	3.07
5	5.25
5	3.50
6	5.11
6	7.61
6	3.46
6	6.57
6	6.35
7	5.68
7	7.55
7	2.30
7	2.15
7	8.92
8	4.61
8	7.14
8	4.61
8	5.23
8	3.56
9	8.72
9	6.93
9	5.25
9	8.97
9	4.34
10	4.67
10	7.85
10	2.21
10	9.57
10	4.85
;

proc glm;
title "This is the random effect model";
class batch;
model percent=batch /solution;
random batch;
run;

Proc varcomp method=reml data=paint;
class batch;
Model percent = batch/fixed=0;
run;
