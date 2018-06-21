data nest2;
	do device = 1 to 3;
		do rep = 1 to 2;
			do facility = 1 to 2;
				do tester = 1 to 4;
					input y@@;
					output;
			end;
		end;
	end;
end;
datalines;
2.2 2.0 2.1 2.3 2.5 2.7 2.8 2.5
2.4 2.4 2.2 1.8 2.8 2.5 2.5 2.3
3.0 2.4 2.0 1.9 2.7 2.0 2.4 2.6
2.7 2.3 1.9 2.5 2.7 2.0 2.4 2.6
2.5 2.2 1.8 2.6 2.7 2.6 2.4 2.7
2.1 2.2 1.7 2.3 2.5 2.4 2.4 2.5
;
run;


*proc nest will not work because all are not nested within one another;
proc glm data=nest2;
class facility tester device;
model y = facility device facility*device tester(facility) /E1; 
random tester(facility) /test;
run;

*variation of first test, prefer to use first one;
proc glm data=nest2;
class facility tester device;
model y = facility device facility*device tester(facility) /E1; 
random tester(facility);
test H=facility E=tester(facility);
run;
