data Treatment;
input Treatment@@;
datalines;
62.2 79.3 83.2 82.2 84.1 89.3
95.8 97.9 91.5 96.6 90.1 98.6
85.2 87.9 86.7 99.7 101.1 88.6
; run;

data Control;
input Control@@;
datalines;
97.1 70.2 94.6 182.9 85.6 89.5
109.5 101.7 99.7 193.2 105.3 92.9
63.9 88.2 99.1 95.1 92.4 87.3
; run;

data total;
merge Treatment Control; run;

data New; set total;
Group="Control Group"; Distance=Control; output;
Group="Treatment Group"; Distance=Treatment; output;
run;

proc ttest data=new alpha=0.05 CI=equal;
class Group;
var Distance; run;
