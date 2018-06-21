****************************************************
Categorical Data Analysis
****************************************************;

*** raw - ungrouped data;

data EPA; 
input subjectID exposure:$12. disease $; 
datalines;
1 exposed Positive
2 exposed Positive
3 exposed Positive
4 exposed Positive
5 exposed negative
6 notExposed negative
7 exposed Positive
8 exposed Positive
9 exposed Positive
10 notExposed negative 
11 exposed negative
12 exposed Positive
13 notExposed Positive
14 notExposed negative 
15 exposed Positive 	
16 exposed Positive
17 exposed negative
18 notExposed negative 
19 exposed Positive
20 exposed Positive
21 exposed Positive
22 notExposed negative 
23 exposed negative
24 exposed Positive
25 notExposed negative
26 exposed negative
27 notExposed negative
28 exposed Positive
; run;

*summarize the data by using contingency table;
proc freq data = EPA;
	tables exposure * disease;
run;


*contingency table analysis;
proc freq data= EPA;
	tables exposure*disease /chisq;
run;


