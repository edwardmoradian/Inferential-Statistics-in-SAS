data music;
infile datalines dsd;
input subject $ type:$9. outcome;
datalines;
1,'NoMusic',20
2,'NoMusic',17
3,'NoMusic',24
4,'NoMusic',20
5,'NoMusic',22
6,'NoMusic',25
7,'NoMusic',18
1,'HardRock',20
2,'HardRock',18
3,'HardRock',23
4,'HardRock',18
5,'HardRock',21
6,'HardRock',22
7,'HardRock',19
1,'Classical',24
2,'Classical',20
3,'Classical',27
4,'Classical',22
5,'Classical',24
6,'Classical',28
7,'Classical',16
;

proc glm data=music;
class subject type;
model outcome=subject type /solution; */solution for parameter estimates;
run;
quit;