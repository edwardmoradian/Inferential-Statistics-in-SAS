data traffic;
infile datalines dsd;
input intersection $ minutes signal $ period $;
datalines;
1,15.2,'A',1
1,33.8,'B',2
1,13.5,'C',3
1,27.4,'D',4
1,29.1,'E',5
2,16.5,'B',1
2,26.5,'C',2
2,19.2,'D',3
2,25.8,'E',4
2,22.7,'A',5
3,12.1,'C',1
3,31.4,'D',2
3,17,'E',3
3,31.5,'A',4
3,30.2,'B',5
4,10.7,'D',1
4,34.2,'E',2
4,19.5,'A',3
4,27.2,'B',4
4,21.6,'C',5
5,14.6,'E',1
5,31.7,'A',2
5,16.7,'B',3
5,26.3,'C',4
5,23.8,'D',5
;

proc glm data=traffic;
Class intersection signal period;
Model minutes=intersection signal period;
run;
quit;

Proc glm data=traffic;
Class intersection;
Model minutes=intersection;
means intersection/ hovtest=levene; 
output out=resids r=res;
run;
quit;

proc anova data=traffic;
	class signal period intersection;
	model minutes=signal  period intersection;
	means intersection /tukey;
	means intersection / tukey cldiff;
	/*The CLDIFF options requests confidence... */
run;
