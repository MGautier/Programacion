function varargout = guimiamodulo2(varargin)
% GUIMIAMODULO2 MATLAB code for guimiamodulo2.fig
%      GUIMIAMODULO2, by itself, creates a new GUIMIAMODULO2 or raises the existing
%      singleton*.
%
%      H = GUIMIAMODULO2 returns the handle to a new GUIMIAMODULO2 or the handle to
%      the existing singleton*.
%
%      GUIMIAMODULO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIMIAMODULO2.M with the given input arguments.
%
%      GUIMIAMODULO2('Property','Value',...) creates a new GUIMIAMODULO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guimiamodulo2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guimiamodulo2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guimiamodulo2

% Last Modified by GUIDE v2.5 10-Dec-2013 21:21:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guimiamodulo2_OpeningFcn, ...
                   'gui_OutputFcn',  @guimiamodulo2_OutputFcn, ...
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


% --- Executes just before guimiamodulo2 is made visible.
function guimiamodulo2_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guimiamodulo2 (see VARARGIN)

% Choose default command line output for guimiamodulo2
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guimiamodulo2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guimiamodulo2_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Salir.
function Salir_Callback(~, ~, ~)
% hObject    handle to Salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;



% --- Executes on button press in Ayuda.
function Ayuda_Callback(~, ~, handles)
% hObject    handle to Ayuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ayuda;

if(ayuda == 0)
    set(handles.TextoAyuda,'Visible','on');
    ayuda = 1;
else
    set(handles.TextoAyuda,'Visible','off');
    ayuda = 0;
end


% --- Executes on button press in Abrir.
function Abrir_Callback(hObject, ~, handles)
% hObject    handle to Abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, ~, filterindex] = uigetfile( ...
{  '*.tif','TIFF(Tagged Image File Format)'; ...
   '*.jpg;*.jpeg','Imagenes (*.jpeg, *.jpg)'; ...
   '*.bmp',  'Mapa de bits (*.bmp)'; ...
   '*.*',  'Todos los archivos (*.*)'}, ...
   'Selecciona los archivos', ...
   'MultiSelect', 'on');
if iscell(filename)
    nbfiles = length(filename);
elseif filename == 0
    nbfiles = 0;
else
    nbfiles = 1;
end

%Esta funcion lo que nos permite es borrar todo el axes directamente
%children_axes1 = get(handles.axes1,'children');
%delete(children_axes1, children_axes2, children_axes3);


%Esta funcion lo que nos permite es eliminar o resetear
% el contenido interno del axes (como el paint de un canvas java)
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');


if(nbfiles == 1)
    handles.nombre1 = filename;
    tipo = imfinfo(handles.nombre1);
    
    if tipo.ColorType == 'grayscale'
        handles.imagen1 = imread(filename);
    else
        handles.imagen1 = rgb2gray(imread(filename));
    end
    axes(handles.axes1), imshow(handles.imagen1); 
    handles.posicion1 = get(handles.axes1,'Position');
    guidata(hObject, handles);
end
if(nbfiles >= 2)
    handles.nombre2 = filename{2};
    handles.imagen1 = imread(filename{1});
    axes(handles.axes1), imshow(handles.imagen1); 
    handles.imagen2 = imread(filename{2});
    axes(handles.axes2), imshow(handles.imagen2); 
    set(handles.text2,'Visible','on');
    handles.posicion2 = get(handles.axes2,'Position');
    guidata(hObject, handles);
end
if(nbfiles >= 3)
    handles.nombre3 = filename{3};
    handles.imagen3 = imread(filename{3});
    axes(handles.axes3), imshow(handles.imagen3); 
    set(handles.text3,'Visible','on');
    handles.posicion3 = get(handles.axes3,'Position');
    guidata(hObject, handles);
end

guidata(hObject, handles);

% --- Executes on button press in Barracolor.
function Barracolor_Callback(~, ~, handles)
% hObject    handle to Barracolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.checkbox1,'Value') == 1)
    axes(handles.axes1),imshow(handles.imagen1);
    colorbar;
    set(handles.axes1,'Position',handles.posicion1);    
else
    axes(handles.axes1), imshow(handles.imagen1);
    colorbar('off');
    set(handles.axes1,'Position',handles.posicion1);
    
end

global posicion2;
posicion2 = get(handles.axes2,'Position');
if(get(handles.checkbox2,'Value') == 1)
    posicion2 = get(handles.axes2,'Position');
    imagen2 = getimage(handles.axes2);
    axes(handles.axes2),imshow(imagen2);
    colorbar;
    set(handles.axes2,'Position',posicion2); 
else
    imagen2 = getimage(handles.axes2);
    axes(handles.axes2), imshow(imagen2);
    colorbar('off');
    set(handles.axes2,'Position',posicion2);
end


global posicion3;
posicion3 = get(handles.axes3,'Position');
if(get(handles.checkbox3,'Value') == 1)
    imagen3= getimage(handles.axes3);
    axes(handles.axes3),imshow(imagen3);
    colorbar;
    set(handles.axes3,'Position',posicion3);
else
    imagen3 = getimage(handles.axes3);
    axes(handles.axes3), imshow(imagen3);
    colorbar('off');
    set(handles.axes3,'Position',posicion3);
end


% --- Executes on button press in Guardar.
function Guardar_Callback(~, ~, handles)
% hObject    handle to Guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, extension, cancelar] = imputfile;

if cancelar == 1, return; end

imwrite(handles.imagen1, filename, extension);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(~, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
if(get(handles.checkbox1,'Value') == get(handles.checkbox1,'Max'))
    set(handles.checkbox2,'Value',0);
    set(handles.checkbox3,'Value',0);
else
    set(handles.checkbox1,'Value',0);
end

% --- Executes on button press in checkbox2.
function checkbox2_Callback(~, ~, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
if(get(handles.checkbox2,'Value') == get(handles.checkbox2,'Max'))
    set(handles.checkbox1,'Value',0);
    set(handles.checkbox3,'Value',0);
else
    set(handles.checkbox2,'Value',0);
end

% --- Executes on button press in checkbox3.
function checkbox3_Callback(~, ~, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
if(get(handles.checkbox3,'Value') == get(handles.checkbox3,'Max'))
    set(handles.checkbox1,'Value',0);
    set(handles.checkbox2,'Value',0);
else
    set(handles.checkbox3,'Value',0);
end


% --- Executes on button press in eraseaxes.
function eraseaxes_Callback(~, ~, handles)
% hObject    handle to eraseaxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(get(handles.checkbox1,'Value') == get(handles.checkbox1,'Max'))
    cla(handles.axes1,'reset');
end

if(get(handles.checkbox2,'Value') == get(handles.checkbox2,'Max'))
    cla(handles.axes2,'reset');
end

if(get(handles.checkbox3,'Value') == get(handles.checkbox3,'Max'))
    cla(handles.axes3,'reset');
end

function msetext_Callback(~, ~, ~)
% hObject    handle to msetext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of msetext as text
%        str2double(get(hObject,'String')) returns contents of msetext as a double


% --- Executes during object creation, after setting all properties.
function msetext_CreateFcn(hObject, ~, ~)
% hObject    handle to msetext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in uniformbutton.
function uniformbutton_Callback(hObject, eventdata, handles)
% hObject    handle to uniformbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
int_a = str2double(get(handles.intervala,'String'));
int_b = str2double(get(handles.intervalb,'String'));
img = double(getimage(handles.axes1));
ruido = int_a + (int_b-int_a).*(rand(size(img)));
img_ruido = img + ruido;
img_final = uint8(max(min(img_ruido,255),0));
axes(handles.axes2),imshow(img_final);
error_cuadratico_ruidos(hObject,eventdata,handles);
snr_ruidos(hObject,eventdata,handles,ruido);



function intervala_Callback(hObject, eventdata, handles)
% hObject    handle to intervala (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intervala as text
%        str2double(get(hObject,'String')) returns contents of intervala as a double


% --- Executes during object creation, after setting all properties.
function intervala_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intervala (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intervalb_Callback(hObject, eventdata, handles)
% hObject    handle to intervalb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intervalb as text
%        str2double(get(hObject,'String')) returns contents of intervalb as a double


% --- Executes during object creation, after setting all properties.
function intervalb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intervalb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gausaditivo.
function gausaditivo_Callback(hObject, eventdata, handles)
% hObject    handle to gausaditivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

media = str2num(get(handles.mediagaus,'String'));
varian = str2num(get(handles.gausvarian,'String'));
img = getimage(handles.axes1);
ruido = media + sqrt(varian).*(randn(size(img)));
img_ruido = img + uint8(ruido);
axes(handles.axes2),imshow(img_ruido);
error_cuadratico_ruidos(hObject,eventdata,handles);
snr_ruidos(hObject,eventdata,handles,ruido);



function mediagaus_Callback(hObject, eventdata, handles)
% hObject    handle to mediagaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mediagaus as text
%        str2double(get(hObject,'String')) returns contents of mediagaus as a double


function error_cuadratico_ruidos(hObject, eventdata, handles)
imag_origen = double(getimage(handles.axes1));
imag_destino = double(getimage(handles.axes2));
    
error = imag_origen - imag_destino;
[M N] = size(imag_origen);
mse = sum(sum(error.^2)) / (M * N);


set(handles.editmse12,'String',mse);

function error_cuadratico_filtros(hObject, eventdata, handles)
imag_origen = double(getimage(handles.axes1));
imag_destino = double(getimage(handles.axes3));
error = imag_origen - imag_destino;
[M N] = size(imag_origen);
mse = sum(sum(error.^2)) / (M * N);
set(handles.editmse13,'String',mse);

    

function isnr(hObject, eventdata, handles, filtro)
imag_original = double(getimage(handles.axes1));
imag_observada = double(getimage(handles.axes2));
numerador = sum(sum((imag_original - imag_observada).^2));
denominador = sum(sum((imag_original - double(filtro)).^2));
isnr = 10*log10((numerador)/(denominador));
set(handles.textoisnr,'String',isnr);

function snr_ruidos(hObject, eventdata, handles, ruido)
imag = double(getimage(handles.axes1));
numerador = sum(sum((imag - mean2(imag)).^2));
denominador = sum(sum(double(ruido).^2));
snr = 10*log10((numerador)/(denominador));
set(handles.editsnr12,'String',snr);

function snr_filtros(hObject, eventdata, handles, ruido)
imag = double(getimage(handles.axes1));
numerador = sum(sum((imag - mean2(imag)).^2));
denominador = sum(sum(double(ruido).^2));
snr = 10*log10((numerador)/(denominador));
set(handles.editsnr13,'String',snr);



% --- Executes during object creation, after setting all properties.
function mediagaus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mediagaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gausvarian_Callback(hObject, eventdata, handles)
% hObject    handle to gausvarian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gausvarian as text
%        str2double(get(hObject,'String')) returns contents of gausvarian as a double


% --- Executes during object creation, after setting all properties.
function gausvarian_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gausvarian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonsalpimi.
function buttonsalpimi_Callback(hObject, eventdata, handles)
% hObject    handle to buttonsalpimi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sal = (str2num(get(handles.textosal,'String')))/100;
pimi = (str2num(get(handles.textopimi,'String')))/100;
img = getimage(handles.axes1);
ruido = rand(size(img));
q = find(ruido>=0 & ruido<=sal);
p = find(ruido>sal & ruido<=sal+pimi);
img_ruido = img;
img_ruido(q) = 255;
img_ruido(p) = 0;
axes(handles.axes2),imshow(img_ruido);
error_cuadratico_ruidos(hObject,eventdata,handles);
snr_ruidos(hObject,eventdata,handles,(double(img_ruido)-double(img)));

function textosal_Callback(hObject, eventdata, handles)
% hObject    handle to textosal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textosal as text
%        str2double(get(hObject,'String')) returns contents of textosal as a double


% --- Executes during object creation, after setting all properties.
function textosal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textosal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textopimi_Callback(hObject, eventdata, handles)
% hObject    handle to textopimi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textopimi as text
%        str2double(get(hObject,'String')) returns contents of textopimi as a double


% --- Executes during object creation, after setting all properties.
function textopimi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textopimi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gausmultipli.
function gausmultipli_Callback(hObject, eventdata, handles)
% hObject    handle to gausmultipli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

img = getimage(handles.axes1);
alpha = double(str2num(get(handles.gausalpha,'String')));
ruido = alpha.*(randn(size(img)));
img_ruido = img .* uint8(ruido);
axes(handles.axes2),imshow(img_ruido);
error_cuadratico_ruidos(hObject,eventdata,handles);
snr_ruidos(hObject,eventdata,handles,ruido);



function gausalpha_Callback(hObject, eventdata, handles)
% hObject    handle to gausalpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gausalpha as text
%        str2double(get(hObject,'String')) returns contents of gausalpha as a double


% --- Executes during object creation, after setting all properties.
function gausalpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gausalpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textosnr_Callback(hObject, eventdata, handles)
% hObject    handle to textosnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textosnr as text
%        str2double(get(hObject,'String')) returns contents of textosnr as a double


% --- Executes during object creation, after setting all properties.
function textosnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textosnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textoisnr_Callback(hObject, eventdata, handles)
% hObject    handle to textoisnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textoisnr as text
%        str2double(get(hObject,'String')) returns contents of textoisnr as a double


% --- Executes during object creation, after setting all properties.
function textoisnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textoisnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filtrogaus.
function filtrogaus_Callback(hObject, eventdata, handles)
% hObject    handle to filtrogaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
alpha = double(str2num(get(handles.textfiltrogaus,'String')));
tipo_mascara = 5 * alpha;
sigma = sqrt(tipo_mascara);
h = fspecial('gaussian',tipo_mascara,sigma);
img_ruido = getimage(handles.axes2);
img_filtro = imfilter(img_ruido,h,'same','conv','replicate');
axes(handles.axes3),imshow(img_filtro);
error_cuadratico_filtros(hObject,eventdata,handles);
snr_filtros(hObject, eventdata, handles,double(img_filtro));
isnr(hObject, eventdata, handles, img_filtro);


function textfiltrogaus_Callback(hObject, eventdata, handles)
% hObject    handle to textfiltrogaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textfiltrogaus as text
%        str2double(get(hObject,'String')) returns contents of textfiltrogaus as a double


% --- Executes during object creation, after setting all properties.
function textfiltrogaus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textfiltrogaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filtromedio.
function filtromedio_Callback(hObject, eventdata, handles)
% hObject    handle to filtromedio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tam_matrix = str2num(get(handles.textotam,'String'));
h = fspecial('average',tam_matrix);
img_ruido = getimage(handles.axes2);
img_filtro = imfilter(img_ruido,h,'replicate');
axes(handles.axes3),imshow(img_filtro);
error_cuadratico_filtros(hObject,eventdata,handles);
snr_filtros(hObject, eventdata, handles,double(img_filtro));
isnr(hObject, eventdata, handles, img_filtro);



% --- Executes on button press in filtromin.
function filtromin_Callback(hObject, eventdata, handles)
% hObject    handle to filtromin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tam_matrix = str2num(get(handles.textotam,'String'));
img_ruido = getimage(handles.axes2);
img_filtro = ordfilt2(img_ruido,1,ones(tam_matrix,tam_matrix),'symmetric');
axes(handles.axes3),imshow(img_filtro);
error_cuadratico_filtros(hObject,eventdata,handles);
snr_filtros(hObject, eventdata, handles,double(img_filtro));
isnr(hObject, eventdata, handles, img_filtro);


% --- Executes on button press in filtromediana.
function filtromediana_Callback(hObject, eventdata, handles)
% hObject    handle to filtromediana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tam_matrix = str2num(get(handles.textotam,'String'));
img_ruido = getimage(handles.axes2);
img_filtro = medfilt2(img_ruido,[tam_matrix,tam_matrix]);
axes(handles.axes3),imshow(img_filtro);
error_cuadratico_filtros(hObject,eventdata,handles);
snr_filtros(hObject, eventdata, handles,double(img_filtro));
isnr(hObject, eventdata, handles, img_filtro);



% --- Executes on button press in filtromax.
function filtromax_Callback(hObject, eventdata, handles)
% hObject    handle to filtromax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tam_matrix = str2num(get(handles.textotam,'String'));
img_ruido = getimage(handles.axes2);
img_filtro = ordfilt2(img_ruido,tam_matrix*tam_matrix,ones(tam_matrix,tam_matrix),'symmetric');
axes(handles.axes3),imshow(img_filtro);
error_cuadratico_filtros(hObject,eventdata,handles);
snr_filtros(hObject, eventdata, handles,double(img_filtro));
isnr(hObject, eventdata, handles, img_filtro);



function textotam_Callback(hObject, eventdata, handles)
% hObject    handle to textotam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textotam as text
%        str2double(get(hObject,'String')) returns contents of textotam as a double


% --- Executes during object creation, after setting all properties.
function textotam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textotam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in difer12.
function difer12_Callback(hObject, eventdata, handles)
% hObject    handle to difer12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imag_origen = getimage(handles.axes1);
imag_destino = getimage(handles.axes2);
diferencia = double(imag_origen) - double(imag_destino);
figure('name','Diferencias entre Imagen 1 e Imagen 2'), imshow(diferencia), caxis([-255 255]), acolormap(gray(256)), colorbar;


% --- Executes on button press in difer13.
function difer13_Callback(hObject, eventdata, handles)
% hObject    handle to difer13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imag_origen = getimage(handles.axes1);
imag_destino = getimage(handles.axes3);
diferencia = double(imag_origen) - double(imag_destino);
figure('name','Diferencias entre Imagen 1 e Imagen 3'), imagesc(diferencia), colormap(gray(256)), colorbar;



% --- Executes on button press in difer23.
function difer23_Callback(hObject, eventdata, handles)
% hObject    handle to difer23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imag_origen = getimage(handles.axes2);
imag_destino = getimage(handles.axes3);
diferencia = double(imag_origen) - double(imag_destino);
figure('name','Diferencias entre Imagen 2 e Imagen 3'), imagesc(diferencia), colormap(gray(256)), colorbar;
