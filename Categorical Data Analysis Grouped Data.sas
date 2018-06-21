** grouped data;
data EPA2; 
input exposure:$12. disease $ count; 
datalines;
notExposed Positive 15
notExposed negative 25
little Positive 15
little negative 10
lots Positive 20
lots negative 15
;
run;

proc freq data = EPA2;
	weight count; *use weight to use count variable;
	tables exposure * disease;
run;

** chi-square test for independency;

proc freq data = EPA2;
	weight count;
	tables exposure * disease/chisq exact; *exact option gives Fisher's exact test;
run;
