function varargout = EstimationInterface(varargin)
% ESTIMATIONINTERFACE MATLAB code for EstimationInterface.fig
%      ESTIMATIONINTERFACE, by itself, creates a new ESTIMATIONINTERFACE or raises the existing
%      singleton*.
%
%      H = ESTIMATIONINTERFACE returns the handle to a new ESTIMATIONINTERFACE or the handle to
%      the existing singleton*.
%
%      ESTIMATIONINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESTIMATIONINTERFACE.M with the given input arguments.
%
%      ESTIMATIONINTERFACE('Property','Value',...) creates a new ESTIMATIONINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EstimationInterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EstimationInterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EstimationInterface

% Last Modified by GUIDE v2.5 01-Aug-2018 19:07:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @EstimationInterface_OpeningFcn, ...
    'gui_OutputFcn',  @EstimationInterface_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before EstimationInterface is made visible.
function EstimationInterface_OpeningFcn(hObject, eventdata, handles, varargin)
warning off
handles.output = hObject;
global MMBEST;

MMBEST.modelslist = [handles.bvarmp, handles.bvarglp, ...
    handles.ussw07,handles.usdngs14, ...
     handles.usnkbas ];
 
MMBEST.models = char([ 'BVAR_MP     ';
    'BVAR_GLP    ';
    'US_SW07     ';
    'US_DNGS14   ';
    'NK_RW97     ']);
%% Settings for region, EA can be added as 2 (dataset to be updated)
MMBEST.region = [1,1,1,1,1];

%% List of observables 
% Set 1 in the column if it enters as an observable variable, otherwise 0.
%  According to List_Observables_US.xls, the variable in the model's varobs 
%  should be named according to Column C in the excel:
%1.     xgdp_a_obs
%2.     pgdp_a_obs
%3.     rff_a_obs
%4.     pcer_a_obs
%5.     fpi_a_obs
%6.     wage_obs
%7.     real_m2_growth
%8.     hours_obs
%9.     MDOTHMFIDIGROWTH
%10.    MDOTHMFICBGROWTH
%11.    LCI_USA_QGROWTH
%12.    EVANQ
%13.    cp_q_obsBaaT10
%14.    cp_q_obsBaaAaa
%15.    cp_q_obsBaaRFF
%16.    cp_q_obsGZ

MMBEST.model_observables(1,:) = [1 1 1 1 1 1 0 1 0 0 0 0 0 0 0 0]; %BVAR_MP
MMBEST.model_observables(2,:) = [1 1 1 1 1 1 0 1 0 0 0 0 0 0 0 0]; %BVAR_GLP
MMBEST.model_observables(3,:) = [1 1 1 1 1 1 0 1 0 0 0 0 0 0 0 0]; % SW07
MMBEST.model_observables(4,:) = [1 1 1 1 1 1 0 1 0 0 0 0 1 0 0 0]; % DNS14
MMBEST.model_observables(5,:)=  [1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0]; % NK_BAS


%% Interface settings
% Create chosenmodel variable - the model is 1 to be estimated. Its
% location is linked to the handles in MMBEST.modelslist. EG: Choosing the
% first model is will estimate the BVAR MP.
for i = 1:size(MMBEST.modelslist,2)
    MMBEST.chosenmodels(i) = 0;
end
% Checkboxes 
MMBEST.checkboxes = [ handles.bmodeestimation, handles.bmhestimation, handles.rmse, handles.inspf, handles.expseries, handles.plots];
%Setting default values for the vintages and graphs
MMBEST.quarterfirstvint = 'Q4'; % set(handles.firstvintquarter,'string',MMBEST.quarterfirstvint);
MMBEST.yearfirstvint = '2007';  set(handles.firstvintyear,'String',MMBEST.yearfirstvint);
MMBEST.quarterlastvint = 'Q4'; % set(handles.lastvintquarter,'string',MMBEST.quarterlastvint);
MMBEST.yearlastvint = '2007';   set(handles.lastvintyear,'String',MMBEST.yearlastvint); 
MMBEST.quarterfirstobs = 'Q1'; MMBEST.yearfirstobs = '1960';  set(handles.yearfirstobs,'String',MMBEST.yearfirstobs);
MMBEST.quarterfirstvintfc = 'Q4'; MMBEST.yearfirstvintfc = '2007'; set(handles.firstvintyearfc,'String',MMBEST.yearfirstvintfc);
MMBEST.quarterlastvintfc = 'Q4';  MMBEST.yearlastvintfc = '2007';  set(handles.lastvintyearfc,'String',MMBEST.yearlastvintfc);




MMBEST.benchmarklist = ls('..\OUTPUT\USMODELS');MMBEST.benchmarklist = MMBEST.benchmarklist (3:end,:);
set(handles.densitybenchmark,'String',MMBEST.benchmarklist(find(cellfun(@isempty,strfind(cellstr(MMBEST.benchmarklist),'_MH'))==0),:));
MMBEST.deletefiles = 0; MMBEST.DataArea = '..\DATA\USDATA';
MMBEST.default_horizon = 5; MMBEST.horizon = MMBEST.default_horizon; MMBEST.qh = 2; MMBEST.expseriesvalue = 0; MMBEST.windowlength = 80;
MMBEST.inspf = 0; MMBEST.acceptance = 0.25; MMBEST.numchains = 2; MMBEST.chainslength = 50000; MMBEST.numburnin =.3 ; MMBEST.plots = 0;
MMBEST.real = 1; MMBEST.rev = 0; MMBEST.vintrev = 0; MMBEST.create_new_vintages = 1; MMBEST.rmse = 0; MMBEST.bvarglpdraws = 20000;
MMBEST.gvar=0;
MMBEST.densitymodel=[];
MMBEST.statistics='Mean';
MMBEST.bvarmpriors=[3, 0.5, 5, 2, 1, 0, 0 ];
%Disable UI elements when opening
set(findall(handles.mhsettingspanel, '-property', 'enable'), 'enable', 'off')
set(findall(handles.plotoptionspanel, '-property', 'enable'), 'enable', 'off')
set(findall(handles.forecastchartpanel, '-property', 'enable'), 'enable', 'off')
set(findall(handles.estpanel, '-property', 'enable'), 'enable', 'off') %Setting the estimation methods grey unless one clicks into it
set(findall(handles.bvarpriors, '-property', 'enable'), 'enable', 'off')
set(findall(handles.esttypepanel, '-property', 'enable'),'enable', 'on')
set(findall(handles.datatypepanel, '-property', 'enable'),'enable', 'on')
set(handles.rw,'enable', 'off')
%Disable UI elements when opening
set(MMBEST.modelslist,'Value',0);
set(findall(handles.estpanel, '-property', 'enable'), 'Value', 0);


guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = EstimationInterface_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function models_Callback(hObject, eventdata, handles)

global MMBEST;

for i = 1:size(MMBEST.modelslist,2)
    MMBEST.chosenmodels(i) = 0;
end
val=get(hObject,'Value');
set(MMBEST.modelslist,'Value',0)
set(findall(handles.bvarpriors, '-property', 'enable'), 'enable', 'off')
set(handles.inspf,'enable', 'on');  set(handles.inspf,'Value', 0);        
set(findall(handles.estpanel, '-property', 'enable'), 'enable', 'on')

if ~isempty(findobj(MMBEST.modelslist,'Tag',get(hObject,'Tag')))
    MMBEST.chosenmodels(find(MMBEST.modelslist==findobj(MMBEST.modelslist,'Tag',get(hObject,'Tag')))) = val;
    set(MMBEST.modelslist(find(MMBEST.modelslist==findobj(MMBEST.modelslist,'Tag',get(hObject,'Tag')))),'Value',val)
    MMBEST.spf = [];
        
    %%
        set(findall(handles.estpanel, '-property', 'enable'), 'enable', 'on')
        set(findall(handles.mhsettingspanel, '-property', 'enable'), 'enable', 'off')
        MMBEST.DataArea = '..\DATA\USDATA';
        if find(MMBEST.modelslist==findobj(MMBEST.modelslist,'Tag',get(hObject,'Tag'))) == 2
            set(handles.spf, 'enable', 'on')
            set(handles.inspf, 'enable', 'on')
        end
        MMBEST.benchmarklist = ls('..\OUTPUT\USMODELS');
        MMBEST.benchmarklist = MMBEST.benchmarklist(3:end,:);
        set(handles.densitybenchmark,'String',MMBEST.benchmarklist(find(cellfun(@isempty,strfind(cellstr(MMBEST.benchmarklist),'_MH'))==0),:));
        MMBEST.region(1,1:2) = 1;
    
      if strcmp(get(hObject,'Tag'),'bvarmp')
        set(findall(handles.bvarpriors, '-property', 'enable'), 'enable', 'on')

               set(handles.inspf,'enable', 'off');  set(handles.inspf,'Value', 0);        
               set(findall(handles.estpanel, '-property', 'enable'), 'enable', 'off')
        if ~get(hObject,'Value')
                set(findall(handles.bvarpriors, '-property', 'enable'), 'enable', 'off')
               set(handles.inspf,'enable', 'on');               
        end
        MMBEST.EstimationMethod = zeros(1,3);
        MMBEST.EstimationMethod(1,1) = 1;
        MMBEST.chosenmodels(1,1) = 1;
        MMBEST.benchmarklist1=[{MMBEST.benchmarklist(find(cellfun(@isempty,strfind(cellstr(MMBEST.benchmarklist),'_MH'))==0),:)};{'BVAR_MP'}];
        set(handles.densitybenchmark,'String',cellstr(MMBEST.benchmarklist1));

     end
 
 if strcmp(get(hObject,'Tag'),'bvarglp')
        set(findall(handles.estpanel, '-property', 'enable'), 'enable', 'off')
               set(handles.inspf,'enable', 'off');  set(handles.inspf,'Value', 0);


        MMBEST.EstimationMethod = zeros(1,3);
        MMBEST.EstimationMethod(1,1) = 2;
        MMBEST.chosenmodels(1,2) = 1;
        MMBEST.benchmarklist1=[{MMBEST.benchmarklist(find(cellfun(@isempty,strfind(cellstr(MMBEST.benchmarklist),'_MH'))==0),:)};{'BVAR_GLP'}];
%         if (strcmp(MMBEST.benchmarklist1,'BVAR_MP')==0)
            set(handles.densitybenchmark,'String',cellstr(MMBEST.benchmarklist1));
%         end
 end

end
guidata(hObject, handles);


%CallBack for the first-vintage year


function firstvintyear_Callback(hObject, eventdata, handles)

global MMBEST;

a = get(hObject,'String');
h = str2double(a);
if (~isempty(h)&&~isnan(h))
    MMBEST.yearfirstvint = num2str(h);
%     MMBEST.yearfirstvintfc = num2str(h); set(handles.firstvintyearfc,'String',MMBEST.yearfirstvintfc);
    
else
    MMBEST.yearfirstvint = '2007';
    set(hObject,'string','2007');
end

%CallBack for the first-vintage quarter

function firstvintquarter_Callback(hObject, eventdata, handles)

global MMBEST;


str = get(hObject, 'String');
val = get(hObject,'Value');
set(handles.firstvintquarterfc,'value',val);

MMBEST.quarterfirstvintfc = str{val};
MMBEST.quarterfirstvint = str{val};

function lastvintyear_Callback(hObject, eventdata, handles)

global MMBEST;

a = get(hObject,'String');
h = str2double(a);
if (~isempty(h)&&~isnan(h))
    MMBEST.yearlastvint = num2str(h);
%     MMBEST.yearlastvintfc = num2str(h);  set(handles.lastvintyearfc,'String',MMBEST.yearlastvintfc);
else
    MMBEST.yearlastvint = '2007';
    set(hObject,'string','2007');
end

%CallBack for the first-vintage quarter


function lastvintquarter_Callback(hObject, eventdata, handles)

global MMBEST;



str = get(hObject, 'String');
val = get(hObject,'Value');
if MMBEST.yearlastvint == MMBEST.yearfirstvint
    if val < get(handles.firstvintquarter,'Value')
        set(handles.firstvintquarter,'Value',val);
        MMBEST.firstvintquarter = str{val};
    end
end
set(handles.lastvintquarterfc,'value',val);
MMBEST.quarterlastvint = str{val};
MMBEST.quarterlastvintfc = str{val};

%CallBack for first-observation year


function yearfirstobs_Callback(hObject, eventdata, handles)

global MMBEST;

h = str2double(get(hObject,'String'));

if (~isempty(h)&&~isnan(h))
    MMBEST.yearfirstobs = get(hObject,'String');
else
    MMBEST.yearfirstobs='1960';
    set(hObject,'string','1960');
end

%CallBack for first-observation quarter


function quarterfirstobs_Callback(hObject, eventdata, handles)

global MMBEST;

str = get(hObject, 'String');
val = get(hObject,'Value');
MMBEST.quarterfirstobs = str{val};



function firstvintyearfc_Callback(hObject, eventdata, handles)

global MMBEST;

a = get(hObject,'String');
h = str2double(a);
if (~isempty(h)&&~isnan(h))
    MMBEST.yearfirstvintfc = num2str(h);
else
    MMBEST.yearfirstvintfc = MMBEST.yearfirstobs;
    set(hObject,'string',MMBEST.yearfirstobs);
end

%CallBack for the first-vintage quarter for the forecasts/MMBEST.rmse
%estimation/graph
function firstvintquarterfc_Callback(hObject, eventdata, handles)

global MMBEST;

str = get(hObject, 'String');
val = get(hObject,'Value');

if (~isempty(str)&&~isnan(val))
    MMBEST.quarterfirstvintfc = str{val};
else
    MMBEST.quarterfirstvintfc = 'Q4';
    set(hObject,'string',MMBEST.quarterfirstvintfc);
end

function lastvintyearfc_Callback(hObject, eventdata, handles)

global MMBEST;

a = get(hObject,'String');
ewqh = str2double(a);
if (~isempty(h)&&~isnan(h))
    MMBEST.yearlastvintfc = num2str(h);
else
    MMBEST.yearlastvintfc = MMBEST.yearlastobs;
    set(hObject,'string',MMBEST.yearlastobs);
end

%CallBack for the first-vintage quarter for the forecasts/MMBEST.rmse
%estimation/graph


function lastvintquarterfc_Callback(hObject, eventdata, handles)

global MMBEST;

str = get(hObject, 'String');
val = get(hObject,'Value');
MMBEST.quarterlastvintfc = str{val};



%CallBack for first-observation quarter for the forecasts/MMBEST.rmse
%estimation/graph

function quarterlastobs_Callback(hObject, eventdata, handles)

global MMBEST;

str = get(hObject, 'String');
val = get(hObject,'Value');
MMBEST.quarterlastobs = str{val};


function CheckBoxes_Callback(hObject, eventdata, handles)
% Settings for the checkboxes on the interface based on 
% MMBEST.checkboxes = [ handles.bmodeestimation, handles.bmhestimation, handles.rmse, handles.inspf, handles.expseries, handles.plots];

global MMBEST;

if ~isempty(findobj(MMBEST.checkboxes,'Tag',get(hObject,'Tag')))
    switch find(MMBEST.checkboxes==findobj(MMBEST.checkboxes,'Tag',get(hObject,'Tag')))
        case 1
            MMBEST.EstimationMethod = zeros(1,3); % Estimation method 1 = BVAR, 2 Mode, 3 MH
            MMBEST.EstimationMethod(2) = get(hObject,'Value');
       if handles.bmhestimation.Value == 1
       set(handles.bmhestimation,'Value',0);
       set(findall(handles.mhsettingspanel, '-property', 'enable'), 'enable', 'off')  ;
       end
         case 2
            MMBEST.EstimationMethod = zeros(1,3); % Estimation method 1 = BVAR, 2 Mode, 3 MH
            MMBEST.EstimationMethod(3) = get(hObject,'Value');
            if get(hObject,'Value')
                set(findall(handles.mhsettingspanel, '-property', 'enable'), 'enable', 'on')  ;
                MMBEST.benchmarklist1=[{MMBEST.benchmarklist(find(cellfun(@isempty,strfind(cellstr(MMBEST.benchmarklist),'_MH'))==0),:)};{MMBEST.models(find(MMBEST.chosenmodels==1),:)}];
                %Reset default values
                MMBEST.chainslength = 50000; set(handles.chainslength,'String','50000');
                MMBEST.acceptance = 0.45; set(handles.acceptance,'String','0.45');

                set(handles.densitybenchmark,'String',cellstr(MMBEST.benchmarklist1));
            else
                set(findall(handles.mhsettingspanel, '-property', 'enable'), 'enable', 'off')
            end
             if handles.bmodeestimation.Value == 1
                set(handles.bmodeestimation,'Value',0);
             end
            
        case 3
            MMBEST.rmse = get(hObject,'Value');
            if get(hObject,'Value') && MMBEST.horizon <= MMBEST.default_horizon
                MMBEST.horizon = MMBEST.default_horizon;
                set(handles.taghorizon,'String',num2str(MMBEST.default_horizon));
            end
        case 4
            MMBEST.inspf = get(hObject,'Value');
        case 5
            MMBEST.expseriesvalue = get(hObject,'Value');
        case 6
            MMBEST.plots = get(hObject,'Value');
            if get(hObject,'Value') && MMBEST.horizon<=MMBEST.default_horizon
                MMBEST.horizon = MMBEST.default_horizon;
                set(handles.taghorizon,'String',num2str(MMBEST.default_horizon));
            end
            if get(hObject,'Value')
                 set(findall(handles.forecastchartpanel, '-property', 'enable'), 'enable', 'on')
                set(findall(handles.plotoptionspanel, '-property', 'enable'), 'enable', 'on')
            else
                set(findall(handles.forecastchartpanel, '-property', 'enable'), 'enable', 'off')
                set(findall(handles.plotoptionspanel, '-property', 'enable'), 'enable', 'off')
            end
    end
end

function all_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%CallBack for rolling window specification


function rw_Callback(hObject, eventdata, handles)

global MMBEST;

h = str2double(get(hObject,'String'));
if (~isempty(h)&&~isnan(h))
    MMBEST.windowlength = h*(h<101)+20*(h>100);
else
    MMBEST.windowlength = 80;
    set(hObject,'string',MMBEST.windowlength);
end


function taghorizon_Callback(hObject, eventdata, handles)

global MMBEST;

h=str2double(get(hObject,'String'));

if (~isempty(h)&&~isnan(h))
    if MMBEST.spf
        MMBEST.horizon = MMBEST.spf*MMBEST.default_horizon;
    else
        MMBEST.horizon =h;
    end
    set(hObject,'string',MMBEST.horizon)
else
    MMBEST.horizon = MMBEST.default_horizon;
    set(hObject,'string',MMBEST.default_horizon);
end


function numchains_Callback(hObject, eventdata, handles)

global MMBEST;

MMBEST.numchains = 2;
nc = str2double(get(hObject,'String'));
if (~isempty(nc)&&~isnan(nc))
    MMBEST.numchains = nc;
else
    set(hObject,'string',2);
end


function chainslength_Callback(hObject, eventdata, handles)

global MMBEST;

MMBEST.chainslength = 50000;
cl = str2double(get(hObject,'String'));
if (~isempty(cl)&&~isnan(cl))
    MMBEST.chainslength = cl;
else set(hObject,'string',50000);
end


function numburnin_Callback(hObject, eventdata, handles)
global MMBEST;

nbi = str2double(get(hObject,'String'));
if (~isempty(nbi)&&~isnan(nbi))
    MMBEST.numburnin = .3*((nbi<=0)+(nbi>1))+nbi*((nbi>0)+(nbi<=1));
else
    MMBEST.numburnin=.3;
    set(hObject,'string',0.3);
end



function acceptance_Callback(hObject, eventdata, handles)

global MMBEST;

MMBEST.acceptance = 0.25;

acc = str2double(get(hObject,'String'));
if (~isempty(acc)&&~isnan(acc))
    MMBEST.acceptance=acc;
else
    set(hObject,'string',0.45);
end


function benchmark_Callback(hObject, eventdata, handles)

global MMBEST;

switch get(hObject,'Value')
    case 1
        MMBEST.qh = 2;
    case 2
        MMBEST.qh = 4;
    case 3
        MMBEST.qh = 6;
end

% --- Executes when selected object is changed in datatypepanel.
function datatypepanel_SelectionChangeFcn(hObject, eventdata, handles)
global MMBEST;
switch get(hObject,'Tag')
    case 'realtime'
        MMBEST.real = get(hObject,'Value');
        MMBEST.rev = 0;
        set(handles.rmse,'enable', 'on')
        set(handles.spf,'enable', 'on')
        set(handles.benchmark,'enable', 'on')
        set(handles.text30,'enable', 'on')
    case 'revised'
        MMBEST.rev = get(hObject,'Value'); MMBEST.real = 0; MMBEST.spf = 0; MMBEST.rmse = 0;
        set(handles.rmse,'enable', 'off')
        set(handles.spf,'enable', 'off')
        set(handles.benchmark,'enable', 'off')
        set(handles.text30,'enable', 'off')
end

% --- Executes when selected object is changed in esttypepanel.
function esttypepanel_SelectionChangeFcn(hObject, eventdata, handles)
global MMBEST;
switch get(hObject,'Tag')
    case 'expseries'
        MMBEST.expseriesvalue = get(hObject,'Value');
        set(handles.yearfirstobs,'enable', 'on')
        set(handles.quarterfirstobs,'enable', 'on')
        set(handles.sampletxt1,'enable','on') 
        set(handles.sampletxt2,'enable','on')
        set(handles.sampletxt3,'enable','on')

        set(handles.rw,'enable', 'off')
        set(handles.sampletxt4,'enable','off')

        set(handles.inspf,'enable', 'on')
    case 'rollingw'
        MMBEST.expseriesvalue= 0;
        set(handles.rw,'enable', 'on')
        set(handles.sampletxt4,'enable','on') 

        
        set(handles.sampletxt1,'enable','off') 
        set(handles.sampletxt2,'enable','off')
        set(handles.sampletxt3,'enable','off')
        set(handles.yearfirstobs,'enable', 'off')
        set(handles.quarterfirstobs,'enable', 'off')
        

end



% --- Executes on button press in spf.
function spf_Callback(hObject, eventdata, handles)

global MMBEST;

if get(hObject,'Value')
    MMBEST.spf = get(hObject,'Value');
    MMBEST.horizon = 5;
    set(handles.taghorizon,'String','5');
else
    MMBEST.spf = get(hObject,'Value');
    MMBEST.horizon = MMBEST.default_horizon;
    set(handles.taghorizon,'String',num2str(MMBEST.default_horizon));
end





function GenerateDataIdentifier(hObject, eventdata, handles)
warning off
global modelvar nobservables OBSERVATION VINTAGES Start Last FirstObs  MMBEST;
statusbar(0, 'Busy...');
disp('Generating vintages...');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%  This part of the script initializes handle arrays for each group tabs in the GUI %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

OBSERVATION = []; VINTAGES = []; modelvar=zeros(1,nobservables);

Start = [MMBEST.yearfirstvint(3:end) MMBEST.quarterfirstvint];

Last = [MMBEST.yearlastvint(3:end) MMBEST.quarterlastvint];

FirstObs = [MMBEST.yearfirstobs  ':' MMBEST.quarterfirstobs];


thispath = cd;

%create a chronological line for vintages and observations
if MMBEST.region(find(MMBEST.chosenmodels>0))==1
    List_Observables='List_Observables_US';
else
%     List_Observables='List_Observables_EA';
end
[~,~,Obs]   = xlsread(List_Observables, 1);
[~,~,Obs_a] = xlsread(List_Observables, 2);
%  xlswrite(List_Observables,Obs, 1);
%  xlswrite(List_Observables,Obs_a, 2)
for i=3:size(Obs,1)
    MMBEST.observables{i-2} = Obs(i,3);
    MMBEST.variables{i-2} = Obs(i,2);
    MMBEST.variables_a{i-2} = Obs_a(i,2);
end

        str = date;
        for y = 1950:str2num(str([8:11]))+20
            for q = 1:4
                OBSERVATION = [OBSERVATION;[num2str(y) ':Q' num2str(q)]];
                a = num2str(y);
                VINTAGES = [VINTAGES;[a(end-1:end) 'Q' num2str(q)]];
            end
        end
        
        cd1 = cd;
        if ~MMBEST.inspf
            cd([MMBEST.DataArea '\Tranformed_Data\'])
        else
            cd([MMBEST.DataArea '\Tranformed_Data_SPF\'])
        end
        
        MMBEST.location = [cd '\'];
        
        cd(cd1)
        
        MMBEST.nvar = size(MMBEST.variables,2);
        try
            MMBEST.modelvars = MMBEST.model_observables(find(MMBEST.chosenmodels>0),:);
            MMBEST.modelvars = MMBEST.modelvars(1,:);
        catch
            MMBEST.modelvars = MMBEST.econometric_observables(find(MMBEST.chosenmodels(1,8:end)>0),:);
        end
        modelvars_index = (MMBEST.modelvars>0)';
        modelvars_index = modelvars_index(:,1);
        for i = 1:MMBEST.nvar
            
            if MMBEST.modelvars(i)
                [~,~,DATAMAT{i}] = xlsread([MMBEST.location cell2mat(MMBEST.variables{i})], 1);
                
                header = DATAMAT{i}(1,:); header_q = header(1);
                for ii = 2:size(header,2)
                    a = header(ii); a = a{1}; a = a(end-3:end);
                    header_q = [header_q;a ];
                end
                
                MMBEST.vintrev = MMBEST.horizon*((find(strcmp(header_q,  Last))+MMBEST.horizon+MMBEST.inspf)<size(DATAMAT{i},2))+1;
                
                s=find(strcmp(header_q,  Start))-(MMBEST.region(find(MMBEST.chosenmodels>0))==2);
                
                if MMBEST.vintrev>1
                    DATAMAT{i} = [[DATAMAT{i}(1,1) DATAMAT{i}(1,s:find(strcmp(header_q,  Last))+MMBEST.vintrev+MMBEST.inspf)];...
                        [DATAMAT{i}(find(strcmp(DATAMAT{i}(:,1), FirstObs)):end,1), DATAMAT{i}(find(strcmp(DATAMAT{i}(:,1), FirstObs)):end,...
                        s:find(strcmp(header_q,  Last))+MMBEST.vintrev+MMBEST.inspf)]];
                else
                    DATAMAT{i} = [[DATAMAT{i}(1,1) DATAMAT{i}(1,s:find(strcmp(header_q,  Last)))];...
                        [DATAMAT{i}(find(strcmp(DATAMAT{i}(:,1), FirstObs)):end,1), DATAMAT{i}(find(strcmp(DATAMAT{i}(:,1), FirstObs)):end,...
                        s:find(strcmp(header_q,  Last)))]];
                end
            else
                
                DATAMAT{i} = DATAMAT{i-1};
                
            end
        end
        
        if ~MMBEST.expseriesvalue
            if MMBEST.real
                if ~MMBEST.inspf
                    ManageFolder('DATADSGE_RolWin',MMBEST.DataArea)
                    cd1 = cd;
                    cd([MMBEST.DataArea '\DATADSGE_RolWin'])
                    MMBEST.location = cd ;
                    cd(cd1)
                    MMBEST.datalocation = MMBEST.location;
                    code_vintages
                    code_vintagesrev
                else
                    ManageFolder('DATADSGE_RolWinSPFNC',MMBEST.DataArea)
                    cd1 = cd;
                    cd([MMBEST.DataArea '\DATADSGE_RolWinSPFNC'])
                    MMBEST.location = cd ;
                    cd(cd1)
                    MMBEST.datalocation = MMBEST.location;
                    code_vintages
                    code_vintagesrev
                end
            else
                ManageFolder('DATADSGE_RolWinRev',MMBEST.DataArea)
                cd1 = cd;
                cd([MMBEST.DataArea '\DATADSGE_RolWinRev'])
                MMBEST.location = cd ;
                cd(cd1)
                MMBEST.datalocation = MMBEST.location;
                code_revised
            end
        elseif MMBEST.expseriesvalue
            if MMBEST.real
                if ~MMBEST.inspf
                    ManageFolder('DATADSGE_ExpWin',MMBEST.DataArea)
                    cd1 = cd;
                    cd([MMBEST.DataArea '\DATADSGE_ExpWin'])
                    MMBEST.location = cd ;
                    cd(cd1)
                    MMBEST.datalocation = MMBEST.location;
                    code_vintagesexp
                    code_vintagesrev
                else
                    ManageFolder('DATADSGE_ExpWinSPFNC',MMBEST.DataArea)
                    cd1 = cd;
                    cd([MMBEST.DataArea '\DATADSGE_ExpWinSPFNC'])
                    MMBEST.location = cd ;
                    cd(cd1)
                    MMBEST.datalocation = MMBEST.location;
                    code_vintagesexp
                    code_vintagesrev
                end
            else
                ManageFolder('DATADSGE_ExpWinRev',MMBEST.DataArea)
                cd1 = cd;
                cd([MMBEST.DataArea '\DATADSGE_ExpWinRev'])
                MMBEST.location = cd ;
                cd(cd1)
                MMBEST.datalocation = MMBEST.location;
                code_revised
            end
        end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Main Function %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pushbutton1_Callback(hObject, eventdata, handles)
global MMBEST ;
MMBEST.IndVec= [];
MMBEST.thispath0 = cd;
if MMBEST.EstimationMethod(3) == 1 && isempty(MMBEST.densitymodel)
    MMBEST.densitymodel = [deblank(MMBEST.models((MMBEST.chosenmodels == 1),:)) '_MHforecast'];
end
if isempty(MMBEST.chosenmodels>0)
    disp('Please choose models.')
elseif isempty(MMBEST.EstimationMethod>0)
    disp('Please choose an estimation method.')
else
    GenerateDataIdentifier(hObject, eventdata, handles);        
    vintlist = ls([MMBEST.datalocation '\ExcelFileVintages']); vintlist = vintlist(4:end,:); MMBEST.Identifier=[];
        
    for vint = 1:size(vintlist,1)
        a = deblank(vintlist(vint,:));
        m = size(a,2);
        MMBEST.Identifier = [MMBEST.Identifier;a(m-8:m-4)];
    end
    
        vintlist = ls([MMBEST.datalocation '\ExcelFileRev']); vintlist = vintlist(4:end,:); MMBEST.IdentifierBenchmark = [];

     for vint = 1:size(vintlist,1)
        a = deblank(vintlist(vint,:));
        m = size(a,2);
        if ~isempty(strmatch(a(m-8:m-4),MMBEST.Identifier))
            MMBEST.IdentifierBenchmark = [MMBEST.IdentifierBenchmark;a(m-8:m-4)];
        end
     end
    
   
   
    if MMBEST.spf
        vintlistSPF = ls([MMBEST.DataArea '\SPF\ExcelFileSPF']);
        vintlistSPF = vintlistSPF(4:end,:);
        MMBEST.IdentifierBenchmarkSPF = [];
        for vint = 1:size(vintlistSPF,1)
            a = deblank(vintlistSPF(vint,:));
            m = size(a,2);
            if ~isempty(strmatch(a(m-8:m-4),MMBEST.IdentifierBenchmark))
                MMBEST.IdentifierBenchmarkSPF = [MMBEST.IdentifierBenchmarkSPF;a(m-8:m-4)];
            end
        end
        MMBEST.IndVec = zeros(size(MMBEST.IdentifierBenchmark,1),1);
        for vint = 1:size(MMBEST.IdentifierBenchmark,1)
            MMBEST.IndVec(vint) =~ isempty(strmatch(MMBEST.IdentifierBenchmark(vint),MMBEST.IdentifierBenchmarkSPF));
        end
    end
    cd('..\ALGORITHMS')
    run Main
    path_ = cd;
    cd('..\MODELS')
    load('variables.mat');
    cd(path_)
    if basics.plots
        Periods = periods(basics);
        forecastchart
    end
    if basics.computeRMSE
        Periods = periods(basics);
        RMSE
    end
end
uiresume

% --- Executes on selection change in statistics.
function statistics_Callback(hObject, eventdata, handles)
global MMBEST
str = get(hObject,'String');
val = get(hObject,'Value');
MMBEST.statistics  = str{val};

% --- Executes on selection change in densitybenchmark.
function densitybenchmark_Callback(hObject, eventdata, handles)
global MMBEST;
%MMBEST.densitymodel = str2double(get(hObject,'String'))
str = get(hObject,'String');
val = get(hObject,'Value');
nmod=size(str,1);
if MMBEST.EstimationMethod(3) ~= 1
    MMBEST.densitymodel = str(val,:);
else
    if isempty(cell2mat(strfind(str(val,:),'_MHforecast')))
        if isempty(cell2mat(strfind(str(val,:),'BVAR')))
            MMBEST.densitymodel = [deblank(str{val}) '_MHforecast'];
        else
            MMBEST.densitymodel = str(val,:);
        end
    else
        MMBEST.densitymodel = str(val,:);
    end
end


% --- Executes on button press in bvarpriors.
function bvarpriors_Callback(hObject, eventdata, handles)
% hObject    handle to bvarpriors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bvarpiors
uiwait
