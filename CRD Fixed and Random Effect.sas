data tracking;
input station intensity;
datalines;
1 20
1 1050
1 3200
1 5600
1 50
2 4300
2 70
2 2560
2 3650
2 80
3 100
3 7700
3 8500
3 2960
3 3340
;

proc glm;
title "This is the fixed effect model";
class station;
model intensity=station /solution;
run;
quit;

proc glm;
title "This is the random effect model";
class station;
model intensity=station /solution;
random station;
run;

