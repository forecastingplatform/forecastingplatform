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

% Last Modified by GUIDE v2.5 23-May-2019 22:24:10

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
global basics;

basics.modelslist = [handles.bvarmp, handles.bvarglp, handles.ussw07, handles.usdngs14, handles.usnkbas, handles.dsgetest, handles.nk_ds04, handles.nk_ww11, handles.usfrbedo08, handles.usdngs14sw, handles.ussw07bgg];

basics.models = char([
    'BVAR_MP    '; 
    'BVAR_GLP   '; 
    'US_SW07    '; 
    'US_DNGS14  '; 
    'NK_RW97    '; 
    'DSGE_TEST  '; 
    'NK_DS04    '; 
    'NK_WW11    ';
    'US_FRBEDO08';
    'US_DNGS14SW';
    'US_SW07_BGG']);

basics.region = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]; % 1 for the US data (will add the Euro Area data in future releases)

%% List of observables 
% Set 1 in the column if it enters as an observable variable, otherwise 0.
%  According to List_Observables_US.xls, the variable in the model's varobs 
%  should be named according to Column B in the excel:
%1.     xgdp_a_obs
%2.     pgdp_a_obs
%3.     rff_a_obs
%4.     pcer_a_obs
%5.     fpi_a_obs
%6.     wage_obs
%7.     hours_obs
%8.     cp_q_obs

basics.model_observables(1,:) = [1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0]; % BVAR_MP
basics.model_observables(2,:) = [1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0]; % BVAR_GLP
basics.model_observables(3,:) = [1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]; % SW07
basics.model_observables(4,:) = [1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0]; % DNGS14
basics.model_observables(5,:)=  [1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; % NK_BAS
basics.model_observables(6,:) = [1 1 1 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0]; % DSGE_TEST
basics.model_observables(7,:)=  [1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; % NK_DS04
basics.model_observables(8,:)=  [1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; % NK_WW11
basics.model_observables(9,:)=  [1 1 1 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1]; % US_FRBEDO08
basics.model_observables(10,:)= [1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]; % US_DNGS14_SW
basics.model_observables(11,:)= [1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]; % US_SW07_BGG


%%
% Title declaration:
basics.charttitle = char([...
    '             Forecasts with BVAR with Minnesta prior            ';
    '     Forecasts with BVAR with Giannone Lenza Primiceri prior    ';
    '         Forecasts from Smets Wouters (2007) US model           ';
    'Forecasts with Del Negro Schorfheide Giannoni with credit spread';
    '               Forecasts from Small NK US model                 ';
    ' Forecasts from the Small NK model with BGG financial frictions ';
    '      Forecasts from Del Negro and Schorfheide (2004) model     ';
    '        Forecasts from Wieland and Wolters (2011) model         '; 
    '                  Forecasts from FRB/EDO model                  '; 
    '  Forecasts from Del Negro et al. (2014) w/o financial friction ';
    ' Forecasts from Smets Wouters (2007) with BGG financial friction'; 
    ]);

%% Interface settings
% Create chosenmodel variable - the model is 1 to be estimated. Its
% location is linked to the handles in basics.modelslist. EG: Choosing the
% first model is will estimate the BVAR MP.
for i = 1:size(basics.modelslist,2)
    basics.chosenmodels(i) = 0;
end
% Checkboxes 
basics.checkboxes = [handles.bmodeestimation, handles.bmhestimation, handles.rmse, handles.inspf, handles.plots, handles.fnc, handles.irf, handles.hvd];
%Setting default values for the vintages and graphs
basics.quarterfirstvint = 'Q4'; % set(handles.firstvintquarter,'string',basics.quarterfirstvint);
basics.yearfirstvint = '2007';  set(handles.firstvintyear,'String',basics.yearfirstvint);
basics.quarterlastvint = 'Q4'; % set(handles.lastvintquarter,'string',basics.quarterlastvint);
basics.yearlastvint = '2007';   set(handles.lastvintyear,'String',basics.yearlastvint); 
basics.quarterfirstobs = 'Q1'; basics.yearfirstobs = '1960';  set(handles.yearfirstobs,'String',basics.yearfirstobs);
basics.quarterfirstvintfc = 'Q4'; basics.yearfirstvintfc = '2007'; set(handles.firstvintyearfc,'String',basics.yearfirstvintfc);
basics.quarterlastvintfc = 'Q4';  basics.yearlastvintfc = '2007';  set(handles.lastvintyearfc,'String',basics.yearlastvintfc);
basics.yearlastobs = '2017'; basics.quarterlastobs = 'Q4';

basics.benchmarklist = ls('..//OUTPUT//USMODELS');basics.benchmarklist = basics.benchmarklist (3:end,:);
set(handles.densitybenchmark,'String',basics.benchmarklist(find(cellfun(@isempty,strfind(cellstr(basics.benchmarklist),'_MH'))==0),:));
basics.deletefiles = 0; basics.DataArea = '..//DATA//USDATA';
basics.default_horizon = 5; basics.forecasthorizon = basics.default_horizon; basics.qh = 2; basics.expseriesvalue = 1; basics.windowlength = 80;
basics.inspf = 0; basics.fnc = 0; basics.acceptance = 0.25; basics.numchains = 2; basics.chainslength = 50000; basics.numburnin =.3 ; basics.plots = 0;
basics.real = 1; basics.rev = 0; basics.vintrev = 0; basics.create_new_vintages = 1; basics.computeRMSE = 0; basics.bvarNdraws = 20000;
basics.gvar=0;
basics.densitymodel=[];
basics.statistics='Mean';
basics.bvarmpriors=[3, 0.5, 5, 2, 1, 0, 0 ];
basics.irf = 0; basics.hvd = 0; basics.irf_periods = 10; basics.hvd_periods = 10; basics.hvd_absolute = 1;
%Disable UI elements when opening
set(findall(handles.mhsettingspanel, '-property', 'enable'), 'enable', 'off')
set(findall(handles.plotoptionspanel, '-property', 'enable'), 'enable', 'off')
set(findall(handles.forecastchartpanel, '-property', 'enable'), 'enable', 'off')
set(findall(handles.estpanel, '-property', 'enable'), 'enable', 'off') %Setting the estimation methods grey unless one clicks into it
set(findall(handles.bvarpriors, '-property', 'enable'), 'enable', 'off')
set(findall(handles.esttypepanel, '-property', 'enable'),'enable', 'on')
set(findall(handles.datatypepanel, '-property', 'enable'),'enable', 'on')
set(handles.rw,'enable', 'off')
set(findall(handles.plottingpanel, '-property', 'enable'),'enable', 'off')
%Disable UI elements when opening
set(basics.modelslist,'Value',0);
set(findall(handles.estpanel, '-property', 'enable'), 'Value', 0);
set(gcf,'units','normalized','outerposition',[0 0 0.8 0.8])

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

global basics;

for i = 1:size(basics.modelslist,2)
    basics.chosenmodels(i) = 0;
end
val=get(hObject,'Value');
set(basics.modelslist,'Value',0)
set(findall(handles.bvarpriors, '-property', 'enable'), 'enable', 'off')
set(handles.inspf,'enable', 'on');  set(handles.inspf,'Value', 0);  
set(handles.fnc,'enable', 'on');  set(handles.fnc,'Value', 0); 
set(findall(handles.estpanel, '-property', 'enable'), 'enable', 'on')

if ~isempty(findobj(basics.modelslist,'Tag',get(hObject,'Tag')))
    basics.chosenmodels(find(basics.modelslist==findobj(basics.modelslist,'Tag',get(hObject,'Tag')))) = val;
    set(basics.modelslist(find(basics.modelslist==findobj(basics.modelslist,'Tag',get(hObject,'Tag')))),'Value',val)
    basics.spf = [];
        
    %%
        set(findall(handles.estpanel, '-property', 'enable'), 'enable', 'on')
        set(findall(handles.mhsettingspanel, '-property', 'enable'), 'enable', 'off')
        set(findall(handles.plottingpanel, '-property', 'enable'), 'enable', 'off');
        set(handles.irf,'Value', 0);
        set(handles.hvd,'Value', 0);
        basics.irf = 0; basics.hvd = 0;
        basics.DataArea = '..\DATA\USDATA';
        if find(basics.modelslist==findobj(basics.modelslist,'Tag',get(hObject,'Tag'))) == 2
            set(handles.spf, 'enable', 'on')
            set(handles.inspf, 'enable', 'on')
            set(handles.fnc,'enable', 'on');  
        end
        basics.benchmarklist = ls('..//OUTPUT//USMODELS');
        basics.benchmarklist = basics.benchmarklist(3:end,:);
        set(handles.densitybenchmark,'String',basics.benchmarklist(find(cellfun(@isempty,strfind(cellstr(basics.benchmarklist),'_MH'))==0),:));
        basics.region(1,1:2) = 1;
    
      if strcmp(get(hObject,'Tag'),'bvarmp')
        set(findall(handles.bvarpriors, '-property', 'enable'), 'enable', 'on')

               set(handles.inspf,'enable', 'off');  set(handles.inspf,'Value', 0);
               set(handles.fnc,'enable', 'off');  set(handles.fnc,'Value', 0); 
               set(findall(handles.estpanel, '-property', 'enable'), 'enable', 'off')
        if ~get(hObject,'Value')
                set(findall(handles.bvarpriors, '-property', 'enable'), 'enable', 'off')
               set(handles.inspf,'enable', 'on');    
               set(handles.fnc,'enable', 'on'); 
        end
        basics.EstimationMethod = zeros(1,3);
        basics.EstimationMethod(1,1) = 1;
        basics.chosenmodels(1,1) = 1;
        basics.benchmarklist1=[{basics.benchmarklist(find(cellfun(@isempty,strfind(cellstr(basics.benchmarklist),'_MH'))==0),:)};{'BVAR_MP'}];
        set(handles.densitybenchmark,'String',cellstr(basics.benchmarklist1));

     end
 
 if strcmp(get(hObject,'Tag'),'bvarglp')
        set(findall(handles.estpanel, '-property', 'enable'), 'enable', 'off')
               set(handles.inspf,'enable', 'off');  set(handles.inspf,'Value', 0);
              set(handles.fnc,'enable', 'off');  set(handles.inspf,'Value', 0); 

        basics.EstimationMethod = zeros(1,3);
        basics.EstimationMethod(1,1) = 2;
        basics.chosenmodels(1,2) = 1;
        basics.benchmarklist1=[{basics.benchmarklist(find(cellfun(@isempty,strfind(cellstr(basics.benchmarklist),'_MH'))==0),:)};{'BVAR_GLP'}];
%         if (strcmp(basics.benchmarklist1,'BVAR_MP')==0)
            set(handles.densitybenchmark,'String',cellstr(basics.benchmarklist1));
%         end
 end

end
guidata(hObject, handles);


%CallBack for the first-vintage year


function firstvintyear_Callback(hObject, eventdata, handles)

global basics;

a = get(hObject,'String');
h = str2double(a);
if (~isempty(h)&&~isnan(h))
    basics.yearfirstvint = num2str(h);
    basics.yearfirstvintfc = num2str(h); set(handles.firstvintyearfc,'String',basics.yearfirstvintfc);
    
else
    basics.yearfirstvint = '2007';
    set(hObject,'string','2007');
end

%CallBack for the first-vintage quarter

function firstvintquarter_Callback(hObject, eventdata, handles)

global basics;


str = get(hObject, 'String');
val = get(hObject,'Value');
set(handles.firstvintquarterfc,'value',val);

basics.quarterfirstvintfc = str{val};
basics.quarterfirstvint = str{val};

function lastvintyear_Callback(hObject, eventdata, handles)

global basics;

a = get(hObject,'String');
h = str2double(a);
if (~isempty(h)&&~isnan(h))
    basics.yearlastvint = num2str(h);
    basics.yearlastvintfc = num2str(h);  set(handles.lastvintyearfc,'String',basics.yearlastvintfc);
else
    basics.yearlastvint = '2007';
    set(hObject,'string','2007');
end

%CallBack for the first-vintage quarter


function lastvintquarter_Callback(hObject, eventdata, handles)

global basics;

str = get(hObject, 'String');
val = get(hObject,'Value');
if basics.yearlastvint == basics.yearfirstvint
    if val < get(handles.firstvintquarter,'Value')
        set(handles.firstvintquarter,'Value',val);
        basics.firstvintquarter = str{val};
    end
end
set(handles.lastvintquarterfc,'value',val);
basics.quarterlastvint = str{val};
basics.quarterlastvintfc = str{val};

%CallBack for first-observation year


function yearfirstobs_Callback(hObject, eventdata, handles)

global basics;

h = str2double(get(hObject,'String'));

if (~isempty(h)&&~isnan(h))
    basics.yearfirstobs = get(hObject,'String');
else
    basics.yearfirstobs='1960';
    set(hObject,'string','1960');
end

%CallBack for first-observation quarter


function quarterfirstobs_Callback(hObject, eventdata, handles)

global basics;

str = get(hObject, 'String');
val = get(hObject,'Value');
basics.quarterfirstobs = str{val};



function firstvintyearfc_Callback(hObject, eventdata, handles)

global basics;

a = get(hObject,'String');
h = str2double(a);
if (~isempty(h)&&~isnan(h))
    basics.yearfirstvintfc = num2str(h);
else
    basics.yearfirstvintfc = basics.yearfirstobs;
    set(hObject,'string',basics.yearfirstobs);
end

%CallBack for the first-vintage quarter for the forecasts/basics.computeRMSE
%estimation/graph
function firstvintquarterfc_Callback(hObject, eventdata, handles)

global basics;

str = get(hObject, 'String');
val = get(hObject,'Value');

if (~isempty(str)&&~isnan(val))
    basics.quarterfirstvintfc = str{val};
else
    basics.quarterfirstvintfc = 'Q4';
    set(hObject,'string',basics.quarterfirstvintfc);
end

function lastvintyearfc_Callback(hObject, eventdata, handles)

global basics;

a = get(hObject,'String');
ewqh = str2double(a);
if (~isempty(h)&&~isnan(h))
    basics.yearlastvintfc = num2str(h);
else
    basics.yearlastvintfc = basics.yearlastobs;
    set(hObject,'string',basics.yearlastobs);
end

%CallBack for the first-vintage quarter for the forecasts/basics.computeRMSE
%estimation/graph


function lastvintquarterfc_Callback(hObject, eventdata, handles)

global basics;

str = get(hObject, 'String');
val = get(hObject,'Value');
basics.quarterlastvintfc = str{val};



%CallBack for first-observation quarter for the forecasts/basics.computeRMSE
%estimation/graph

function quarterlastobs_Callback(hObject, eventdata, handles)

global basics;

str = get(hObject, 'String');
val = get(hObject,'Value');
basics.quarterlastobs = str{val};


function CheckBoxes_Callback(hObject, eventdata, handles)
% Settings for the checkboxes on the interface based on 
% basics.checkboxes = [ handles.bmodeestimation, handles.bmhestimation, handles.rmse, handles.inspf, handles.expseries, handles.plots];

global basics;

if ~isempty(findobj(basics.checkboxes,'Tag',get(hObject,'Tag')))
    switch find(basics.checkboxes==findobj(basics.checkboxes,'Tag',get(hObject,'Tag')))
        case 1
            basics.EstimationMethod = zeros(1,3); % Estimation method 1 = BVAR, 2 Mode, 3 MH
            basics.EstimationMethod(2) = get(hObject,'Value');
       if handles.bmhestimation.Value == 1
       set(handles.bmhestimation,'Value',0);
       set(findall(handles.mhsettingspanel, '-property', 'enable'), 'enable', 'off');
       set(findall(handles.plottingpanel, '-property', 'enable'), 'enable', 'off');
       set(handles.irf,'Value', 0);
       set(handles.hvd,'Value', 0);
       basics.irf = 0; basics.hvd = 0;
       end
         case 2
            basics.EstimationMethod = zeros(1,3); % Estimation method 1 = BVAR, 2 Mode, 3 MH
            basics.EstimationMethod(3) = get(hObject,'Value');
            if get(hObject,'Value')
                set(findall(handles.mhsettingspanel, '-property', 'enable'), 'enable', 'on');
                set(findall(handles.plottingpanel, '-property', 'enable'), 'enable', 'on');
                basics.benchmarklist1=[{basics.benchmarklist(find(cellfun(@isempty,strfind(cellstr(basics.benchmarklist),'_MH'))==0),:)};{basics.models(find(basics.chosenmodels==1),:)}];
                %Reset default values
                basics.chainslength = 50000; set(handles.chainslength,'String','50000');
                basics.acceptance = 0.45; set(handles.acceptance,'String','0.45');

                set(handles.densitybenchmark,'String',cellstr(basics.benchmarklist1));
            else
                set(findall(handles.mhsettingspanel, '-property', 'enable'), 'enable', 'off')
                set(findall(handles.plottingpanel, '-property', 'enable'), 'enable', 'off');
                set(handles.irf,'Value', 0);
                set(handles.hvd,'Value', 0);
                basics.irf = 0; basics.hvd = 0;
            end
             if handles.bmodeestimation.Value == 1
                set(handles.bmodeestimation,'Value',0);
             end
            
        case 3
            basics.computeRMSE = get(hObject,'Value');
            if get(hObject,'Value') && basics.forecasthorizon <= basics.default_horizon
                basics.forecasthorizon = basics.default_horizon;
                set(handles.taghorizon,'String',num2str(basics.default_horizon));
            end
        case 4
            basics.inspf = get(hObject,'Value');
            set(handles.fnc,'Value', 0); basics.fnc = 0;
        case 5
            basics.plots = get(hObject,'Value');
            if get(hObject,'Value') && basics.forecasthorizon<=basics.default_horizon
                basics.forecasthorizon = basics.default_horizon;
                set(handles.taghorizon,'String',num2str(basics.default_horizon));
            end
            if get(hObject,'Value')
                 set(findall(handles.forecastchartpanel, '-property', 'enable'), 'enable', 'on')
                set(findall(handles.plotoptionspanel, '-property', 'enable'), 'enable', 'on')
            else
                set(findall(handles.forecastchartpanel, '-property', 'enable'), 'enable', 'off')
                set(findall(handles.plotoptionspanel, '-property', 'enable'), 'enable', 'off')
            end
        case 6  % Use Real time observations of financial variables as nowcasts
               basics.fnc = get(hObject,'Value');
               set(handles.inspf,'Value', 0); basics.inspf = 0;
        case 7 % impulse response functions
               basics.irf = get(hObject,'Value');
        case 8 % historical variance decompositions
               basics.hvd = get(hObject,'Value');
    end
end

function all_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%CallBack for rolling window specification


function rw_Callback(hObject, eventdata, handles)

global basics;
h = str2double(get(hObject,'String'));
if (~isempty(h)&&~isnan(h))
    basics.windowlength = h*(h<101)+20*(h>100);
else
    basics.windowlength = 80;
    set(hObject,'string',basics.windowlength);
end


function taghorizon_Callback(hObject, eventdata, handles)

global basics;

h=str2double(get(hObject,'String'));

if (~isempty(h)&&~isnan(h))
    if basics.spf
        basics.forecasthorizon = basics.spf*basics.default_horizon;
    else
        basics.forecasthorizon =h;
    end
    set(hObject,'string',basics.forecasthorizon)
else
    basics.forecasthorizon = basics.default_horizon;
    set(hObject,'string',basics.default_horizon);
end


function numchains_Callback(hObject, eventdata, handles)

global basics;

basics.numchains = 2;
nc = str2double(get(hObject,'String'));
if (~isempty(nc)&&~isnan(nc))
    basics.numchains = nc;
else
    set(hObject,'string',2);
end


function chainslength_Callback(hObject, eventdata, handles)

global basics;

basics.chainslength = 50000;
cl = str2double(get(hObject,'String'));
if (~isempty(cl)&&~isnan(cl))
    basics.chainslength = cl;
else set(hObject,'string',50000);
end


function numburnin_Callback(hObject, eventdata, handles)
global basics;

nbi = str2double(get(hObject,'String'));
if (~isempty(nbi)&&~isnan(nbi))
    basics.numburnin = .3*((nbi<=0)+(nbi>1))+nbi*((nbi>0)+(nbi<=1));
else
    basics.numburnin=.3;
    set(hObject,'string',0.3);
end



function acceptance_Callback(hObject, eventdata, handles)

global basics;

basics.acceptance = 0.25;

acc = str2double(get(hObject,'String'));
if (~isempty(acc)&&~isnan(acc))
    basics.acceptance=acc;
else
    set(hObject,'string',0.45);
end


function benchmark_Callback(hObject, eventdata, handles)

global basics;

switch get(hObject,'Value')
    case 1
        basics.qh = 2;
    case 2
        basics.qh = 4;
    case 3
        basics.qh = 6;
end

% --- Executes when selected object is changed in datatypepanel.
function datatypepanel_SelectionChangeFcn(hObject, eventdata, handles)
global basics;
switch get(hObject,'Tag')
    case 'realtime'
        basics.real = get(hObject,'Value');
        basics.rev = 0;
        set(handles.rmse,'enable', 'on')
        set(handles.spf,'enable', 'on')
        set(handles.benchmark,'enable', 'on')
        set(handles.text30,'enable', 'on')
    case 'revised'
        basics.rev = get(hObject,'Value'); basics.real = 0; basics.spf = 0; basics.computeRMSE = 0;
        set(handles.rmse,'enable', 'off')
        set(handles.spf,'enable', 'off')
        set(handles.benchmark,'enable', 'off')
        set(handles.text30,'enable', 'off')
end

% --- Executes when selected object is changed in esttypepanel.
function esttypepanel_SelectionChangeFcn(hObject, eventdata, handles)
global basics;
switch get(hObject,'Tag')
    case 'expseries'
        basics.expseriesvalue = get(hObject,'Value');
        set(handles.yearfirstobs,'enable', 'on')
        set(handles.quarterfirstobs,'enable', 'on')
        set(handles.sampletxt1,'enable','on') 
        set(handles.sampletxt2,'enable','on')
        set(handles.sampletxt3,'enable','on')

        set(handles.rw,'enable', 'off')
        set(handles.sampletxt4,'enable','off')

        set(handles.inspf,'enable', 'on')
    case 'rollingw'
        basics.expseriesvalue= 0;
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

global basics;

if get(hObject,'Value')
    basics.spf = get(hObject,'Value');
    basics.forecasthorizon = 5;
    set(handles.taghorizon,'String','5');
else
    basics.spf = get(hObject,'Value');
    basics.forecasthorizon = basics.default_horizon;
    set(handles.taghorizon,'String',num2str(basics.default_horizon));
end





function GenerateDataIdentifier(hObject, eventdata, handles)
warning off
global modelvar nobservables OBSERVATION VINTAGES Start Last FirstObs  basics;
statusbar(0, 'Busy...');
disp('Generating vintages...');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%  This part of the script initializes handle arrays for each group tabs in the GUI %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

OBSERVATION = []; VINTAGES = []; modelvar=zeros(1,nobservables);

Start = [basics.yearfirstvint(3:end) basics.quarterfirstvint];

Last = [basics.yearlastvint(3:end) basics.quarterlastvint];

FirstObs = [basics.yearfirstobs  ':' basics.quarterfirstobs];


thispath = cd;

%create a chronological line for vintages and observations
if basics.region(find(basics.chosenmodels>0))==1
    List_Observables='List_Observables_US';
else
%     List_Observables='List_Observables_EA';
end
[~,~,Obs]   = xlsread(List_Observables, 1);
[~,~,Obs_a] = xlsread(List_Observables, 2);
%  xlswrite(List_Observables,Obs, 1);
%  xlswrite(List_Observables,Obs_a, 2)
for i=3:size(Obs,1)
    basics.observables{i-2} = Obs(i,3);
    basics.variables{i-2} = Obs(i,2);
    basics.variables_a{i-2} = Obs_a(i,2);
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
        if ~basics.inspf
            cd([basics.DataArea '//Tranformed_Data//'])
        else
            cd([basics.DataArea '//Tranformed_Data_SPF//'])
        end
        
        basics.location = [cd '\'];
        
        cd(cd1)
        
        basics.nvar = size(basics.variables,2);
        try
            basics.modelvars = basics.model_observables(find(basics.chosenmodels>0),:);
            basics.modelvars = basics.modelvars(1,:);
        catch
            basics.modelvars = basics.econometric_observables(find(basics.chosenmodels(1,8:end)>0),:);
        end
        modelvars_index = (basics.modelvars>0)';
        modelvars_index = modelvars_index(:,1);
        for i = 1:basics.nvar
            
            if basics.modelvars(i)
                [~,~,DATAMAT{i}] = xlsread([basics.location cell2mat(basics.variables{i})], 1);
                
                header = DATAMAT{i}(1,:); header_q = header(1);
                for ii = 2:size(header,2)
                    a = header(ii); a = a{1}; a = a(end-3:end);
                    header_q = [header_q;a ];
                end
                
                basics.vintrev = basics.forecasthorizon*((find(strcmp(header_q,  Last))+basics.forecasthorizon+(basics.inspf+basics.fnc))<size(DATAMAT{i},2))+1;
                
                s=find(strcmp(header_q,  Start))-(basics.region(find(basics.chosenmodels>0))==2);
                
                if basics.vintrev>1
                    DATAMAT{i} = [[DATAMAT{i}(1,1) DATAMAT{i}(1,s:find(strcmp(header_q,  Last))+basics.vintrev+basics.inspf+basics.fnc)];...
                        [DATAMAT{i}(find(strcmp(DATAMAT{i}(:,1), FirstObs)):end,1), DATAMAT{i}(find(strcmp(DATAMAT{i}(:,1), FirstObs)):end,...
                        s:find(strcmp(header_q,  Last))+basics.vintrev+basics.inspf+basics.fnc)]];
                else
                    DATAMAT{i} = [[DATAMAT{i}(1,1) DATAMAT{i}(1,s:find(strcmp(header_q,  Last)))];...
                        [DATAMAT{i}(find(strcmp(DATAMAT{i}(:,1), FirstObs)):end,1), DATAMAT{i}(find(strcmp(DATAMAT{i}(:,1), FirstObs)):end,...
                        s:find(strcmp(header_q,  Last)))]];
                end
            else
                
                DATAMAT{i} = DATAMAT{i-1};
                
            end
        end
        
        if ~basics.expseriesvalue
            if basics.real
                if (~basics.inspf ||  ~basics.fnc)
                    ManageFolder('DATADSGE_RolWin',basics.DataArea)
                    cd1 = cd;
                    cd([basics.DataArea '\DATADSGE_RolWin'])
                    basics.location = cd ;
                    cd(cd1)
                    basics.datalocation = basics.location;
                    code_vintages
                    code_vintagesrev
                else
                    ManageFolder('DATADSGE_RolWinSPFNC',basics.DataArea)
                    cd1 = cd;
                    cd([basics.DataArea '\DATADSGE_RolWinSPFNC'])
                    basics.location = cd ;
                    cd(cd1)
                    basics.datalocation = basics.location;
                    code_vintages
                    code_vintagesrev
                end
            else
                ManageFolder('DATADSGE_RolWinRev',basics.DataArea)
                cd1 = cd;
                cd([basics.DataArea '\DATADSGE_RolWinRev'])
                basics.location = cd ;
                cd(cd1)
                basics.datalocation = basics.location;
                code_revised
                code_vintagesrev
            end
        elseif basics.expseriesvalue
            if basics.real
                if (~basics.inspf ||  ~basics.fnc)
                    ManageFolder('DATADSGE_ExpWin',basics.DataArea)
                    cd1 = cd;
                    cd([basics.DataArea '\DATADSGE_ExpWin'])
                    basics.location = cd ;
                    cd(cd1)
                    basics.datalocation = basics.location;
                    code_vintagesexp
                    code_vintagesrev
                else
                    ManageFolder('DATADSGE_ExpWinSPFNC',basics.DataArea)
                    cd1 = cd;
                    cd([basics.DataArea '\DATADSGE_ExpWinSPFNC'])
                    basics.location = cd ;
                    cd(cd1)
                    basics.datalocation = basics.location;
                    code_vintagesexp
                    code_vintagesrev
                end
            else
                ManageFolder('DATADSGE_ExpWinRev',basics.DataArea)
                cd1 = cd;
                cd([basics.DataArea '\DATADSGE_ExpWinRev'])
                basics.location = cd ;
                cd(cd1)
                basics.datalocation = basics.location;
                code_revised
                code_vintagesrev
            end
        end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Main Function %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pushbutton1_Callback(hObject, eventdata, handles)
global basics;

basics.IndVec= [];
basics.thispath0 = cd;
if basics.EstimationMethod(3) == 1 && isempty(basics.densitymodel)
    basics.densitymodel = [deblank(basics.models((basics.chosenmodels == 1),:)) '_MHforecast'];
end
if isempty(basics.chosenmodels>0)
    disp('Please choose models.')
elseif isempty(basics.EstimationMethod>0)
    disp('Please choose an estimation method.')
else
    GenerateDataIdentifier(hObject, eventdata, handles);        
    vintlist = ls([basics.datalocation '\ExcelFileVintages']); vintlist = vintlist(4:end,:); basics.vintage=[];
        
    for vint = 1:size(vintlist,1)
        a = deblank(vintlist(vint,:));
        m = size(a,2);
        basics.vintage = [basics.vintage;a(m-8:m-4)];
    end
    
        vintlist = ls([basics.datalocation '\ExcelFileRev']); vintlist = vintlist(4:end,:); basics.benchmarkvintage = [];

     for vint = 1:size(vintlist,1)
        a = deblank(vintlist(vint,:));
        m = size(a,2);
        if ~isempty(strmatch(a(m-8:m-4),basics.vintage))
            basics.benchmarkvintage = [basics.benchmarkvintage;a(m-8:m-4)];
        end
     end

    if basics.spf
        vintlistSPF = ls([basics.DataArea '//SPF//ExcelFileSPF']);
        vintlistSPF = vintlistSPF(4:end,:);
        basics.benchmarkvintageSPF = [];
        for vint = 1:size(vintlistSPF,1)
            a = deblank(vintlistSPF(vint,:));
            m = size(a,2);
            if ~isempty(strmatch(a(m-8:m-4),basics.benchmarkvintage))
                basics.benchmarkvintageSPF = [basics.benchmarkvintageSPF;a(m-8:m-4)];
            end
        end
        basics.IndVec = zeros(size(basics.benchmarkvintage,1),1);
        for vint = 1:size(basics.benchmarkvintage,1)
            basics.IndVec(vint) =~ isempty(strmatch(basics.benchmarkvintage(vint),basics.benchmarkvintageSPF));
        end
    end
    cd('..//ALGORITHMS')
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
    if basics.irf
        plot_irf
    end
    if basics.hvd
        plot_hvd
    end
end
disp('Forecast exercise completed without errors.');
% uiresume

% --- Executes on selection change in statistics.
function statistics_Callback(hObject, eventdata, handles)
global basics
str = get(hObject,'String');
val = get(hObject,'Value');
basics.statistics  = str{val};

% --- Executes on selection change in densitybenchmark.
function densitybenchmark_Callback(hObject, eventdata, handles)
global basics;
%basics.densitymodel = str2double(get(hObject,'String'))
str = get(hObject,'String');
val = get(hObject,'Value');
nmod=size(str,1);
if basics.EstimationMethod(3) ~= 1
    basics.densitymodel = str(val,:);
else
    if isempty(cell2mat(strfind(str(val,:),'_MHforecast')))
        if isempty(cell2mat(strfind(str(val,:),'BVAR')))
            basics.densitymodel = [deblank(str{val}) '_MHforecast'];
        else
            basics.densitymodel = str(val,:);
        end
    else
        basics.densitymodel = str(val,:);
    end
end


% --- Executes on button press in bvarpriors.
function bvarpriors_Callback(hObject, eventdata, handles)
% hObject    handle to bvarpriors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bvarpiors
uiwait


% --- Executes on button press in dsgetest.
function dsgetest_Callback(hObject, eventdata, handles)
% hObject    handle to dsgetest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dsgetest


% --- Executes on button press in irf.
function irf_Callback(hObject, eventdata, handles)
% hObject    handle to irf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of irf


% --- Executes on button press in hvd.
function hvd_Callback(hObject, eventdata, handles)
% hObject    handle to hvd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hvd

function irf_periods_Callback(hObject, eventdata, handles)
global basics;
basics.irf_periods = 10;
value = str2double(get(hObject,'String'));
if (~isempty(value)&&~isnan(value))
    basics.irf_periods = value;
else
    set(hObject,'string',10);
end

function hvd_periods_Callback(hObject, eventdata, handles)
global basics;
basics.hvd_periods = 10;
value = str2double(get(hObject,'String'));
if (~isempty(value)&&~isnan(value))
    basics.hvd_periods = value;
else
    set(hObject,'string',10);
end

% --- Executes when selected object is changed in datatypepanel.
function hvdpanel_SelectionChangeFcn(hObject, eventdata, handles)
global basics;
switch get(hObject,'Tag')
    case 'hvd_absolute'
        basics.hvd_absolute = get(hObject,'Value');
    case 'hvd_relative'
        basics.hvd_absolute = 0;
end
