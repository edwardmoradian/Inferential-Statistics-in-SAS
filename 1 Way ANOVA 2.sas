data biology;
input Group $ Value @@;
datalines;
Wild 114.7 Ranch 120.4 Zoo 103.1
Wild 128.9 Ranch 91 Zoo 90.7
Wild 111.5 Ranch 119.6 Zoo 129.5
Wild 116.4 Ranch 119.4 Zoo 75.8
Wild 134.5 Ranch 150 Zoo 182.5
Wild 126.7 Ranch 169.7 Zoo 76.8
Wild 120.6 Ranch 100.9 Zoo 87.3
Wild 129.59 Ranch 76.1 Zoo 77.3
;

proc glm data=biology;
    class Group;
    model Value = Group;
	means Group/hovtest=BF;
	means Group/hovtest=levene;
	means Group/hovtest=bartlett;
	output   out=out  r=resid;
run; 
quit;

proc univariate data=out plot normal;
   var resid;
run;

data biology2; set biology;
logvalue=log(Value);
run;

proc glm data=biology2;
    class Group;
    model logvalue = Group;
	means Group/hovtest=BF;
	means Group/hovtest=levene;
	means Group/hovtest=bartlett;
	output   out=out  r=resid;
run; 
quit;

proc univariate data=out plot normal;
   var resid;
run;
