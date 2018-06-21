Title ’Comparing Group Means’;
data scores;
input Gender $ Score @@;
datalines;
f 75 f 76 f 80 f 77 f 80 f 77 f 73
m 82 m 80 m 85 m 85 m 78 m 87 m 82
;
run;

proc NPAR1WAY data=scores wilcoxon;
	title "Nonparametric test to compare golf score between gender";
	class Gender;
	var Score;
	exact wilcoxon;
   run;
