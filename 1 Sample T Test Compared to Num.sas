 data sleeptime;
	infile "C:\Users\Home\Desktop\Home\School\Graduate School\1 CSUEB\Fall 2017\STAT 6304 Advanced Statistical Inference\In Class Assignments\sleep.csv" dlm=',' firstobs=2;
	input time;
    run;

proc ttest data=sleeptime sides=2 alpha=0.1  h0=7;
      var time;
   run;

*VAR statement indicates that the time variable is being studied;
*h0=7:the mean of the time variable is compared to the null value 7
*the default of 0
*SIDES=2: 2 sided hypothesis testing - whether the mean sleep time is different than 7 hours;
* SIDES=L : less than 7 hours 
*SIDES=U 
*ALPHA=0.1: a signifcance level of 0.1 or a confidence level of 90%;
*Default is 0.05;


*Bootstrapping;

   data original; set sleeptime;
   run;

 data bootsamp;
 nobs=20;
 do i = 1 to nobs; 
	x = round(ranuni(0)*nobs); *x randomly selected from values 1 to NOBS;
    set original
    nobs = nobs  
    point=x; * This selected the xth observation from original dataset;
    output; * Send the selected observation to the bootsamp dataset;
 end;
stop;
run; 
