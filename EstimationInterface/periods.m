function Periods = periods(MMBEST)
%%Constructs the graph/RMSE time span
%Inputs: strings from the UI interface: 
%yearfirstvintfc quarterfirstvintfc  yearlastvintfc quarterlastvintfc 
%Output: periods - list of vintages in the time span as numbers of the
%format 20081 for 2008 Q1.
str = date;
VintageSpan=[[num2str(MMBEST.yearfirstvintfc) num2str(MMBEST.quarterfirstvintfc(end))]; ... 
    [num2str(MMBEST.yearlastvintfc) num2str(MMBEST.quarterlastvintfc(end))]];
VINTAGES=[];
for y = 1984:str2num(str([8:11]))
    for q = 1:4
        a = num2str(y);
        VINTAGES = [VINTAGES;[a num2str(q)]];
    end
end
fvint=find(strcmp(VINTAGES,{VintageSpan(1,:)})==1);
lvint=find(strcmp(VINTAGES,{VintageSpan(2,:)})==1);
Periods=VINTAGES(fvint:lvint,:);
end