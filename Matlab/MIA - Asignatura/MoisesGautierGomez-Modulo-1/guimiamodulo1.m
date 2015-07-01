function varargout = guimiamodulo1(varargin)
% GUIMIAMODULO1 MATLAB code for guimiamodulo1.fig
%      GUIMIAMODULO1, by itself, creates a new GUIMIAMODULO1 or raises the existing
%      singleton*.
%
%      H = GUIMIAMODULO1 returns the handle to a new GUIMIAMODULO1 or the handle to
%      the existing singleton*.
%
%      GUIMIAMODULO1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIMIAMODULO1.M with the given input arguments.
%
%      GUIMIAMODULO1('Property','Value',...) creates a new GUIMIAMODULO1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guimiamodulo1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guimiamodulo1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guimiamodulo1

% Last Modified by GUIDE v2.5 12-Nov-2013 23:37:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guimiamodulo1_OpeningFcn, ...
                   'gui_OutputFcn',  @guimiamodulo1_OutputFcn, ...
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


% --- Executes just before guimiamodulo1 is made visible.
function guimiamodulo1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guimiamodulo1 (see VARARGIN)

% Choose default command line output for guimiamodulo1
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guimiamodulo1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guimiamodulo1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Salir.
function Salir_Callback(hObject, eventdata, handles)
% hObject    handle to Salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;



% --- Executes on button press in Ayuda.
function Ayuda_Callback(hObject, eventdata, handles)
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
function Abrir_Callback(hObject, eventdata, handles)
% hObject    handle to Abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile( ...
{  '*.tif','TIFF(Tagged Image File Format)'; ...
   '*.jpg;*.jpeg','Imagenes (*.jpeg, *.jpg)'; ...
   '*.bmp',  'Mapa de bits (*.bmp)'; ...
   '*.*',  'Todos los archivos (*.*)'}, ...
   'Selecciona los archivos', ...
   'MultiSelect', 'on');
if iscell(filename)
    nbfiles = length(filename)
elseif filename == 0
    nbfiles = 0
else
    nbfiles = 1
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
function Barracolor_Callback(hObject, eventdata, handles)
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
function Guardar_Callback(hObject, eventdata, handles)
% hObject    handle to Guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, extension, cancelar] = imputfile;

if cancelar == 1, return; end

imwrite(handles.imagen1, filename, extension);


% --- Executes on button press in Submuestreo.
function Submuestreo_Callback(hObject, eventdata, handles)
% hObject    handle to Submuestreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
submuestra = getimage(handles.axes1);
factor = str2num(get(handles.textomuestreo,'String'));
global resultado;
resultado = submuestra(1:factor:end,1:factor:end,1:1:end);

if(get(handles.checkboxpromedio,'Value') == 1)
    filtrobidim = fspecial('average');
    promedio = imfilter(resultado,filtrobidim);
    resultado = promedio;
end

axes(handles.axes2),imshow(resultado);


% --- Executes on button press in Interpolacion.
function Interpolacion_Callback(hObject, eventdata, handles)
% hObject    handle to Interpolacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
factor = str2num(get(handles.textomuestreo,'String'));
imagen = getimage(handles.axes2);
if(get(handles.checkboxbilineal,'Value') == 1)
    bilineal = imresize(imagen,factor,'bilinear');
    axes(handles.axes3),imshow(bilineal);
end

if(get(handles.checkboxvecino,'Value') == 1)
    vecino = imresize(imagen,factor,'nearest');
    axes(handles.axes3),imshow(vecino);
end

if(get(handles.checkboxcubica,'Value') == 1)
    bicubic = imresize(imagen,factor,'bicubic');
    axes(handles.axes3),imshow(bicubic);
end


% --- Executes on button press in Diferencias.
function Diferencias_Callback(hObject, eventdata, handles)
% hObject    handle to Diferencias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imag_origen = getimage(handles.axes1);
imag_destino = getimage(handles.axes3);
diferencia = double(imag_origen) - double(imag_destino);
figure('name','Diferencias entre Imagen 1 e Imagen3'), imagesc(diferencia), colormap(gray(256)), colorbar;

% --- Executes on button press in MSE.
function MSE_Callback(hObject, eventdata, handles)
% hObject    handle to MSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imag_origen = double(getimage(handles.axes1));
imag_destino = double(getimage(handles.axes3));
error = imag_origen - imag_destino;
[M N] = size(imag_origen);
mse = sum(sum(error .* error)) / (M * N);
set(handles.msetext,'String',mse);



% --- Executes on button press in MapaColor.
function MapaColor_Callback(hObject, eventdata, handles)
% hObject    handle to MapaColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
color = get(handles.MapaColor,'Value');
nivel = str2num(get(handles.nivelcolor,'String'));

if(color == 1)
    colormap(gray(nivel));
end
if(color == 2)
    colormap(copper(nivel));
end
if(color == 3)
    colormap(flag(nivel));
end
if(color == 4)
    colormap(hot(nivel));
end
if(color == 5)
    colormap(jet(nivel));
end
if(color == 6)
    colormap(lines(nivel));
end
if(color == 7)
    colormap(pink(nivel));
end
if(color == 8)
    colormap(prism(nivel));
end
if(color == 9)
    colormap(spring(nivel));
end
if(color == 10)
    colormap(summer(nivel));
end
if(color == 11)
    colormap(winter(nivel));
end


    

% --- Executes on button press in NivelColor.
function NivelColor_Callback(hObject, eventdata, handles)
% hObject    handle to NivelColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
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
function checkbox2_Callback(hObject, eventdata, handles)
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
function checkbox3_Callback(hObject, eventdata, handles)
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



function textomuestreo_Callback(hObject, eventdata, handles)
% hObject    handle to textomuestreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textomuestreo as text
%        str2double(get(hObject,'String')) returns contents of textomuestreo as a double


% --- Executes during object creation, after setting all properties.
function textomuestreo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textomuestreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in eraseaxes.
function eraseaxes_Callback(hObject, eventdata, handles)
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


% --- Executes on button press in checkboxbilineal.
function checkboxbilineal_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxbilineal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxbilineal
if(get(handles.checkboxbilineal,'Value') == get(handles.checkboxbilineal,'Max'))
    set(handles.checkboxvecino,'Value',0);
    set(handles.checkboxcubica,'Value',0);
else
    set(handles.checkboxbilineal,'Value',0);
end


% --- Executes on button press in checkboxvecino.
function checkboxvecino_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxvecino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxvecino
if(get(handles.checkboxvecino,'Value') == get(handles.checkboxvecino,'Max'))
    set(handles.checkboxbilineal,'Value',0);
    set(handles.checkboxcubica,'Value',0);
else
    set(handles.checkboxvecino,'Value',0);
end


% --- Executes on button press in checkboxcubica.
function checkboxcubica_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxcubica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxcubica
if(get(handles.checkboxcubica,'Value') == get(handles.checkboxcubica,'Max'))
    set(handles.checkboxbilineal,'Value',0);
    set(handles.checkboxvecino,'Value',0);
else
    set(handles.checkboxcubica,'Value',0);
end



function msetext_Callback(hObject, eventdata, handles)
% hObject    handle to msetext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of msetext as text
%        str2double(get(hObject,'String')) returns contents of msetext as a double


% --- Executes during object creation, after setting all properties.
function msetext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to msetext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nivelcolor_Callback(hObject, eventdata, handles)
% hObject    handle to nivelcolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nivelcolor as text
%        str2double(get(hObject,'String')) returns contents of nivelcolor as a double


% --- Executes during object creation, after setting all properties.
function nivelcolor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nivelcolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxpromedio.
function checkboxpromedio_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxpromedio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxpromedio
