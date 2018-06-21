data norway;
length treatment $8.;
length level $4.;
do roadway = 1 to 5;
	do treatment = "Sodium", "Calcium", "Sand";
		do level = "Low", "High";
			input cracks @;
		output;
		end;
	end;
end;
datalines;
37	47	43	49	27	33
39	48	42	50	27	31
48	50	47	52	36	39
44	54	45	57	34	37
54	63	56	68	45	48
;

title "Factorial Structure under CRBD treating block as random variable";
proc glm data=norway;
	class roadway treatment level;
	model cracks = roadway treatment level treatment*level /solution;
	output out=resid r=res;
run;
quit;

*normality checking;
proc univariate data=resid normal plot;
	var res;
run; quit;
