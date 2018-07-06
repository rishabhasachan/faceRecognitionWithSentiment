function varargout = infoToDBrecog(varargin)
% INFOTODBRECOG MATLAB code for infoToDBrecog.fig
%      INFOTODBRECOG, by itself, creates a new INFOTODBRECOG or raises the existing
%      singleton*.
%
%      H = INFOTODBRECOG returns the handle to a new INFOTODBRECOG or the handle to
%      the existing singleton*.
%
%      INFOTODBRECOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INFOTODBRECOG.M with the given input arguments.
%
%      INFOTODBRECOG('Property','Value',...) creates a new INFOTODBRECOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before infoToDBrecog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to infoToDBrecog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help infoToDBrecog

% Last Modified by GUIDE v2.5 15-Apr-2018 15:40:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @infoToDBrecog_OpeningFcn, ...
                   'gui_OutputFcn',  @infoToDBrecog_OutputFcn, ...
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


% --- Executes just before infoToDBrecog is made visible.
function infoToDBrecog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to infoToDBrecog (see VARARGIN)

% Choose default command line output for infoToDBrecog
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes infoToDBrecog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = infoToDBrecog_OutputFcn(hObject, eventdata, handles) 
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
[FileName,testpath] = uigetfile('./train_data/*.jpg','Select the Test Image');
TestImage = strcat(testpath,FileName);
set(handles.img,'String',TestImage);
setappdata(0,'TestImage',TestImage);


function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name as text
%        str2double(get(hObject,'String')) returns contents of name as a double
name= get(handles.name,'String');
setappdata(0,'name',name);

% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roll_Callback(hObject, eventdata, handles)
% hObject    handle to roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roll as text
%        str2double(get(hObject,'String')) returns contents of roll as a double
roll= str2num(get(handles.roll,'String'));
setappdata(0,'roll',roll);

% --- Executes during object creation, after setting all properties.
function roll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gen_Callback(hObject, eventdata, handles)
% hObject    handle to gen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gen as text
%        str2double(get(hObject,'String')) returns contents of gen as a double
gen= get(handles.gen,'String');
setappdata(0,'gen',gen);

% --- Executes during object creation, after setting all properties.
function gen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveToDb.
function saveToDb_Callback(hObject, eventdata, handles)
% hObject    handle to saveToDb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TestImage=getappdata(0,'TestImage')
name=getappdata(0,'name')
roll=getappdata(0,'roll')
gen=getappdata(0,'gen')

file = fopen('datar.txt', 'a');

%fprintf(file, '%10s  %10s\n\n', 'Coordinates', 'RGB values');
fprintf(file, '%d,%s,%s\n',roll,gen,name);
fclose(file);


%================Read text file==================
fid=fopen('datar.txt','rt');
tmp=textscan(fid,'%d,%c,%s','Delimiter','\n');
fclose(fid);

TestImage;
n=size(tmp{1},1);
imwrite((imread(TestImage)),(strcat('.\superTraining\',int2str(n),'.jpg')));

close(infoToDBrecog);
