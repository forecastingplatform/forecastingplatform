
%create a chronological line for vintages and observations
try
zone=MMBDATA.zone;
catch
end
str=date;

OBSERVATION=[];VINTAGES=[];

for y = 1940:str2num(str([8:11]))+20    
    for q = 1:4
        OBSERVATION = [OBSERVATION;[num2str(y) ':Q' num2str(q)]];
        a = num2str(y);
        VINTAGES = [VINTAGES;[a(end-1:end) 'Q' num2str(q)]];
    end
end

% Set default values to tabs in the GUI
if strcmp(zone,'us')
    
    RawData = '\USRawData\';
    
    l = size(RawData,2)+1; 
    
    Default=[1 4;6 7];Default1=[19 22;23 24;25 26];
    
    ObsInfos = {{[RawData 'RGDP'];[RawData   'PGNP']},{'ROUTPUT';'P'},[1;1],1,1,[],[],2,{'xgdp_q_obs'},{'xgdp_q_obs'},{'xgdp_a_obs'},{'SPFRGDP'};
        {[RawData   'PGNP']},{'P'}      ,1,1,1,[],[],2,{'pgdp_q_obs'},{'pgdp_q_obs'},{'pgdp_a_obs'},{'SPFPGDP'};
        {[RawData 'FEDFUNDS'];[RawData   'PGNP']},{'RFF';'P'}  ,[1;1],[2;1],[2;1],[],[],3,{'rff_q_obs'} ,{'rff_q_obs'},{'rff_a_obs'},{'FEDFUNDS'} ;
        {[RawData 'NCON'];[RawData   'PGNP']} ,{'NCON';'P'}    ,[1;1],1,1,[],[],1,{'pcer_q_obs'},{'pcer_q_obs'},{'pcer_a_obs'},{[]};
        {[RawData 'FPI_2'];[RawData   'PGNP']},{'FPI_';'P'}    ,[1;1],2,2,[],{[5 8;9 10;11 12]},1,{'fpi_q_obs'},{'fpi_q_obs'},{'fpi_a_obs'},{[]};
        {[RawData 'WAGE'];[RawData   'PGNP']},{'WSD';'P'}      ,[1;1],1,1,[],[],1,{'wage_obs'},{'wage_obs'}  ,{'wage_obs'},{[]};
        {[RawData 'M2SL_2'];[RawData   'PGNP']},{'M2SL_';'P'}  ,[0;1],2,2,[],{[6 9;10 11;12 13]},1,{'real_m2_growth'},{'real_m2_growth'},{'real_m2_growth'},{[]};
        {[RawData 'HOURS'];[RawData 'CE16OV_2']},{'H';'CE16OV_'},[0;0],[3;2],[2;2],{[1 4;6 7]; Default},{[2 3;4 4;0 0];[8 11;12 13;14 15]},6,{'hours_obs'},{'hours_obs'},{'hours_obs'},{[]};
        {[RawData 'MDOTHMFIDITP1T4FR_2'];[RawData 'MDOTHMFIDITPMFR_2']},{'MDOTHMFIDI_';'MDOTHMFIDI_'},[1;1],[2;2],[2;2],{[1 4;6 7];[1 4;6 7]},{[19 22;23 24;25 26];[17 20;21 22;23 24]},5,{'MDOTHMFIDIGROWTH'},{'MDOTHMFIDIGROWTH'},{'MDOTHMFIDIGROWTH'},{[]};
        {[RawData 'MDOTHMFICBTP1T4FR_2'];[RawData 'MDOTHMFICBTPMFR_2']},{'MDOTHMFICB_';'MDOTHMFICB_'},[1;1],[2;2],[2;2],{[1 4;6 7];[1 4;6 7]},{[19 22;23 24;25 26];[17 20;21 22;23 24]},5,{'MDOTHMFICBGROWTH'},{'MDOTHMFICBGROWTH'},{'MDOTHMFICBGROWTH'},{[]};
        {[RawData 'LCI_USA']},{'B1023NCBAM'},0,3,2,{[];[1 4;6 7]},[],1,{'LCI_USA_QGROWTH'},{'LCI_USA_QGROWTH'},{'LCI_USA_QGROWTH'},{[]};
        {[RawData 'EVANQ_2']},{'EVANQ_'},1,2,2,[],{[7 10;11 12;13 14]},1,{'EVANQ'},{'EVANQ'},{'EVANQ'},{[]};
        {[RawData 'Baa'];[RawData 'Treasury10']},{'Baa';'10YTB'},[0;0],[3;3],[2;2],{[1 4;6 7];[1 4;6 7]},{Default1; Default1},4,{'cp_q_obsBaaT10'},{'cp_q_obs'},{'cp_q_obsBaaT10'},{[]};
        {[RawData 'Baa'];[RawData 'Aaa']},{'Baa';'Aaa'},[0;0],[3;3],[2;2],{[1 4;6 7];[1 4;6 7]},{Default1; Default1},4,{'cp_q_obsBaaAaa'},{'cp_q_obs'},{'cp_q_obsBaaAaa'},{[]};
        {[RawData 'Baa'];[RawData 'FEDFUNDS']},{'Baa';'RFF'},[0;1],[3;2],[2;2],{[1 4;6 7]; Default},{Default1; Default1},4,{'cp_q_obsBaaRFF'},{'cp_q_obs'},{'cp_q_obsBaaRFF'},{[]};
        {[RawData 'GZ_spread']},{'GZ' },0,3,2,{[1 4;6 7]},[],3,{'cp_q_obsGZ'},{'cp_q_obs'},{'cp_q_obsGZ'},{[]}};
    
    handles.spffilename{1} = {'\USRawData\SPFRGDP'};
    
    handles.spffilename{2} = {'\USRawData\SPFPGDP'};
    
    handles.spffilename{3} = {'\USRawData\FEDFUNDS'};
    
elseif strcmp(zone,'euroarea')
    
    RawData = '\EARawData\';
    
    l = size(RawData,2)+1;
    
    ObsInfos = {{[RawData 'OUTPUT']},{'ROUTPUT'},1,1,2,[],{[7 10;4 5;1 2]},9,{'xgdp_q_obs'},{'xgdp_q_obs'},{'xgdp_a_obs'},{[]};
        {[RawData   'GDPDEF']},{'P'}            ,1,1,2,[],{[7 10;4 5;1 2]},10,{'pgdp_q_obs'},{'pgdp_q_obs'},{'pgdp_a_obs'},{[]};
        {[RawData 'EONIA']},{'EONIA'}           ,0,3,2,{[1 4;5 7]},{[7 10;4 5;1 2]},7,{'rff_q_obs'},{'rff_q_obs'} ,{'rff_a_obs'},{[]};
        {[RawData 'PCN']} ,{'PCN'}              ,1,1,2,[],{[7 10;4 5;1 2]},1,{'pcer_q_obs'},{'pcer_q_obs'},{'pcer_a_obs'},{[]};
        {[RawData 'GFCF']},{'FPI_'}             ,1,1,2,[],{[7 10;4 5;1 2]},1,{'fpi_q_obs'},{'fpi_q_obs'},{'fpi_a_obs'},{[]};
        {[RawData 'WAGE']},{'WSD'}              ,1,1,1,[],[],10,{'wage_obs'},{'wage_obs'}  ,{'wage_obs'},{[]};
        {[RawData 'M3']},{'M3'}                 ,0,3,2,{[1 4;5 7]},{[7 10;4 5;1 2]},1,{'real_m3_growth'},{'real_m3_growth'},{'real_m3_growth'},{[]};
        {[RawData 'EMP']},{'EMP'}               ,1,1,2,[],{[7 10;4 5;1 2]},9,{'emp_q_obs'},{'emp_q_obs'},{'emp_a_obs'},{[]}
        };
    handles.Labor_Force = {'\EARawData\Labor_Force'};
end
MMBDATA.ObsInfos=ObsInfos; 