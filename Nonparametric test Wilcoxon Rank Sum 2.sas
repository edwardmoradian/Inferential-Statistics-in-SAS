data tv;
input ExpGrp $ Mileage @@;
datalines;
Treat 62.2 Control 97.1
Treat 95.8 Control 109.5
Treat 85.2 Control 63.9
Treat 79.3 Control 70.2
Treat 97.9 Control 101.7
Treat 87.9 Control 88.2
Treat 83.2 Control 94.6
Treat 91.5 Control 99.7
Treat 86.7 Control 99.1
Treat 82.2 Control 182.9
Treat 96.6 Control 193.2
Treat 99.7 Control 95.1
Treat 84.1 Control 85.6
Treat 90.1 Control 105.3
Treat 101.1 Control 92.4
Treat 89.3 Control 89.5
Treat 98.6 Control 92.9
Treat 88.6 Control 87.3
;
run;

proc NPAR1WAY data=tv wilcoxon;
	title "Nonparametric test";
	class ExpGrp;
	var Mileage;
	exact wilcoxon;
   run;


