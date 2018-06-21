*example 1;
data trans;
input thick @@;
label thick = ’Plating Thickness (mils)’;
datalines;
3.468 3.428 3.509 3.516 3.461 3.492 3.478 3.556 3.482 3.512
3.490 3.467 3.498 3.519 3.504 3.469 3.497 3.495 3.518 3.523
3.458 3.478 3.443 3.500 3.449 3.525 3.461 3.489 3.514 3.470
3.561 3.506 3.444 3.479 3.524 3.531 3.501 3.495 3.443 3.458
3.481 3.497 3.461 3.513 3.528 3.496 3.533 3.450 3.516 3.476
3.512 3.550 3.441 3.541 3.569 3.531 3.468 3.564 3.522 3.520
3.505 3.523 3.475 3.470 3.457 3.536 3.528 3.477 3.536 3.491
3.510 3.461 3.431 3.502 3.491 3.506 3.439 3.513 3.496 3.539
3.469 3.481 3.515 3.535 3.460 3.575 3.488 3.515 3.484 3.482
3.517 3.483 3.467 3.467 3.502 3.471 3.516 3.474 3.500 3.466
;
run;

title ’Process Capability Analysis of Plating Thickness’;
proc capability data=trans noprint;
histogram thick;
run;

proc univariate data=Trans noprint;
   histogram Thick;
run;

*practice 1;
data IQ; input score @@;
cards;
88   78  106  114  119   94  101   96   90   83  101   93  104  109   92   93   76   63   79   83   73   97  110  101  110   81  116   90  114   95   70  104  102  107  109  119  112  114   64  123  118  102  115   77   89   97   87   89   86   83  110  128  107  102  100  105  101  101  106   86   80   90  112  109  104  91   90   86  196  114  112  116   79   85  104  115   89   98  100  105  100  115  106   91  119  105  113  118   92   92   77  117   98   86   91  115   61   85   98   89  115  112  112  111  93   98   84   94  105  135   71   71   86   75   90   78   91  90  113   80   94   91  105  106  107  115   97   94   81  110  95   68  111   87   98   99  117  111  107  113  114  118   96  79  121  112   94   89   79   94  100  107   99  109  113  106  96   86   84   80  100  112   92  124  104  127  104   66  116  111  104   86  118   94  133   87   95  102   99  108  133   78  70  126   97  115  104  106   58   72  150   87  126   94   77  126   92  114  122  118  116  105  105   89  125   89   92  125  121  112   82   96  119  108   70   92   86   98   94  106   91  83  122   94   98   88  108  119  102  102  101   82  113  102  93  115   99  100   96   91   96  109  127   97  112  100  121  125  109  117
;
run;

title ’IQ distribution’;
proc univariate data=IQ noprint;
   histogram score;
run;


*example 2;
data one;
input terrestrial @@;
cards;
76.50 6.03 3.51 9.96 4.24 7.74 9.54 41.70 1.84 2.50 1.54
run;

data two; input aquatic@@;
cards;
0.27 0.61 0.54 0.14 0.63 0.23 0.56 0.48 0.16 0.18
run;

data total; merge one two; run;

proc univariate data=total;
var terrestrial aquatic; run;

********* This answered question b, how do we get a, or better yet a b by one dataset ********;

********stacked vs. unstacked data *******************;

data one;
input  value@@;
feeder="terrestrial";
cards;
76.50 6.03 3.51 9.96 4.24 7.74 9.54 41.70 1.84 2.50 1.54
run;

data two; input value@@;
feeder="aquatic";
cards;
0.27 0.61 0.54 0.14 0.63 0.23 0.56 0.48 0.16 0.18
run;

data total; set one two; run;

proc univariate data=total;
var value; run;


proc sort data=total; by feeder; run;

proc univariate data=total;
var value; by feeder; run;
