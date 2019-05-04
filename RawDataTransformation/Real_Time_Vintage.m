function varargout = Real_Time_Vintage(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Real_Time_Vintage_OpeningFcn, ...
    'gui_OutputFcn',  @Real_Time_Vintage_OutputFcn, ...
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


function Real_Time_Vintage_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

global quarterly quarterlyaltlist vint_or_obs obsformlist obsform Observables OBSERVATION  VINTAGES MMBDATA;
global zone ObsInfos;
MMBDATA.zone='us';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%This part of the script initializes vector of handles for each group tabs in the GUI %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Handles of names of Raw Data Files
handles.filehandles = [handles.observable1,handles.observable2];

%Handles of variable labels in Raw Data Files
handles.labelhandles = [handles.label1,handles.label2];

%Handles for data frequencies (Quarterly or Monthly)
handles.quarterlyhandles = [handles.quarterly1,handles.quarterly2];

%Handles for the observation formats
handles.obsformhandles = [handles.obsform1,handles.obsform2];

%Handles for the observation formats
handles.obsformhandles = [handles.obsform1,handles.obsform2];

%Handles for the transformation needed by the variables
handles.transformationhandles = [handles.trans1];

%Handles to save the variable names as they will appear in the .mod file
handles.labelmodhandles = [handles.labelmod1];

quarterlyaltlist = [handles.vintform1,handles.vintform2];

quarterly=[0;0];

obsformlist = [handles.obsform1,handles.obsform2];

obsform=[1;1];

DataInitialization

set(handles.uitable1, 'enable', 'off')
set(handles.uitable2, 'enable', 'off')
set(handles.uitable3, 'enable', 'off')
set(handles.uitable4, 'enable', 'off')
guidata(hObject, handles);

function varargout = Real_Time_Vintage_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


function uitable1_CellEditCallback(hObject, eventdata, handles)
global vint_or_obs;
info_format=get(hObject,'data');
handles.obsformat = {[3;3]};
handles.posobservation{1} = info_format;

function uitable2_CellEditCallback(hObject, eventdata, handles)
info_format=get(hObject,'data');
handles.vintformat{1} = {[2;2]};
handles.posrelease{1} = {info_format};


function uitable3_CellEditCallback(hObject, eventdata, handles)
info_format=get(hObject,'data');
handles.obsformat = {[3;3]};
handles.posobservation{1} = info_format;

function uitable4_CellEditCallback(hObject, eventdata, handles)
info_format=get(hObject,'data');
handles.vintformat{1} = {[2;2]};
handles.posrelease{1} = {info_format};

function pushbutton1_Callback(hObject, eventdata, handles)
close(gcbf)

function QuarterlyAlt_Callback(hObject, eventdata, handles)
global quarterly quarterlyaltlist;
if ~isempty(findobj(quarterlyaltlist,'Tag',get(hObject,'Tag')))
    quarterly(find(quarterlyaltlist==findobj(quarterlyaltlist,'Tag',get(hObject,'Tag'))))=get(hObject,'Value');
end

% --- Executes on button press in simplevariables.
function simplevariables_Callback(hObject, eventdata, handles)
global quarterly simple_var obsform;
if get(hObject,'Value')
    set(findall(handles.uipanel5, '-property', 'enable'), 'enable', 'off')
    quarterly=quarterly(1);
    obsform=obsform(1);
    setappdata(0,'Format2',[]);
else
    simple_var = 0;
    set(findall(handles.uipanel5, '-property', 'enable'), 'enable', 'on')
end

function ObsForm_Callback(hObject, eventdata, handles)
global obsformlist obsform;
str = get(hObject, 'String');
val = get(hObject,'Value');
if ~isempty(findobj(obsformlist,'Tag',get(hObject,'Tag')))
    pos=find(obsformlist==findobj(obsformlist,'Tag',get(hObject,'Tag')));
    switch str{val}
        case '1 (Ex. 1999:Q1)'
            obsform(pos) = 1;
            if pos == 1
                set(handles.uitable1, 'enable', 'off')
            else
                set(handles.uitable2, 'enable', 'off')
            end
        case '2 (Ex. YYYY-MM-DD)'
            obsform(pos) = 2;
            if pos == 1
                setappdata(0,'Format1', [7 10; 4 5])
                set(findall(handles.uitable1, '-property', 'enable'), 'enable', 'off')
            else
                setappdata(0,'Format2', [7 10; 4 5])
                set(handles.uitable2, 'enable', 'off')
            end
        case '3 Alternative'
            obsform(pos) = 3;
            if pos == 1
                set(handles.uitable1, 'enable', 'on')
            else
                set(handles.uitable3, 'enable', 'on')
            end
    end
end

%CallBack for vintage's formates
function VintForm_Callback(hObject, eventdata, handles)
global simple_var vint_or_obs quarterlyaltlist quarterly;% See comments in ObsForm_Callback
vint_or_obs = 1;
str = get(hObject, 'String');
val = get(hObject,'Value');
if ~isempty(findobj(quarterlyaltlist,'Tag',get(hObject,'Tag')))
    pos = find(quarterlyaltlist==findobj(quarterlyaltlist,'Tag',get(hObject,'Tag')));
    switch str{val}
        case 'LabelYYQQ'
            quarterly(pos) = 1;
        case 'Alternative'
            quarterly(pos)=2;
             if pos == 1
                set(handles.uitable2, 'enable', 'on')
            else
                set(handles.uitable4, 'enable', 'on')
            end
    end
end
guidata(hObject, handles);


%CallBack for names of Raw Data Files

function FileLoading_Callback(hObject, eventdata, handles)
global zone ObsInfos quarterlyaltlist quarterly;
if strcmp(zone,'us')
    RawData = '\USRawData\';
elseif strcmp(zone,'euroarea')
    RawData = '\EARawData\';
end
%DataInitialization
l = size(RawData,2)+1;

val=get(hObject,'Value');

handles.filename = ObsInfos(val,1);aa=ObsInfos(val,1);
try
    a=ObsInfos(val,1);a=a{:};a=cell2mat(a(2,:));
    set(handles.filehandles(2),'String',a(l:end));
catch
    set(findall(handles.uipanel5, '-property', 'enable'), 'enable', 'off')
end

handles.VintLabel = ObsInfos(val,2);a=ObsInfos(val,2);a=a{:}; 
set(handles.labelhandles(1),'String',a(1,:));
try
    set(handles.labelhandles(2),'String',a(2,:));
catch
end


a=ObsInfos(val,3);a=a{:};quarterly = a;
set(handles.quarterlyhandles(1),'Value',a(1,:));
try
    set(handles.quarterlyhandles(2),'Value',a(2,:));
catch
end

handles.obsformat = ObsInfos(val,4);a=ObsInfos(val,4);
if ~isempty(a{:})
    set(handles.obsform1,'Value',a{:}(1));
    try
        set(handles.obsform2,'Value',a{:}(2));
    catch
    end
else
end

handles.vintformat = ObsInfos(val,5);a=ObsInfos(val,5);
if ~isempty(a{:})
    set(handles.vintform2,'Value',a{:}(1));
    try
        set(handles.vintform2,'Value',a{:}(2));
    catch
    end
else
end
a=ObsInfos(val,6);
handles.posobservation = ObsInfos(val,6);
if ~isempty(a{:})
    set(handles.uitable1,'data',cell2mat(a{:}(1,:)))
    try
        set(handles.uitable3,'data',cell2mat(a{:}(2,:)))
    catch
        set(handles.uitable3,'data',[])
    end
else
    set(handles.uitable1,'data',[])
    set(handles.uitable2,'data',[])
end

handles.posrelease = ObsInfos(val,7);
a=ObsInfos(val,7);
if ~isempty(a{:})
    set(handles.uitable2,'data',cell2mat(a{:}(1,:)))
    try
        set(handles.uitable4,'data',cell2mat(a{:}(2,:)))
    catch
    end
else
    set(handles.uitable2,'data',[])
    set(handles.uitable4,'data',[])
end


handles.transformation = ObsInfos(val,8);

handles.variables = ObsInfos(val,9);
a=ObsInfos(val,9);
set(handles.labelmod1,'String',cell2mat(a{:}));
a=ObsInfos(val,10);

handles.Observables=ObsInfos(val,10);
set(handles.save_excel,'String',cell2mat(a{:}));

handles.variables_a = ObsInfos(val,11);a=ObsInfos(val,11);
set(handles.revname,'String',cell2mat(a{:}));

handles.spffilename = ObsInfos(val,12);a=ObsInfos(val,12);
set(handles.spf,'String',cell2mat(a{:}));

guidata(hObject, handles);

%CallBack for variable labels in Raw Data Files
function Label_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
if ~isempty(findobj(handles.labelhandles,'Tag',get(hObject,'Tag')))
    handles.VintLabel{find(handles.labelhandles==findobj(handles.labelhandles,'Tag',get(hObject,'Tag')))}={{get(hObject,'String')}};
end
guidata(hObject, handles);


 


function labelmod1_Callback(hObject, eventdata, handles)
handles.Observables = {{get(hObject,'String')}};
guidata(hObject, handles);

%CallBack for the variable names as they will appear in the .mod file
function save_excel_Callback(hObject, eventdata, handles)
handles.variables = {{get(hObject,'String')}};
guidata(hObject, handles);

function revname_Callback(hObject, eventdata, handles)
handles.variables_a = {{get(hObject,'String')}};
guidata(hObject, handles);

function spf_Callback(hObject, eventdata, handles)
handles.spffilename = {{get(hObject,'String')}};
guidata(hObject, handles);


%CallBack to specify the observation frequency
function Quarterly_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
if ~isempty(findobj(handles.quarterlyhandles,'Tag',get(hObject,'Tag')))
    handles.quarterly{find(handles.quarterlyhandles==findobj(handles.quarterlyhandles,'Tag',get(hObject,'Tag')))}={get(hObject,'Value')};
end
guidata(hObject, handles);




%CallBack for the specification of the transformation need by the varaible
function DataTreatment_Callback(hObject, eventdata, handles)
global trend;
str = get(hObject, 'String');
val = get(hObject,'Value');
if ~isempty(findobj(handles.transformationhandles,'Tag',get(hObject,'Tag')));
    %pos=find(handles.transformationhandles==findobj(handles.transformationhandles,'Tag',get(hObject,'Tag')));
    switch str{val}
        case 'Real Growth (Original Obs. in Nom. Terms)'
            handles.transformation = {1};
        case 'Real Growth (Original Obs. in Real Terms)'
            handles.transformation = {2};
        case 'Obtain Quaterly Series From Non Rev. An. Data'
            handles.transformation = {3};
        case 'Spread'
            handles.transformation = {4};
        case 'Sum 2 Nom. Series & Compute'
            handles.transformation = {5};
        case 'Hours'
            handles.transformation = {6};
        case 'Transformation 7'
            handles.transformation = {7};
        case 'Transformation 8'
            handles.transformation = {8};
        case 'Log and Detrend'
            handles.transformation = {9};
            trend=1600;
    end
end
guidata(hObject, handles);



% Selection on the data area
function region_SelectionChangeFcn(hObject, eventdata, handles)
global zone ObsInfos; 
switch get(hObject,'Tag')
    case 'us'
        zone = 'us';
    case 'euroarea'
        zone = 'euroarea';
end 
DataInitialization
guidata(hObject, handles);


%CallBack for the main function used for vintage extraction
function getvintages_Callback(hObject, eventdata, handles)

warning off

global OBSERVATION  VINTAGES Start FirstObs PGNP  location  ObsInfos zone quarterly trend MMBDATA;

handles.quarterly=quarterly; handles.trend=trend;

List_Observables = 'List_Observables_US';

cd1 = cd;

cd('..\DATA\USDATA\Tranformed_Data')

location=[cd '\'];

cd(cd1)
f = ObsInfos(2,1);

[~,~,PGNP] = xlsread(cell2mat(f{1}));

a = cell2mat(PGNP(1,2)); m = size(a,2);

Start = a(m-3:m);

FirstObs = cell2mat(PGNP(2,1)); a=ObsInfos(2,2);a=a{:};
PGNP = [[PGNP(1,1) PGNP(1,find(strcmp(PGNP(1,:), [cell2mat(a) Start])):end)];...
    [PGNP(find(strcmp(PGNP(:,1), FirstObs)):end,1), PGNP(find(strcmp(PGNP(:,1), FirstObs)):end,...
    find(strcmp(PGNP(1,:), [cell2mat(a) Start])):end)]];

PGNP=complete_missing(PGNP);
%Transformation of raw data


if ~isempty(handles.variables{:})
    display(['Treating ' cell2mat(handles.variables{:}) '...'])
    %try
        DATAMAT{1} = format_transform(handles);
        xlswrite([location cell2mat(handles.variables{:})],DATAMAT{1},1)
    %catch
    %    display(['Input on the variable ' cell2mat(handles.variables{:}) ' seems to be wrong. Please check this variable...'])
    %end
end
     display(['Variable ' cell2mat(handles.variables{:}) ' has been successfully updated. The interface can be closed now.'])

% edit_varname(List_Observables,handles.Observables,handles.variables,handles.variables_a)

%%%%%%%%%%%%%This part extracts SPF forecasts and creates vintage with
%%%%%%%%%%%%%appopriate names using the script code_vintagesSPF
if ~isempty(cell2mat(handles.spffilename{:}))
cd1 = cd;
RawData = '\USRawData\';
cd('..\DATA\USDATA\SPF')

location = cd;

cd(cd1);
 
SPFDATAMAT = [];

SFP_Files = {'SPFRGDP';'SPFPGDP';'FEDFUNDS';'SPFSPREAD'}; 

spf_var=find(strcmp(handles.spffilename{:},SFP_Files)==1);

handles.spffilename={[RawData cell2mat(SFP_Files(spf_var,:))]};  
SPFDATAMAT = extend_forecast(handles  ,SPFDATAMAT);
 cd1 = cd;

cd('..\DATA\USDATA\Tranformed_Data_SPF\')

location = [cd '\'];

cd(cd1)

SPFDATAMAT{1} = [];

for i = 1:3
   SPFDATAMAT = extend_forecast_nc(handles,SPFDATAMAT{1});
   xlswrite([location cell2mat(handles.variables{:})],SPFDATAMAT,1)
end

code_vintagesSPF
end
%%%%%%%%%%%%%%%The next loops creates for the GDP, its deflator and the
%%%%%%%%%%%%%%%fed funds rate series extended with the SPF now casts.


%end





function all_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




 
