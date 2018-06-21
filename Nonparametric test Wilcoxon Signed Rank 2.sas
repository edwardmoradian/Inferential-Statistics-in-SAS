data repair;
infile datalines dsd;
input repairshop female male;
difference=female-male;
datalines;
1,871,792
2,684,765
3,795,511
4,838,520
5,1033,618
6,917,447
7,1047,548
8,723,720
9,1179,899
10,707,788
11,817,927
12,846,657
13,975,851
14,868,702
15,1323,918
16,791,528
17,1157,884
18,932,702
19,1089,839
20,770,878
;
run;

proc print data=repair;
run;

proc univariate data=repair;
var difference;
run;
