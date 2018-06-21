
****************************************************
One Way ANOVA and Kruskal-Wallis Test
****************************************************;

title 'Motor Oil analysis';


data oil;
   input type $ visc;
        label type='oil type';
        label visc='viscosity';
cards;
CNVNTNL      44
CNVNTNL      49
CNVNTNL      37
CNVNTNL      38
CNVNTNL      54
CNVNTNL      29
CNVNTNL      39
CNVNTNL      65
SYNTHET      42
SYNTHET      59
SYNTHET      52
SYNTHET      57
SYNTHET      49
SYNTHET      45
SYNTHET      44
HYBRID       60
HYBRID       71
HYBRID       78
HYBRID       35
HYBRID       18
HYBRID       48
HYBRID       36
HYBRID       68
; run;

proc glm  data=oil;
   class type;
   model visc = type;
   means type/hovtest=levene;
   output   out=out  r=resid;
  * output to a dataset called out to store  residuals;
   run; quit;

*Check for model assumption constant variances;
proc univariate    data=out plot normal;
   var resid;
run;

data oil2; set oil;
logvisc=log(visc);
run;

proc glm  data=oil2;
   class type;
   model logvisc = type;
   means type/hovtest=levene;
   output   out=out  r=resid;
  * output to a dataset called out to store  residuals;
   run; quit;

*Use non-parametric test: Kruskal-Wallis;
PROC NPAR1WAY data=oil wilcoxon;
class type;
var visc;
*Exact; *OPTIONAL;
Run;


