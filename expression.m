function varargout = expression(varargin)
% EXPRESSION MATLAB code for expression.fig
%      EXPRESSION, by itself, creates a new EXPRESSION or raises the existing
%      singleton*.
%
%      H = EXPRESSION returns the handle to a new EXPRESSION or the handle to
%      the existing singleton*.
%
%      EXPRESSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPRESSION.M with the given input arguments.
%
%      EXPRESSION('Property','Value',...) creates a new EXPRESSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before expression_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to expression_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help expression

% Last Modified by GUIDE v2.5 15-Apr-2018 20:46:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @expression_OpeningFcn, ...
                   'gui_OutputFcn',  @expression_OutputFcn, ...
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


% --- Executes just before expression is made visible.
function expression_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to expression (see VARARGIN)

% Choose default command line output for expression
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes expression wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = expression_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in img.
function img_Callback(hObject, eventdata, handles)
% hObject    handle to img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,testpath] = uigetfile('.\Sentiment_train\*.*','Select the Test Image');
TestImage = strcat(testpath,FileName);
set(handles.text1,'String',TestImage);
setappdata(0,'TestImage',TestImage);




function exp_Callback(hObject, eventdata, handles)
% hObject    handle to exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exp as text
%        str2double(get(hObject,'String')) returns contents of exp as a double
exp= str2num(get(handles.exp,'String'));
setappdata(0,'exp',exp);

% --- Executes during object creation, after setting all properties.
function exp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in process.
function process_Callback(hObject, eventdata, handles)
% hObject    handle to process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TestImage=getappdata(0,'TestImage');



[moutharea eyearea]=area( TestImage );% calculate mouth area

set(handles.mouth,'String',moutharea);
set(handles.eye,'String',eyearea);
setappdata(0,'moutharea',moutharea);
setappdata(0,'eyearea',eyearea);

%============= Read text file ==============================================================================================
%fid = fopen('data.txt','rt');
%tmp = textscan(fid,'%d,%d,%d,%s','Delimiter','\n');
%fclose(file);
%==========================================================================================================






% --- Executes on button press in saveToDb.
function saveToDb_Callback(hObject, eventdata, handles)
% hObject    handle to saveToDb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
moutharea=getappdata(0,'moutharea')
eyearea=getappdata(0,'eyearea')
exp1=getappdata(0,'exp')
file = fopen('datas.txt', 'a');

%fprintf(file, '%10s  %10s\n\n', 'Coordinates', 'RGB values');
fprintf(file, '%d,%d,%d\n', moutharea,eyearea,exp1);
fclose(file);
close(expression);
