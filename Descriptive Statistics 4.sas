


***** Central Limit Theorem demonstration **** ;
****** Poisson distribution example      **** ;

* Draw samples from Poisson distribution with parameter mu;
%let NumSample=100;
%let SampleSize=50;
%let mu=3;
data PoissonSamples; 
   call streaminit(321);
   do sample=1 to &NumSample;
      do n=1 to &SampleSize;
          po=rand("Poisson", &mu);
          output;
      end;
   end;
run;

/* Visualize simulaed density of poisson values */
title "Simulated Poisson distribution with (*ESC*){unicode lambda}=&lambda";
proc sgplot data=PoissonSamples;
   vbar po / barwidth=1;
run;
title;

/* Calculate sample means */
proc means data=PoissonSamples noprint;
   class sample;
   output out=PoissonSampleMeans;
*(where=(_STAT_='MEAN' and _TYPE_=1));
run;

*_TYPE_: automatically added to the summary data set when the OUTPUT statement is used; 
*_TYPE_ is a numeric flag which indicates the subgroup of the CLASS variables summarized 
by that observation in the output data set;


* Visualize samlping distribution of the mean;
title 'Sampling distribution of the mean';
proc sgplot data=PoissonSampleMeans noautolegend;
   histogram po / scale=count;
   density po / type=normal;
run;
title;

*does it look normal, if not, what can we do based on CLT?;


***************** Example 2 ************************;
*** demonstracte the variability of the sample mean decreases as n increases;

%let nsamp = 100;
data normal;
do sample = 1 to &nsamp;
  sumy=0;
  do obs = 1 to &nsamp;
  *y=rand("normal", 0,1);
  x = normal(0);
 *NORMAL (seed): generates pseudorandom numbers from the standard normal(mean of 0 & SD of 1);
sumy=sumy+x;
meanx=sumy/obs;
output;
  end;
end;
run;

*or 2);
data normal;
do sample = 1 to &nsamp;
  meanx = 0;
  do obs = 1 to &nsamp;
  x = normal(0);
meanx = ((meanx * (obs -1)) + x)/obs;
output;
  end;
end;
run;


* now plot the means vs. the number of observations;


symbol1 i = none v = dot h = .2;
proc gplot data = normal;
plot meanx * obs;
run;
quit;

symbol1 i=join v=none r=&nsamp;
proc gplot data=normal;
  plot meanx * obs = sample / nolegend;
run; quit;



/* explain 2)
X=0; 
Do i=1 to 100;
X’= a value from a random generator;
Sumx=Sumx + X’;
Meanx=sumx/obs;
Run;

Meanx=(sumx + x’)/obs;
And sumx=meanx(from last loop)*(obs-1)

*/
