function varargout = bvarpiors(varargin)
% BVARPIORS MATLAB code for bvarpiors.fig
%      BVARPIORS, by itself, creates a new BVARPIORS or raises the existing
%      singleton*.
%
%      H = BVARPIORS returns the handle to a new BVARPIORS or the handle to
%      the existing singleton*.
%
%      BVARPIORS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BVARPIORS.M with the given input arguments.
%
%      BVARPIORS('Property','Value',...) creates a new BVARPIORS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bvarpiors_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bvarpiors_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bvarpiors

% Last Modified by GUIDE v2.5 23-May-2016 18:45:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bvarpiors_OpeningFcn, ...
                   'gui_OutputFcn',  @bvarpiors_OutputFcn, ...
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


% --- Executes just before bvarpiors is made visible.
function bvarpiors_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bvarpiors (see VARARGIN)
global MMBEST;
% Choose default command line output for bvarpiors
handles.output = hObject;

MMBEST.bvarmpriors=[3, 0.5, 5, 2, 1, 0, 0 ];

handles.priors =[handles.tau handles.decay handles.omega handles.lambda handles.mu handles.flatprior handles.priortrain];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bvarpiors wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bvarpiors_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function all_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MMBEST;

switch get(eventdata.Source,'Value')
    case 1
        MMBEST.text = char(['Note: The original Minnesota prior treats own lags asymmetrically, and therefore cannot be implemented entirely with dummy observations.  It is also usually taken to include the sum-of-coefficients and co-persistence components that are implemented directly in rfvar3.m.  The diagonal prior on v, combined with sum-of-coefficients and co-persistence components and with the unit own-first-lag prior mean generates larger prior variances for own than for cross-effects even in this formulation, but here there is no way to shrink toward a set of unconstrained univariate AR ''  s.']);       
    case 2   
        MMBEST.text = char(['Tau governs the overall tightness of the Minnesota Prior. Large values imply a small prior covariance matrix. Default value is 3. Further references see: Dynare''s bvartoolbox.m file and documentation: https://github.com/DynareTeam/dynare/blob/master/doc/bvar-a-la-sims.tex']);
    case 3
        MMBEST.text = char(['Decay sets decay factor for scaling down the coefficients of lagged values. It is the exponent of the lag,dynare default value is 0.5. Further references see: Dynare''s bvartoolbox.m file and documentation: https://github.com/DynareTeam/dynare/blob/master/doc/bvar-a-la-sims.tex ']);
    case 4
        MMBEST.text = char(['Sigma scales the prior covariance matrix. It is the prior mode for diagonal elements of r.f. covariance matrix. Its default value is to be set to 1, a higher number represent less confidence. Further references see: Dynare''s bvartoolbox.m file and documentation: https://github.com/DynareTeam/dynare/blob/master/doc/bvar-a-la-sims.tex        ']);
    case 5
        MMBEST.text = char(['Omega controls the tightness on the covariance matrix. Weight on prior on vcv.  1 corresponds to "one dummy observation" weight. Should be an integer, and will be rounded if not.  vprior.sig is needed to scale the Minnesota prior, even if the prior on sigma is not used itself. Set vprior.w=0 to achieve this. Further references see: Dynare''s bvartoolbox.m file and documentation: https://github.com/DynareTeam/dynare/blob/master/doc/bvar-a-la-sims.tex        ']);               
    case 6
        MMBEST.text = char(['Lambda:  weight on "co-persistence" prior dummy observations. This expresses belief that when data on *all* y''s are stable at their initial levels, they will tend to persist at that level.  lambda=5 is a reasonable first try. With lambda<0, constant term is not included in the dummy observation, so that stationary models with means equal to initial ybar do not fit the prior mean. With lambda>0,the prior implies that large constants are unlikely if unit roots are present. 5 is the default. Further references see: Dynare''s bvartoolbox.m file and documentation: https://github.com/DynareTeam/dynare/blob/master/doc/bvar-a-la-sims.tex        ']);
    case 7        
                MMBEST.text = char(['MU: is the weight on "own persistence" prior dummy observation. Expresses belief that when y_i has been stable at its initial level, it will tend to persist at that level, regardless of the values of other variables. There is one of these for each variable.  A reasonable first guess is mu=2. Further references see: Dynare''s bvartoolbox.m file and documentation: https://github.com/DynareTeam/dynare/blob/master/doc/bvar-a-la-sims.tex        ']);
end
        set(handles.text1, 'String', MMBEST.text);  

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

function text1_Callback(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text1 as text
%        str2double(get(hObject,'String')) returns contents of text1 as a double


function prior_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MMBEST
h = str2double(get(hObject,'String'));
if (~isempty(h)&&~isnan(h))
    MMBEST.bvarmpriors(find(handles.priors==findobj(handles.priors,'Tag',get(hObject,'Tag')))) = h;
else 
    set(hObject,'string',MMBEST.bvarmpriors(find(handles.priors==findobj(handles.priors,'Tag',get(hObject,'Tag')))));
end

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double

% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcbf)
uiresume
       
