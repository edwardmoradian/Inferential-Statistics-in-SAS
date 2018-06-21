data a;   
input subject sequence $ period regimen $ result; 
cards; 
1  AB 1 A 15 
1  AB 2 B 10 
2  AB 1 A 14 
2  AB 2 B 11 
3  AB 1 A 16 
3  AB 2 B 10 
4  AB 1 A 15 
4  AB 2 B 9 
5  AB 1 A 16 
5  AB 2 B 9 
6  BA 1 B 11 
6  BA 2 A 15 
7  BA 1 B 10 
7  BA 2 A 14 
8  BA 1 B 9 
8  BA 2 A 16 
9  BA 1 B 12 
9  BA 2 A 15 
10 BA 1 B 11 
10 BA 2 A 14 
;
run;
*Calculate the sum and difference of AB/BA sequences cross two periods;
data b;    set a;    
by subject;    retain sum dif ;   
if first.subject then do;       
	sum = result;  dif = result;    
end;    
else do;      
	sum = sum + result;      
	dif = dif - result;    
end;    
if last.subject then output; 
run;
*Estimate the carryover effect using sum values by T-Test;
proc ttest data= b;   
class sequence;   
var sum; 
run;

*Now estimate the effect of two treatments in 2 periods;
proc ttest data= b;   
class sequence;   
var dif; 
run;

title "Grizzles Model Using PROC MIXED with a Random EffectÅ"; 
proc mixed data=a;   
class sequence subject regimen period;   
model result = sequence period regimen;   
random subject(sequence);   
lsmeans sequence regimen /pdiff cl; 
run; quit;
