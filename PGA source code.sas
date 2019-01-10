PROC IMPORT OUT= WORK.PGA DATAFILE= "/folders/myfolders/GolfingData.xlsx"  
            DBMS=XLSX REPLACE; 
     SHEET="Sheet1";  
     GETNAMES=YES;  
RUN; 


data Day_1_4;
   set work.pga;
   Day = 1 ; Score=Round1Score;output;
   Day = 4 ; Score=Round4Score;output;
   keep Day Score;
run;

proc ttest data=Day_1_4;
  class Day;
  var Score;
run;

proc ttest data=work.pga;
paired Round1Score*Round4Score;
run;

data Day_Score;
   set work.pga;
   Day = 1 ; Score=Round1Score;output;
   Day = 4 ; Score=Round4Score;output;
   Day = 2 ; Score=Round2Score;output;
   Day = 3 ; Score=Round3Score;output;
   keep Day Score;
run;

proc anova data=Day_Score;
class Day;
model Score = Day;
means Day/lsd;
run;

data Age_Score;
   set work.pga;
   if Age<=40 then Age_Group="Young";
   else Age_Group="Old";
   Keep Age_Group TotalStrokes;
run;

proc ttest sides=U data=Age_Score;
  class Age_Group;
  var TotalStrokes;
run;


