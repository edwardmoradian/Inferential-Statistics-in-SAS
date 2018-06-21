



data RandomNormal;
do x=1 to 10000; 
y=rand('normal',5, 3);
*random number generator for normal is RAND('Normal',mu,sigma);
output;
end; run;


/*proc print data=RandomNormal; run; */

proc means data=RandomNormal;
var y; *I want the information just for the variable answer;
run;

proc sgplot data=RandomNormal;
title 'Random Normal';
histogram y;
density y; 
*this adds the normal density curve of the appropriate mean and standard deviation;
density y/type=kernel; *this adds the smoothed density curve;
run;
quit;

proc univariate data=RandomNormal;
qqplot y/normal (mu=est sigma=est) ;
* comparing this to a normal distribution (so SAS is looking up
the z values) the line will be drawn using the data points to estimate mu and sigma;
run;


************** Introduce macro variabe***************;

%Let n = 2000; *this is the # of obs we want to generate;
%Let mu = 5;
%Let sigma = 3;
%Let norm = rand('normal',&mu, &sigma);

*use &varaible to call the varaible;
data RandomNormaltemp;
do x=1 to &n; 
y=&norm;
output;
end; run;

******** Simulating data from binomial distribution;
******** then we will show the normal approximation to binomial;


data binomno;
seed=1234;
n=1000;p=0.2; sample_size=100;
do i=1 to sample_size;
x_bino=ranbin(seed,n,p);
output;
end;run;

proc sgplot data=binomno;
title 'Binomial(10, 0.1)';
histogram x_bino;
density x_bino; 
*this adds the normal density curve of the appropriate mean and standard deviation;
density x_bino/type=kernel; *this adds the smoothed density curve;
run;
quit;

*Now do two things ;
*1. Increase n, and keep p=0.2;
*2. Increase p, and keep n=10;


******** Simulating data from Poisson distribution;
******** then we will show the Poisson approximation to binomial;


data poisno;
seed=1234;
n=100;mu=5;
do i=1 to n;
x_poi=ranpoi(seed,mu);
output;
end;
run;

proc sgplot data=poisno;
title 'Poisson with mean=5';
histogram x_poi;
run;
quit;


**** Poisson approximation, mu=np - if n is large enough and p is small enough;

data poisno;
seed=1234;
n=1000;mu=5; n=10000; p=0.0005;
do i=1 to n;
x_poi=ranpoi(seed,mu);
x_bino=ranbin(seed,n,p);
output;
end;
run;

data temp; set poisno;
distribution="Poisson"; value=x_poi; output;
distribution="Binomial"; value=x_bino; output;
keep distribution value;
run;

*create both histogram to compare;
/*proc sgplot data=temp;
title 'Poisson vs. binomial';
histogram value/group=distribution;
run;
quit;
*/

proc univariate data=temp;
  class distribution;
  histogram value;
run;
