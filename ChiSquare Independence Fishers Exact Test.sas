data groups;
input Exposure $ Disease:$12. Count;
datalines;
notExposed Positive 15
notExposed negative 25
little Positive 15
little negative 10
lots Positive 20
lots negative 15
;
run;

proc freq data=groups;
	weight Count;
	tables Exposure * Disease /chisq exact;
run;
