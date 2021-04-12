function varargout = semillasCyF(varargin)
% SEMILLASCYF MATLAB code for semillasCyF.fig
%      SEMILLASCYF, by itself, creates a new SEMILLASCYF or raises the existing
%      singleton*.
%
%      H = SEMILLASCYF returns the handle to a new SEMILLASCYF or the handle to
%      the existing singleton*.
%
%      SEMILLASCYF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEMILLASCYF.M with the given input arguments.
%
%      SEMILLASCYF('Property','Value',...) creates a new SEMILLASCYF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before semillasCyF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to semillasCyF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help semillasCyF

% Last Modified by GUIDE v2.5 25-May-2017 23:19:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @semillasCyF_OpeningFcn, ...
                   'gui_OutputFcn',  @semillasCyF_OutputFcn, ...
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


% --- Executes just before semillasCyF is made visible.
function semillasCyF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to semillasCyF (see VARARGIN)

% Choose default command line output for semillasCyF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes semillasCyF wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = semillasCyF_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global img;
[nom dire]=uigetfile('*.jpg','Abrir');
if nom == 0
    return
end
img=imread(fullfile(dire,nom));
subplot(handles.axes1);
imshow(img);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global img;
global TotsemA;
global TotsemB;
global TotsemC;
global TotsemD;
global TotsemE;
global TotsemF;
global B;
global G;
global R;
global Y;
global M;
global C;

%%Diferenciar colores
 
imR= double(img(:,:,1));
imB= double(img(:,:,3));
imG= double(img(:,:,2));

imgB= (imB-imG-imR);
imgG= (imG-imB-imR);
imgR= (imR-imB-imG);
imgY= (imR-imB+imG);
imgM= (imR+imB-imG);
imgC= (imB+imG-imR);

%%imagen binaria
imgbinB= imgB < 50;
imgbinG= imgG < 16;
imgbinR= imgR < 50;
imgbinY= imgY < 400;
imgbinM= imgM < 350;
imgbinC= imgC < 450;

%%Delineando
imbifB= medfilt2(imgbinB);
imbifG= medfilt2(imgbinG);
imbifR= medfilt2(imgbinR);
imbifY= medfilt2(imgbinY);
imbifM= medfilt2(imgbinM);
imbifC= medfilt2(imgbinC);

imaB= bwareaopen(imbifB, 13);
imaG= bwareaopen(imbifG, 13);
imaR= bwareaopen(imbifR, 13);
imaY= bwareaopen(imbifY, 13);
imaM= bwareaopen(imbifM, 13);
imaC= bwareaopen(imbifC, 13);

%%Negativo de la imagen
%Azul
imgDob=im2double(imaB);
[xm, ym]=size(imgDob);         
for x=1:xm
    for y=1:ym
        imgNeg(x,y)= 1 - imgDob(x,y);
    end
end
B= im2uint8(imgNeg);
save B;
clear
load B;
%Verde
imgDob=im2double(imaG);
[xm, ym]=size(imgDob);         
for x=1:xm
    for y=1:ym
        imgNeg(x,y)= 1 - imgDob(x,y);
    end
end
G= im2uint8(imgNeg);
save G;
clear
load G;
%Roja
imgDob=im2double(imaR);
[xm, ym]=size(imgDob);         
for x=1:xm
    for y=1:ym
        imgNeg(x,y)= 1 - imgDob(x,y);
    end
end
R= im2uint8(imgNeg);
save R;
clear
load R;
%Amarilla
imgDob=im2double(imaY);
[xm, ym]=size(imgDob);         
for x=1:xm
    for y=1:ym
        imgNeg(x,y)= 1 - imgDob(x,y);
    end
end
Y= im2uint8(imgNeg);
save Y;
clear
load Y;
%Magenta
imgDob=im2double(imaM);
[xm, ym]=size(imgDob);         
for x=1:xm
    for y=1:ym
        imgNeg(x,y)= 1 - imgDob(x,y);
    end
end
M= im2uint8(imgNeg);
save M;
clear
load M;
%Cyan
imgDob=im2double(imaC);
[xm, ym]=size(imgDob);         
for x=1:xm
    for y=1:ym
        imgNeg(x,y)= 1 - imgDob(x,y);
    end
end
C= im2uint8(imgNeg);
save C;
clear
load C;

%%Contando y delineando semillas-------------------------------------------
%**********************************Azul
[L,numB] = bwlabel(B);
hold on
B2= bwboundaries(B);
for i=1:length(B2)
    boub=B2{i};
    plot(boub(:, 2), boub(:, 1), 'b', 'LineWidth', 2);
end
hold off
TotsemA= numB - 4;
%*******************************Verde
[L, numG] = bwlabel(G);
hold on
G2= bwboundaries(G);
for i=1:length(G2)
    boug=G2{i};
    plot(boug(:, 2), boug(:, 1), 'g', 'LineWidth', 2);
end
hold off
TotsemB= numG - 4;
%********************************Rojo 
[L,numR] = bwlabel(R);
hold on
R2= bwboundaries(R);
for i=1:length(R2)
    bour=R2{i};
    plot(bour(:, 2), bour(:, 1), 'r', 'LineWidth', 2);
end
hold off
TotsemC= numR - 4;
%********************************Amarillo 
[L,numY] = bwlabel(Y);
hold on
Y2= bwboundaries(Y);
for i=1:length(Y2)
    bouy=Y2{i};
    plot(bouy(:, 2), bouy(:, 1), 'y', 'LineWidth', 2);
end
hold off
TotsemD= numY - 4;
%********************************Magenta 
[L,numM] = bwlabel(M);
hold on
M2= bwboundaries(M);
for i=1:length(M2)
    boum=M2{i};
    plot(boum(:, 2), boum(:, 1), 'm', 'LineWidth', 2);
end
hold off
TotsemE= numM - 4;
%********************************Cyan 
[L,numC] = bwlabel(C);
hold on
C2= bwboundaries(C);
for i=1:length(C2)
    bouc=C2{i};
    plot(bouc(:, 2), bouc(:, 1), 'c', 'LineWidth', 2);
end
hold off
TotsemF= numC - 4;

TOT= TotsemA + TotsemB +TotsemC + TotsemD + TotsemE + TotsemF;
set(handles.text17,'String', TOT);


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)

global TotsemA;
global TotsemB;
global TotsemC;
global TotsemD;
global TotsemE;
global TotsemF;
global B;
global G;
global R;
global Y;
global M;
global C;

v=get(handles.popupmenu1,'Value');
switch v
    case 1
        
    case 2
        set(handles.text11,'String', TotsemC);
        subplot(handles.axes2);
        imshow(R);
    case 3
        set(handles.text11,'String', TotsemB);
        subplot(handles.axes2);
        imshow(G);
    case 4
        set(handles.text11,'String', TotsemA);
        subplot(handles.axes2);
        imshow(B);
    case 5
        set(handles.text11,'String', TotsemD);
        subplot(handles.axes2);
        imshow(Y);
    case 6
        set(handles.text11,'String', TotsemE);
        subplot(handles.axes2);
        imshow(M);
    case 7
        set(handles.text11,'String', TotsemF);
        subplot(handles.axes2);
        imshow(C);
end
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
