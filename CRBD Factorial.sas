data blood;
infile datalines dsd;
input center $ chol agegrp $ min $;
datalines;
1,82,A1,90
1,49,A2,90
1,54,A3,90
1,50,A1,90
1,41,A2,90
1,17,A3,90
1,31,A1,90
1,36,A2,90
1,47,A3,90
1,52,A1,60
1,57,A2,60
1,67,A3,60
1,32,A1,60
1,7,A2,60
1,7,A3,60
1,26,A1,60
1,17,A2,60
1,29,A3,60
1,39,A1,30
1,46,A2,30
1,-3,A3,30
1,30,A1,30
1,55,A2,30
1,-3,A3,30
1,-9,A1,30
1,-28,A2,30
1,18,A3,30
2,43,A1,90
2,60,A2,90
2,51,A3,90
2,34,A1,90
2,24,A2,90
2,3,A3,90
2,-18,A1,90
2,14,A2,90
2,-23,A3,90
2,3,A1,60
2,25,A2,60
2,-8,A3,60
2,64,A1,60
2,-13,A2,60
2,-14,A3,60
2,34,A1,60
2,30,A2,60
2,30,A3,60
2,4,A1,30
2,32,A2,30
2,23,A3,30
2,-26,A1,30
2,7,A2,30
2,-6,A3,30
2,45,A1,30
2,53,A2,30
2,2,A3,30
3,38,A1,90
3,41,A2,90
3,15,A3,90
3,-6,A1,90
3,65,A2,90
3,0,A3,90
3,30,A1,90
3,18,A2,90
3,23,A3,90
3,-3,A1,60
3,15,A2,60
3,7,A3,60
3,-4,A1,60
3,9,A2,60
3,-10,A3,60
3,-15,A1,60
3,24,A2,60
3,0,A3,60
3,17,A1,30
3,3,A2,30
3,23,A3,30
3,56,A1,30
3,-9,A2,30
3,3,A3,30
3,-30,A1,30
3,-7,A2,30
3,-16,A3,30
4,38,A1,90
4,-7,A2,90
4,51,A3,90
4,-7,A1,90
4,7,A2,90
4,-3,A3,90
4,-30,A1,90
4,-36,A2,90
4,-36,A3,90
4,-2,A1,60
4,35,A2,60
4,-12,A3,60
4,21,A1,60
4,-13,A2,60
4,-11,A3,60
4,-44,A1,60
4,-9,A2,60
4,10,A3,60
4,-13,A1,30
4,19,A2,30
4,15,A3,30
4,-14,A1,30
4,-18,A2,30
4,-32,A3,30
4,15,A1,30
4,-4,A2,30
4,14,A3,30
5,-3,A1,90
5,18,A2,90
5,35,A3,90
5,-3,A1,90
5,-4,A2,90
5,-55,A3,90
5,-37,A1,90
5,4,A2,90
5,-12,A3,90
5,3,A1,60
5,-13,A2,60
5,-22,A3,60
5,-37,A1,60
5,-1,A2,60
5,-30,A3,60
5,8,A1,60
5,-20,A2,60
5,-43,A3,60
5,26,A1,30
5,3,A2,30
5,-28,A3,30
5,11,A1,30
5,-7,A2,30
5,-19,A3,30
5,-38,A1,30
5,-22,A2,30
5,-32,A3,30
;
run;

proc glm data=blood;
class center agegrp min;
model chol=center agegrp min agegrp*min /solution;
run;
quit;

data bloodA1; 
set blood;
where agegrp="A1";
drop center;
run; 

proc anova data=bloodA1; 
class min;
model chol=min;
means min / tukey;
means min / tukey cldiff;
run;

data bloodA2; 
set blood;
where agegrp="A2";
drop center;
run;

proc anova data=bloodA2; 
class min;
model chol=min;
means min / tukey;
means min / tukey cldiff;
run; 

data bloodA3; 
set blood;
where agegrp="A3";
drop center;
run;

proc anova data=bloodA3; 
class min;
model chol=min;
means min / tukey;
means min / tukey cldiff;
run; 