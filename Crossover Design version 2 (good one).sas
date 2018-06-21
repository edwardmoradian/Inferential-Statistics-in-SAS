data patients2;
do sequence = 1 to 3;
	do patient = 1 to 4;
		do period = 1 to 3;
				treatment = mod(sequence+period-2,3)+1; *A1,A2,A3 then A2,A3,A1 then A3,A1,A2;
				input duration@@;
			output;
		end;
	end;
end;
datalines;
1.5 2.2 3.4
2.0 2.6 3.1
1.6 2.7 3.2
1.1 2.3 2.9
2.5 3.5 1.9
2.8 3.1 1.5
2.7 2.9 2.4
2.4 2.6 2.3
3.3 1.9 2.7
3.1 1.6 2.5
3.6 2.3 2.2
3.0 2.5 2.0
;
run;

data depatients2; 
set patients2;
carryover="0 ";
if period=2 and sequence=1 then carryover="T1";
if period=3 and sequence=1 then carryover="T2";
if period=2 and sequence=2 then carryover="T2";
if period=3 and sequence=2 then carryover="T3";
if period=2 and sequence=3 then carryover="T3";
if period=3 and sequence=3 then carryover="T1";
run;

*test for carryover;
proc glm data=depatients2;
class sequence patient period treatment carryover;
model duration = sequence patient(sequence) treatment period carryover;
random patient(sequence) /test;
run;

*another way to calculate carryover using treatment*period;
*proc mixed gives variance components of each part;
proc mixed data=depatients2;
class sequence patient period treatment;
model duration=sequence treatment|period;
random patient(sequence);
*ismeans treatment /pdiff CL E;
run;

*drop interaction becuase it is statistically insignficant and test sequence effect;
proc glm data=depatients2;
class sequence patient period treatment;
model duration=sequence patient(sequence) treatment period;
random patient(sequence) /test;
run;

