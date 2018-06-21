data discharge;
input Stream $ DisOx @@;
datalines;
Up 5.2 Down 3.2
Up 4.8 Down 3.4
Up 5.1 Down 3.7
Up 5.0 Down 3.9
Up 4.9 Down 3.6
Up 4.8 Down 3.8
Up 5.0 Down 3.9
Up 4.7 Down 3.6
Up 4.7 Down 4.1
Up 5.0 Down 3.3
Up 4.6 Down 4.5
Up 5.2 Down 3.7
Up 5.0 Down 3.9
Up 4.9 Down 3.8
Up 4.7 Down 3.7
;

title "listing";
proc print data=discharge;
run;

title "Two sample t-test";
	proc ttest data=discharge h0=0.5 alpha=.01;
	class Stream;
	var DisOx;
run;

*Test for Normality;

data Up; 
input UpDis@@; 
datalines; 
5.2 4.8 5.1 5.0 4.9 4.8 5.0 4.7 4.7 5.0 4.6 5.2 5.0 4.9 4.7
; run;

 data Down; 
input DownDis@@; 
datalines;
3.2 3.4 3.7 3.9 3.6 3.8 3.9 3.6 4.1 3.3 4.5 3.7 3.9 3.8 3.7
;

*all the test needs to check for normality;
proc univariate data=Up normal plot;
var UpDis;
run;

proc univariate data=Down normal plot;
var DownDis;
run;
