function varargout = faceDefault(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @faceDefault_OpeningFcn, ...
                   'gui_OutputFcn',  @faceDefault_OutputFcn, ...
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
% --- Executes just before faceDefault is made visible.
function faceDefault_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
% --- Outputs from this function are returned to the command line.
function varargout = faceDefault_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% --- Executes on button press in about.
function about_Callback(hObject, eventdata, handles)
about
% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
datapath = uigetdir('.\superTraining','select path of training images');
set(handles.path,'String',datapath);
setappdata(0,'folder_path',datapath);
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
[FileName,testpath] = uigetfile('.\train_data\*.jpg','Select the Test Image');
TestImage = strcat(testpath,FileName);set(handles.size,'String',TestImage);
setappdata(0,'inputimg',TestImage);
% --- Executes on button press in output.
function output_Callback(hObject, eventdata, handles)
datapath=getappdata(0,'folder_path');
%TestImage=getappdata(0,'image_path')
TestImage=getappdata(0,'inputimg');
inputimg=TestImage;
% --- voila jones algo
FDetect = vision.CascadeObjectDetector;
I = imread(TestImage);
BB = step(FDetect,I);
BB_copy=BB;
BB(1)=BB(1)-(BB(1)/2);
BB(2)=BB(2)-(BB(2)/2);
BB(3)=BB(3)+(BB(1)*2);
BB(4)=BB(4)+(BB(1)*2);
img_clipped=imcrop(I,BB);
img_clipped2 = imresize(img_clipped, [200 180]);
imwrite(img_clipped2,'.\temp\temp.jpg');
TestImage='.\temp\temp.jpg';
%------------------------------------- PCA starts -------------------------------------%
recog_img = facerecog(datapath,TestImage)
figure;
subplot(2,2,1);
imshow(inputimg);
title('Step 1: Input image');
test_img = imread(TestImage);
subplot(2,2,2)
imshow(I); 
for i = 1:size(BB_copy,1)
    rectangle('Position',BB_copy(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','g');
end
title('Step 2: Face Detection (Viola Jones algo)');
subplot(2,2,3)
imshow(imcrop(I,BB_copy));
title('Step 3: Cropped Face');
selected_img = strcat(datapath,'\',recog_img);
select_img = imread(selected_img);
subplot(2,2,4);
imshow(select_img);

%------------------------------------- PCA ends -------------------------------------%
img_name=name_recognition( recog_img );
title(strcat('Output: ',img_name));
result = strcat('the recognized image is : ',recog_img);
result_name = strcat('Name: ',img_name);
% result_name = strcat('Name: ',img_rollno);
% result_name = strcat('Name: ',img_gender);
disp(result);


SA;
% --- Executes on button press in sentiment.
function sentiment_Callback(hObject, eventdata, handles)
% hObject    handle to sentiment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in training.
function training_Callback(hObject, eventdata, handles)
% hObject    handle to training (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectTraining


