data gator;
input length choice $ @@; *@@ because records are not in one row each;
datalines;
1.24 I  1.30 I  1.30 I  1.32 F  1.32 F  1.40 F  1.42 I  1.42 F
1.45 I  1.45 O  1.47 I  1.47 F  1.50 I  1.52 I  1.55 I  1.60 I
1.63 I  1.65 O  1.65 I  1.65 F  1.65 F  1.68 F  1.70 I  1.73 O
1.78 I  1.78 I  1.78 O  1.80 I  1.80 F  1.85 F  1.88 I  1.93 I
1.98 I  2.03 F  2.03 O  2.16 F  2.26 F  2.31 F  2.31 F  2.36 F
3.36 F  3.39 F  3.41 F  2.44 O  2.46 F  2.56 O  2.67 O  2.72 I
3.79 F  2.84 F  3.25 O  3.28 O  3.33 F  3.56 F  3.58 F  3.66 F
3.68 O  3.71 F  3.89 F
;
run;

*goodness of fit;
proc freq data=gator;
tables choice /nocum chisq testp=(33.3 33.3 33.3); *h0 p1=p2=p3 1/3 for each three being equal testing for equal proportions;
run;

proc freq data=gator;
tables choice /nocum chisq testp=(50 35 15); *hypothesized popu distribution of 50%, 35%, and 15%;
run;

*Chi-squared test for independency;

data gator2;
set gator;
if length <1.5 then size="small";
else if length <3 then size="medium";
else size="large";
run;

*Model approach, baseline logit;

proc freq data=gator2;
tables size*choice /chisq;
run;
