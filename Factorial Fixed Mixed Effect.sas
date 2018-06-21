data temp;
	do mode= "I" ,"C" ,"S";
		do temperature = 1 to 4;
			do rep = 1 to 2;
				input y @@;
				output;
			end;
		end;
	end;
datalines;
12 16 15 19 31 39 53 55 15 19 17 17 30 34 51 49 11 17 24 22 33 37 61 67
;

proc glm data=temp;
	title "Fixed Effect Model";
	class temperature mode;
	model y = temperature|mode; *using | instead of writing A B A*C;
run;
quit;

proc glm;
	title "Mixed Effect Model";
	class temperature mode;
	model y = temperature|mode;
	random temperature mode*temperature /test; *SAS computes for mixed effect not all divided by MSE, correct F values;
run;
quit;

proc mixed; *Does not give enough information;
	title "Mixed Effect Model";
	class mode temperature; *only fixed effect shows up at model statement;
	model y = mode;
	random temperature mode*temperature;
run;
quit;
