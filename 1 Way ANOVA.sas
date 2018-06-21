data Arthritis;
input subject A1 A2 A3;
cards;
1 3 1.8 1.3
2 1.2 6.3 12.6
3 1	5.2	10
4 0.7 3.7 10.5
5 1.1 5.4 10.8
6 0.6 2.9 5.9
7 1.2 6	12.1
8 0.1 0.3 0.6
9 0.7 3.6 18.6
10 1.9 9.3 18.7
11 0.6 2.8 5.5
12 0 0 0
13 1.6 8.1 18.2
14 4 19.9 22.3
15 0.1 0.3 0.6
;
run;

data one; set Arthritis;
analgesic="A1"; pain=A1; output;
analgesic="A2"; pain=A2; output;
analgesic="A3"; pain=A3; output;
drop A1 A2 A3;
run;


proc glm data=one;
class analgesic;
model pain = analgesic;
means analgesic/hovtest=bartlett;
means analgesic/hovtest=BF;
means analgesic/hovtest=levene;
run;


* a transformation is needed!;

data one; set one;
logpain=log(pain);
run;

proc glm data=one;
class analgesic;
model logpain = analgesic;
means analgesic/hovtest=bartlett;
means analgesic/hovtest=BF;
means analgesic/hovtest=levene;
run;
quit;
