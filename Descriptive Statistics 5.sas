*libname statement point to the dataset folder where the SAS datasets reside;
libname dataset "H:\CSUEB\Teaching\st6304\2017 Fall\SAS\Data";
*turn on statistical graphics editor so you can edit titles footnotes etc.
*need to intall ODS grphics Editor to edit;

ods listing sge = on;

*set current folder. Graphs created by statistical graphics procedure will be automatically saved here;

**Box plot;
title "Boxplot";
title2 "No Categories";
proc sgplot data=dataset.employee;
vbox salary;
run; 

* .png: portable network graphics, can beeasily imported into other applications such as office Word and ppt;
* .png files are compact-Raster graphics, and take up less space than .bmp; 

proc sgplot data=dataset.employee;
hbox salary;
run; 


** Separate by gender; 

title "Boxplot";
title2 "Category=Gender";
proc sgplot data=dataset.employee;
vbox salary/ category=gender;
run; 

**Paneled boxplot by job category;

title "Boxplot with Panels";
proc sgpanel data=dataset.employee;
panelby jobcat/rows=1 columns=3;
vbox salary/ category=gender;
run; 

** using formats to make graphs more readable;
proc format;
value jobcat 	1="Clerical"
				2="Custodial"
				3="Manager";
value $Gender   "f"="Female"
				"m"="Male";
run;

title "Boxplot with Panels";
proc sgpanel data=dataset.employee;
panelby jobcat/rows=1 columns=3 novarname;
vbox salary/ category=gender;
format gender $gender.;
format jobcat jobcat.;
run; 

** check by no female employee at custodial job;
data temp; set dataset.employee;
if jobcat=2 and gender="f";
run;


** bar chart;
title "Vertical Bar Chart";
proc sgplot data=dataset.employee;
vbar jobcat;
run; 

**Cluster Bar chart by gender;
title "Vertical Bar Chart";
title2 "clustered by Gender";
proc sgplot data=dataset.employee;
vbar jobcat/group=gender groupdisplay=cluster;
run; 

** using formats to make graphs more readable;
proc format;
value jobcat 	1="Clerical"
				2="Custodial"
				3="Manager";
value $Gender   "f"="Female"
				"m"="Male";
run;

title "Vertical Bar Chart";
title2 "clustered by Gender";
proc sgplot data=dataset.employee;
vbar jobcat/group=gender groupdisplay=cluster;
format gender $gender.;
format jobcat jobcat.;
run; 

*** histogram;
title "Boxplot";
title2 "No Categories";
proc sgplot data=dataset.employee;
histogram salary;
run; 

***Scatterplots;
title "Scatterplot";
proc sgplot data=dataset.employee;
scatter x=salbegin y=salary;
run;


*** seperate the plot by gender;
proc sgplot data=dataset.employee;
scatter x=salbegin y=salary/group=gender;
run;

**add formate to make it more readable;
proc sgplot data=dataset.employee;
scatter x=salbegin y=salary/group=gender;
format gender $gender.;
run;


** now try to make a scatter plot of only jobcate=1, x is the previous experience, y is the salary. Seperate by gender;

title "Scatterplot with Regression Line";
title2 "Clerical Only";
proc sgplot data=dataset.employee;
where jobcat=1;
scatter x=prevexp y=salary / group=gender ;
*reg x=prevexp y=salary / cli clm nomarkers;
run;
