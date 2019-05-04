function varargout = Real_Time_Vintage_EA(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Real_Time_Vintage_EA_OpeningFcn, ...
    'gui_OutputFcn',  @Real_Time_Vintage_EA_OutputFcn, ...
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


function Real_Time_Vintage_EA_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
global MMBDATA;
%zone='ea';
MMBDATA.zone='euroarea';
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

%Handles for vintage formats

%handles.vintformhandles = [handles.vintform1,handles.vintform2];

%Handles for the transformation needed by the variables

handles.transformationhandles = [handles.trans1];

%Handles to save the variable names as they will appear in the .mod file

handles.labelmodhandles = [handles.labelmod1];

MMBDATA.quarterlyaltlist = [handles.quarterly1,handles.quarterly2];

MMBDATA.quarterly=[0;0];

%obsformlist = [handles.obsform1,handles.obsformvar2];

MMBDATA.obsform=[1;1];

DataInitialization

guidata(hObject, handles);

function varargout = Real_Time_Vintage_EA_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


function uitable1_CellEditCallback(hObject, eventdata, handles)
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
global MMBDATA;
if ~isempty(findobj(MMBDATA.quarterlyaltlist,'Tag',get(hObject,'Tag')))
    MMBDATA.quarterly(find(MMBDATA.quarterlyaltlist==findobj(MMBDATA.quarterlyaltlist,'Tag',get(hObject,'Tag'))))=get(hObject,'Value');
end

% --- Executes on button press in simplevariables.
function simplevariables_Callback(hObject, eventdata, handles)
global MMBDATA simple_var;
if get(hObject,'Value')
    set(findall(handles.uipanel5, '-property', 'enable'), 'enable', 'off')
    MMBDATA.quarterly=MMBDATA.quarterly(1);
    MMBDATA.obsform=MMBDATA.obsform(1);
    setappdata(0,'Format2',[]);
else
    simple_var = 0;
    set(findall(handles.uipanel5, '-property', 'enable'), 'enable', 'on')
end

function ObsForm_Callback(hObject, eventdata, handles)
global MMBDATA;
str = get(hObject, 'String');
val = get(hObject,'Value');
if ~isempty(findobj(MMBDATA.obsformlist,'Tag',get(hObject,'Tag')))
    pos=find(MMBDATA.obsformlist==findobj(MMBDATA.obsformlist,'Tag',get(hObject,'Tag')));
    switch str{val}
        case '1 (Ex. 1999:Q1)'
            MMBDATA.obsform(pos) = 1;
            if pos == 1
                set(handles.uitable1, 'enable', 'off')
            else
                set(handles.uitable2, 'enable', 'off')
            end
        case '2 (Ex. YYYY-MM-DD)'
            MMBDATA.obsform(pos) = 2;
            if pos == 1
                setappdata(0,'Format1', [7 10; 4 5])
                set(findall(handles.uitable1, '-property', 'enable'), 'enable', 'off')
            else
                setappdata(0,'Format2', [7 10; 4 5])
                set(handles.uitable2, 'enable', 'off')
            end
        case '3 Alternative'
            MMBDATA.obsform(pos) = 3;
            if pos == 1
                set(handles.uitable1, 'enable', 'on')
            else
                set(handles.uitable2, 'enable', 'on')
            end
    end
end


%CallBack for names of Raw Data Files

function FileLoading_Callback(hObject, eventdata, handles)
global MMBDATA;
if strcmp(MMBDATA.zone,'us')
    RawData = '\USRawData\';
elseif strcmp(MMBDATA.zone,'euroarea')
    RawData = '\EARawData\';
end
l = size(RawData,2)+1;

val=get(hObject,'Value');

handles.filename = MMBDATA.ObsInfos(val,1) ;
try
    a=MMBDATA.ObsInfos(val,1);a=a{:};a=cell2mat(a(2,:));
    set(handles.filehandles(2),'String',a(l:end));
catch
    set(findall(handles.uipanel5, '-property', 'enable'), 'enable', 'off')
end
handles.VintLabel = MMBDATA.ObsInfos(val,2);
a=MMBDATA.ObsInfos(val,3);a=a{:};MMBDATA.quarterly = a;
set(MMBDATA.quarterlyaltlist(1),'Value',a(1,:));
try
    set(MMBDATA.quarterlyaltlist(2),'Value',a(2,:));
catch
end

handles.obsformat = MMBDATA.ObsInfos(val,4);a=MMBDATA.ObsInfos(val,4);
if ~isempty(a{:})
    set(handles.obsform1,'Value',a{:}(1));
    try
        set(handles.obsform2,'Value',a{:}(2));
    catch
    end
else
end

handles.vintformat = MMBDATA.ObsInfos(val,5);a=MMBDATA.ObsInfos(val,5);
if ~isempty(a{:})
    set(handles.vintform1,'Value',a{:}(1));
    try
        set(handles.vintform2,'Value',a{:}(2));
    catch
    end
else
end
a=MMBDATA.ObsInfos(val,6);
handles.posobservation = MMBDATA.ObsInfos(val,6);
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

handles.posrelease = MMBDATA.ObsInfos(val,7);
a=MMBDATA.ObsInfos(val,7);
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


handles.transformation = MMBDATA.ObsInfos(val,8);

handles.variables = MMBDATA.ObsInfos(val,9);a=MMBDATA.ObsInfos(val,9);
set(handles.labelmod1,'String',cell2mat(a{:}));
handles.variables_a = MMBDATA.ObsInfos(val,10);
guidata(hObject, handles);

%CallBack for variable labels in Raw Data Files


function Label_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
if ~isempty(findobj(handles.labelhandles,'Tag',get(hObject,'Tag')))
    handles.VintLabel{find(handles.labelhandles==findobj(handles.labelhandles,'Tag',get(hObject,'Tag')))}={{get(hObject,'String')}};
end
guidata(hObject, handles);



%CallBack for the variable names as they will appear in the .mod file


function LabelModFile_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
if ~isempty(findobj(handles.labelmodhandles,'Tag',get(hObject,'Tag')))
    handles.variables{find(handles.labelmodhandles==findobj(handles.labelmodhandles,'Tag',get(hObject,'Tag')))}={{get(hObject,'String')}};
end
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





%CallBack for vintage's formates


function VintForm_Callback(hObject, eventdata, handles)
str = get(hObject, 'String');
val = get(hObject,'Value');
if ~isempty(findobj(handles.vintformhandles,'Tag',get(hObject,'Tag')))
    pos = find(handles.vintformhandles==findobj(handles.vintformhandles,'Tag',get(hObject,'Tag')));
    switch str{val}
        case 'LabelYYQQ'
            handles.vintformat{pos} = {1};
        case 'Alternative'
            if pos==1
                handles.vintformat{1}(1,:) = {2};
            else
                handles.vintformat{1}(2,:) = {2};
            end
    end
end
guidata(hObject, handles);

% Selection on the data area
function dataset_SelectionChangeFcn(hObject, eventdata, handles)
global MMBDATA;
switch get(hObject,'Tag')
    case 'rtdb'
        MMBDATA.dataset = 1;
    case 'awmdb'
        MMBDATA.dataset = 2;
end
DataInitialization
guidata(hObject, handles);

%CallBack for the main function used for vintage extraction
function getvintages_Callback(hObject, eventdata, handles)

warning off

global OBSERVATION  VINTAGES Start FirstObs PGNP  location  MMBDATA trend ;

handles.quarterly=MMBDATA.quarterly; handles.trend=trend;

%create a chronological line for vintages and observations

str=date;

OBSERVATION=[];VINTAGES=[];

for y = 1940:str2num(str([8:11]))+20
    
    for q = 1:4
        OBSERVATION = [OBSERVATION;[num2str(y) ':Q' num2str(q)]];
        a = num2str(y);
        VINTAGES = [VINTAGES;[a(end-1:end) 'Q' num2str(q)]];
    end
end

List_Observables = 'List_Observables_EA';

release = handles.posrelease;

GDPDEFLATOR = rearrange(cell2mat(MMBDATA.ObsInfos{2,1}),cell2mat(MMBDATA.ObsInfos{2,2}),cell2mat(MMBDATA.ObsInfos{2,7}));

GDPDEFLATOR = generate_date_obs(GDPDEFLATOR,1:4,[]);

a = cell2mat(GDPDEFLATOR(1,2)); m = size(a,2);

Start  = '01Q1';

PGNP = extract_vintages(GDPDEFLATOR,cell2mat(MMBDATA.ObsInfos{2,2}),2:5,6:7,8:9);

PGNP=complete_missing(PGNP);

cd1 = cd;
%try
Labor_Force
%catch
%    pause
%end% complete_missing(Labor_Force,'Labor_Force',[],[],[])

cd('..\DATA\EADATA\Tranformed_Data')

location=[cd '\'];

cd(cd1)
FirstObs = cell2mat(PGNP(2,1)); a=MMBDATA.ObsInfos(2,2);a=a{:};
PGNP = [[PGNP(1,1) PGNP(1,find(strcmp(PGNP(1,:), [cell2mat(a) Start])):end)];...
    [PGNP(find(strcmp(PGNP(:,1), FirstObs)):end,1), PGNP(find(strcmp(PGNP(:,1), FirstObs)):end,...
    find(strcmp(PGNP(1,:), [cell2mat(a) Start])):end)]];
PGNP=complete_missing(PGNP);
D = PGNP;
D(2:size(PGNP,1),2:size(PGNP,2)) = {1}; %for data already expressed in real terms, deflate series by one!
MMBDATA.MATINF = real_growth(PGNP,D);
%Transformation of raw data
for l=2
    handles.l=l;MMBDATA.wages=0;
    if l==2
        handles.transformation={9};%real
        MMBDATA.percapita=1;
        location=[location(1:end-1) '_SW03\'];
        if  strcmp(cell2mat(handles.filename{:}),'\EARawData\EMP')
            MMBDATA.scale=1;
        else
            MMBDATA.scale=10^3;
        end
        if  strcmp(cell2mat(handles.filename{:}),'\EARawData\WAGE')
             MMBDATA.scale=1;MMBDATA.wages=1;
            handles.transformation={10};%nominal
        end
        if  strcmp(cell2mat(handles.filename{:}),'\EARawData\EONIA')
            MMBDATA.EONIA=1;
        else
            MMBDATA.EONIA=0;
        end
    else
        MMBDATA.percapita=0;
    end
    for i = 1%:handles.nvar
        if ~isempty(handles.variables{:})
            display(['Treating ' cell2mat(handles.variables{:}) '...'])
            %try
            if ~strcmp(cell2mat(handles.filename{:}),'\EARawData\GDPDEF')
                DATAMAT{i} = format_transform(handles);
            else
                DATAMAT{i}=detrend_series(MMBDATA.MATINF);
            end
            xlswrite([location cell2mat(handles.variables{:})],DATAMAT{i},1)
            %catch
            display(['Input on the variable ' cell2mat(handles.variables{:}) ' seems to be wrong. Please check this variable...'])
            %end
        end
    end
end


function all_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function labelmod1_Callback(hObject, eventdata, handles)
% hObject    handle to labelmod1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of labelmod1 as text
%        str2double(get(hObject,'String')) returns contents of labelmod1 as a double
