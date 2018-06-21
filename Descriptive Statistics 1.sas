data portfolio;
input sample:$10. var @@;
datalines;
Portfolio1 130	Portfolio2 154
Portfolio1 125	Portfolio2 144
Portfolio1 135	Portfolio2 147
Portfolio1 131	Portfolio2 110
Portfolio1 128	Portfolio2 112
Portfolio1 130	Portfolio2 153
Portfolio1 126	Portfolio2 140
Portfolio1 127	Portfolio2 131
Portfolio1 130	Portfolio2 141
Portfolio1 129	Portfolio2 136
Portfolio1 140	Portfolio2 145
Portfolio1 126	Portfolio2 124
Portfolio1 127	Portfolio2 107
Portfolio1 140	Portfolio2 154
Portfolio1 121	Portfolio2 125
Portfolio1 140	Portfolio2 134
Portfolio1 126	Portfolio2 131
Portfolio1 128	Portfolio2 115
Portfolio1 133	Portfolio2 136
Portfolio1 129	Portfolio2 157
;

title "Boxplot";
proc sgplot data=portfolio;
vbox var/ category=sample;
run;
