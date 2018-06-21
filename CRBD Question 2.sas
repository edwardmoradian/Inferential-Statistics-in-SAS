Data one;
Input pair before after;
datalines;
1	2.37	2.51
2	3.17	2.65
3	3.07	2.6
4	2.73	2.4
5	3.49	2.31
6	4.35	2.28
7	3.65	0.94
8	3.97	2.21
9	3.21	3.29
10	4.46	1.92
11	3.81	3.38
12	4.55	2.43
13	4.51	1.83
14	3.03	2.63
15	4.47	2.31
16	3.44	1.85
17	3.52	2.92
18	3.05	2.26
19	3.66	3.11
20	3.81	1.9
21	3.13	2.5
22	3.43	3.18
23	3.26	3.24
24	2.85	2.16
Run;
 
/*changing from unstacked data to stacked*/
data two; set one;
length treatment $10;
treatment="before"; outcome=before;output;
treatment="after"; outcome=after; output;
keep pair treatment outcome;
run;

/*Model fitting CRBD, pair is the block */;
Proc glm data=two;
Class treatment pair;
Model outcome=treatment pair;
*means treatment / hovtest=levene; 
/* Performs the Levene test for the factor A */
*output out=resids r=res;
Run;
Quit;

/* what is the equivalent test here? - paired t-test 
it runs on the unstacked data, does the result match? */
proc ttest data=one;
paired before*after;
run;

/*pair t-test is one sample t-test on the difference, test the claim*/
/* what is the assumption of using t- test? the difference is normal distributed*/
data one; set one;
difference=before-after;
run;

proc ttest data=one;
var difference;
run; 
