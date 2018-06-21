data trees;
input diameter calcium pH @@;
datalines;
5.2	100	4 5.9	100	4 6.3	100	4 7.1	100	5
7.4	100	5 7.5	100	5 7.6	100	6 7.2	100	6
7.4	100	6 7.2	100	7 7.5	100	7 7.2	100	7
7.4	200	4 7.0	200	4 7.6	200	4 7.4	200	5
7.3	200	5 7.1	200	5 7.6	200	6 7.5	200	6
7.8	200	6 7.4	200	7 7.0	200	7 6.9	200	7
6.3	300	4 6.7	300	4 6.1	300	4 7.3	300	5
7.5	300	5 7.2	300	5 7.2	300	6 7.3	300	6
7.0	300	6 6.8	300	7 6.6	300	7 6.4	300	7
;
run;

proc glm data=trees;
class pH calcium;
model diameter=calcium pH pH*calcium;
run;

*estimate the parameters in the model using /solution;
proc glm data=trees;
class pH calcium;
model diameter=calcium pH pH*calcium/solution;
contrast '100 & 200 vs. 300' Calcium 1 1 -2; 
contrast '100 & 200 vs. 300' Calcium -1 -1 2; 
run;
