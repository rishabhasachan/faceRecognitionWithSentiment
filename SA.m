function varargout = SA(varargin)
% SA MATLAB code for SA.fig
%      SA, by itself, creates a new SA or raises the existing
%      singleton*.
%
%      H = SA returns the handle to a new SA or the handle to
%      the existing singleton*.
%
%      SA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SA.M with the given input arguments.
%
%      SA('Property','Value',...) creates a new SA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SA

% Last Modified by GUIDE v2.5 15-Apr-2018 19:31:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SA_OpeningFcn, ...
                   'gui_OutputFcn',  @SA_OutputFcn, ...
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


% --- Executes just before SA is made visible.
function SA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SA (see VARARGIN)

% Choose default command line output for SA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fid=fopen('datas.txt','rt');
tmp=textscan(fid,'%d,%d,%d','Delimiter','\n');
fclose(fid);

n=size(tmp{1},1);

m_area=tmp{1}(i,1);
e_area=tmp{2}(i,1);
sentiment=tmp{3}(i,1);
