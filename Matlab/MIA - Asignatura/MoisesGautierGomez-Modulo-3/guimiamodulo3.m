function varargout = guimiamodulo3(varargin)
% GUIMIAMODULO3 MATLAB code for guimiamodulo3.fig
%      GUIMIAMODULO3, by itself, creates a new GUIMIAMODULO3 or raises the existing
%      singleton*.
%
%      H = GUIMIAMODULO3 returns the handle to a new GUIMIAMODULO3 or the handle to
%      the existing singleton*.
%
%      GUIMIAMODULO3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIMIAMODULO3.M with the given input arguments.
%
%      GUIMIAMODULO3('Property','Value',...) creates a new GUIMIAMODULO3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guimiamodulo3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guimiamodulo3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guimiamodulo3

% Last Modified by GUIDE v2.5 22-Jan-2014 02:05:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guimiamodulo3_OpeningFcn, ...
                   'gui_OutputFcn',  @guimiamodulo3_OutputFcn, ...
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


% --- Executes just before guimiamodulo3 is made visible.
function guimiamodulo3_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guimiamodulo3 (see VARARGIN)

% Choose default command line output for guimiamodulo3
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guimiamodulo3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guimiamodulo3_OutputFcn(~, ~, handles) 
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
{  '*.gif','GIF(Graphics Interchange Format)'; ...
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

%Establezco los valores de los checkbox a cero para que así cuando
% el usuario los seleccione no haya problemas
handles.var_horizontal = 0;
handles.var_vertical = 0;
handles.var_ambos = 0;

%Establezco los valores de los checkbox a cero para que así cuando
% el usuario los seleccione no haya problemas
handles.var_promedio = 0;
handles.var_gaussiano = 0;

%Establezco los valores de los checkbox a cero para que así cuando
% el usuario los seleccion no haya problemas
handles.var_frontera = 0;
handles.var_gradienteuno = 0;
handles.var_gradientedos = 0;
handles.var_maggradiente = 0;
handles.var_imgfront = 0;
handles.var_autovalor = 0;
handles.var_esquinas = 0;
handles.var_imagesquinas = 0;

%Voy a establecer unas variables en las que almacenaré las componentes
% del gradiente de cada algoritmo, ya sea en su versión de matlab
% cómo la realizada a mano, en dónde tendre el gradiente total, el de 45
% y 135. Así como otro cualquier otro dato que sea necesario transferir
% entre métodos de mi programa.

handles.imagen_original = 0;
handles.imagen_frontera = 0;
handles.gradiente_vertical = 0;
handles.gradiente_horizontal = 0;
handles.imagen_gradiente = 0;


if(nbfiles == 1)
    handles.nombre1 = filename;
    
    % Dado que la imagen es en formato GIF voy a obviar el paso
    % de comprobar del tipo de color de la imagen
    % Simplemente voy a leerla y a mostrarla en el axes.
    %tipo = imfinfo(handles.nombre1);
    %
    %if tipo.ColorType == 'grayscale'
    %    handles.imagen1 = imread(filename);
    %else
    %    handles.imagen1 = rgb2gray(imread(filename));
    %end
    
    handles.imagen1 = imread(filename,'gif');
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
else
    set(handles.checkbox2,'Value',0);
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

handles.imagen_original = getimage(handles.axes1);
imag_destino = getimage(handles.axes2);
diferencia = double(handles.imagen_original) - double(imag_destino);
figure('name','Diferencias entre Imagen 1 e Imagen 2'), imshow(diferencia), caxis([-255 255]), acolormap(gray(256)), colorbar;


% --- Executes on button press in matlabcheckbox.
function matlabcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to matlabcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of matlabcheckbox


% --- Executes on button press in botonRoberts.
function botonRoberts_Callback(hObject, eventdata, handles)
% hObject    handle to botonRoberts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img_filtro;
global img_1;
global img_2;

handles.imagen_original = double(getimage(handles.axes1));
umbral_matlab = str2double(get(handles.umbral,'String'));
set(handles.umbralmatlab,'String','-');
direccion = 'both';
if(handles.var_horizontal)
    direccion = 'horizontal';
end

if(handles.var_vertical)
    direccion = 'vertical';
end

if(handles.var_ambos)
    direccion = 'both';
end


if(get(handles.matlabcheckbox,'Value') == get(handles.matlabcheckbox,'Max'))    
    if(umbral_matlab > 0)
        handles.imagen_frontera = edge(handles.imagen_original,'roberts',umbral_matlab,direccion);
        guidata(hObject, handles);
    else
        [handles.imagen_frontera,umbral_matlab,handles.gradiente_vertical,handles.gradiente_horizontal] = edge(handles.imagen_original,'roberts',[],direccion);
        set(handles.umbralmatlab,'String',umbral_matlab);
        guidata(hObject, handles);
    end
    axes(handles.axes2), imshow(handles.imagen_frontera); 
else

    tam_matrix = str2num(get(handles.alisamientotam,'String'));
    mascara_1 = [1 0; 0 -1];
    mascara_2 = [0 -1; 1 0];
    
    if(handles.var_promedio == 1 && handles.var_gaussiano == 0)
        h = fspecial('average',tam_matrix);
        img_filtro = imfilter(handles.imagen_original,h,'replicate');
        img_1 = imfilter(img_filtro,mascara_1,'replicate'); %Rotada 45 grados
        img_2 = imfilter(img_filtro,mascara_2,'replicate'); %Rotada 45 grados
        prom = 'promedio'
    end
    if(handles.var_gaussiano == 1 && handles.var_promedio == 0)
        h = fspecial('gaussian',5*tam_matrix,sqrt(tam_matrix));
        img_filtro = imfilter(handles.imagen_original,h,'replicate');
        img_1 = imfilter(img_filtro,mascara_1,'replicate'); %Rotada 45 grados
        img_2 = imfilter(img_filtro,mascara_2,'replicate'); %Rotada 45 grados
        gaus = 'gaus'
    end
    
    if(handles.var_promedio == 0 && handles.var_gaussiano == 0)
        img_1 = imfilter(handles.imagen_original,mascara_1,'replicate'); %Rotada 45 grados
        img_2 = imfilter(handles.imagen_original,mascara_2,'replicate'); %Rotada 45 grados
        nada = 'nada'
    end
    
    handles.gradiente_vertical = img_1;
    handles.gradiente_horizontal = img_2;
    
    handles.imagen_gradiente = sqrt(double(img_1).^2 + double(img_2).^2);
    handles.imagen_frontera = handles.imagen_gradiente > umbral_matlab;
    
    if(handles.var_horizontal == 1)
        axes(handles.axes2),imshow(img_1); 
        handles.imagen_frontera = img_1;
        handles.imagen_gradiente = 0;
        guidata(hObject, handles);
    end
    if(handles.var_vertical == 1)
        axes(handles.axes2),imshow(img_2);
        handles.imagen_frontera = img_2;
        handles.imagen_gradiente = 0;
        guidata(hObject, handles);
    end
    if(handles.var_horizontal == 0 && handles.var_vertical == 0)
        axes(handles.axes2),imshow(handles.imagen_frontera);
        guidata(hObject, handles);
    end
    guidata(hObject, handles);
end


% --- Executes on button press in botonCanny.
function botonCanny_Callback(hObject, eventdata, handles)
% hObject    handle to botonCanny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.imagen_original = getimage(handles.axes1);
global umbral_matlab;

if isempty(get(handles.umbralinferior,'String'))
    umbral_inferior_matlab = 0;
else
    umbral_inferior_matlab = str2double(get(handles.umbralinferior,'String'));
end

if isempty(get(handles.umbralsuperior,'String'))
    umbral_superior_matlab = 0;
else
    umbral_superior_matlab = str2double(get(handles.umbralsuperior,'String'));
end

if isempty(get(handles.sigma,'String'))
    sigma_matlab = 1;
else
    sigma_matlab = str2double(get(handles.sigma,'String'));
end

if(get(handles.matlabcheckbox,'Value') == get(handles.matlabcheckbox,'Max'))    
    if(umbral_inferior_matlab > 0 || umbral_superior_matlab > 0)
        handles.imagen_frontera = edge(handles.imagen_original,'canny',...
            [umbral_inferior_matlab,umbral_superior_matlab],...
            sigma_matlab);
        guidata(hObject, handles);
    else
            [handles.imagen_frontera,umbral_matlab] = edge(handles.imagen_original,'canny',...
            [],sigma_matlab);
        guidata(hObject, handles);
            
    end
    
    handles.gradiente_vertical = 0;
    handles.gradiente_horizontal = 0;
    handles.imagen_gradiente = 0;
    
    axes(handles.axes2), imshow(handles.imagen_frontera); 
    set(handles.umbralinferior,'String',umbral_matlab(1));
    set(handles.umbralsuperior,'String',umbral_matlab(2));
    set(handles.sigma,'String',sigma_matlab);
   
end

function umbral_Callback(hObject, eventdata, handles)
% hObject    handle to umbral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of umbral as text
%        str2double(get(hObject,'String')) returns contents of umbral as a double


% --- Executes during object creation, after setting all properties.
function umbral_CreateFcn(hObject, eventdata, handles)
% hObject    handle to umbral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in botonPrewitt.
function botonPrewitt_Callback(hObject, eventdata, handles)
% hObject    handle to botonPrewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img_filtro;
global img_1;
global img_2;

handles.imagen_original = getimage(handles.axes1);
umbral_matlab = str2double(get(handles.umbral,'String'));
set(handles.umbralmatlab,'String','-');

direccion = 'both';
if(handles.var_horizontal)
    direccion = 'horizontal';
end

if(handles.var_vertical)
    direccion = 'vertical';
end

if(handles.var_ambos)
    direccion = 'both';
end


if(get(handles.matlabcheckbox,'Value') == get(handles.matlabcheckbox,'Max'))    
    if(umbral_matlab > 0)
        handles.imagen_frontera = edge(handles.imagen_original,'prewitt',umbral_matlab,direccion);
         guidata(hObject, handles);
    else
        [handles.imagen_frontera,umbral_matlab,handles.gradiente_vertical,handles.gradiente_horizontal] = edge(handles.imagen_original,'prewitt',[],direccion);
        set(handles.umbralmatlab,'String',umbral_matlab);
         guidata(hObject, handles);
    end
    axes(handles.axes2), imshow(handles.imagen_frontera); 
else
    tam_matrix = str2num(get(handles.alisamientotam,'String'));
    mascara_1 = [-1 0 1; -1 0 1; -1 0 1];
    mascara_2 = [-1 -1 -1; 0 0 0; 1 1 1];
    
    if(handles.var_promedio == 1 && handles.var_gaussiano == 0)
        h = fspecial('average',tam_matrix);
        img_filtro = imfilter(handles.imagen_original,h,'same','conv','replicate');
        img_1 = imfilter(img_filtro,mascara_1,'same','conv','replicate'); %Rotada 45 grados
        img_2 = imfilter(img_filtro,mascara_2,'same','conv','replicate'); %Rotada 45 grados
        prom = 'promedio'
    end
    if(handles.var_gaussiano == 1 && handles.var_promedio == 0)
        h = fspecial('gaussian',5*tam_matrix,sqrt(tam_matrix));
        img_filtro = imfilter(handles.imagen_original,h,'same','conv','replicate');
        img_1 = imfilter(img_filtro,mascara_1,'same','conv','replicate'); %Rotada 45 grados
        img_2 = imfilter(img_filtro,mascara_2,'same','conv','replicate'); %Rotada 45 grados
        gaus = 'gaus'
    end
    
    if(handles.var_promedio == 0 && handles.var_gaussiano == 0)
        img_1 = double(imfilter(handles.imagen_original,mascara_1,'same','conv','replicate')); %Rotada 45 grados
        img_2 = double(imfilter(handles.imagen_original,mascara_2,'same','conv','replicate')); %Rotada 45 grados
        nada = 'nada'
    end
  
    handles.gradiente_vertical = img_1;
    handles.gradiente_horizontal = img_2;
    
    handles.imagen_gradiente = sqrt(double(img_1).^2 + double(img_2).^2);
    handles.imagen_frontera = handles.imagen_gradiente > umbral_matlab;
    
    if(handles.var_horizontal == 1)
        axes(handles.axes2),imshow(img_1); 
        handles.imagen_frontera = img_1;
        handles.imagen_gradiente = 0;
        guidata(hObject, handles);
    end
    if(handles.var_vertical == 1)
        axes(handles.axes2),imshow(img_2);
        handles.imagen_frontera = img_2;
        handles.imagen_gradiente = 0;
        guidata(hObject, handles);
    end
    if(handles.var_horizontal == 0 && handles.var_vertical == 0)
        axes(handles.axes2),imshow(handles.imagen_frontera);
        guidata(hObject, handles);
    end
    guidata(hObject, handles);
end


% --- Executes on button press in botonSobel.
function botonSobel_Callback(hObject, eventdata, handles)
% hObject    handle to botonSobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global img_filtro;
global img_1;
global img_2;

handles.imagen_original = getimage(handles.axes1);
umbral_matlab = str2double(get(handles.umbral,'String'));
set(handles.umbralmatlab,'String','-');
direccion = 'both';
if(handles.var_horizontal)
    direccion = 'horizontal';
end

if(handles.var_vertical)
    direccion = 'vertical';
end

if(handles.var_ambos)
    direccion = 'both';
end

if(get(handles.matlabcheckbox,'Value') == get(handles.matlabcheckbox,'Max'))    
    if(umbral_matlab > 0)        
        handles.imagen_frontera = edge(handles.imagen_original,'sobel',umbral_matlab,direccion);
        guidata(hObject, handles);
    else
        [handles.imagen_frontera,umbral_matlab,handles.gradiente_vertical,handles.gradiente_horizontal] = edge(handles.imagen_original,'sobel',[],direccion);
        set(handles.umbralmatlab,'String',umbral_matlab);
        guidata(hObject, handles);
    end
    axes(handles.axes2), imshow(handles.imagen_frontera); 
else
    tam_matrix = str2num(get(handles.alisamientotam,'String'));
    mascara_1 = [-1 0 1; -2 0 2; -1 0 1]; %Vertical
    mascara_2 = [-1 -2 -1; 0 0 0; 1 2 1]; %Horizontal
    
    if(handles.var_promedio == 1 && handles.var_gaussiano == 0)
        h = fspecial('average',tam_matrix);
        img_filtro = imfilter(handles.imagen_original,h,'same','conv','replicate');
        img_1 = imfilter(img_filtro,mascara_1,'same','conv','replicate'); %Rotada 45 grados
        img_2 = imfilter(img_filtro,mascara_2,'same','conv','replicate'); %Rotada 45 grados
        prom = 'promedio'
    end
    if(handles.var_gaussiano == 1 && handles.var_promedio == 0)
        h = fspecial('gaussian',5*tam_matrix,sqrt(tam_matrix));
        img_filtro = imfilter(handles.imagen_original,h,'same','conv','replicate');
        img_1 = imfilter(img_filtro,mascara_1,'same','conv','replicate'); %Rotada 45 grados
        img_2 = imfilter(img_filtro,mascara_2,'same','conv','replicate'); %Rotada 45 grados
        gaus = 'gaus'
    end
    
    if(handles.var_promedio == 0 && handles.var_gaussiano == 0)
        
        img_1 = double(imfilter(handles.imagen_original,mascara_1,'same','conv','replicate'));
        img_2 = double(imfilter(handles.imagen_original,mascara_2,'same','conv','replicate'));
        nada = 'nada'
    end
   
    handles.gradiente_vertical = img_2;
    handles.gradiente_horizontal = img_1;
    
    handles.imagen_gradiente = sqrt(img_1.^2 + img_2.^2);
    handles.imagen_frontera = handles.imagen_gradiente > umbral_matlab;
    
    if(handles.var_horizontal == 1)
        axes(handles.axes2),imshow(img_2); 
        handles.imagen_frontera = img_2;
        handles.imagen_gradiente = 0;
        guidata(hObject, handles);
    end
    if(handles.var_vertical == 1)
        axes(handles.axes2),imshow(img_1);
        handles.imagen_frontera = img_1;
        handles.imagen_gradiente = 0;
        guidata(hObject, handles);
    end
    if(handles.var_horizontal == 0 && handles.var_vertical == 0)
        axes(handles.axes2),imshow(handles.imagen_frontera);
        guidata(hObject, handles);
    end
    guidata(hObject, handles);
end


% --- Executes on button press in horizontalcheckbox.
function horizontalcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to horizontalcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of horizontalcheckbox

if(get(handles.horizontalcheckbox,'Value') == get(handles.horizontalcheckbox,'Max'))
    set(handles.verticalcheckbox,'Value',0);
    set(handles.amboscheckbox,'Value',0);
    handles.var_horizontal = 1;
    handles.var_vertical = 0;
    handles.var_ambos = 0;
    guidata(hObject, handles);
else
    set(handles.horizontalcheckbox,'Value',0);
    handles.var_horizontal = 0;
    handles.var_vertical = 0;
    handles.var_ambos = 0;
    guidata(hObject, handles);
end

guidata(hObject, handles);


% --- Executes on button press in verticalcheckbox.
function verticalcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to verticalcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of verticalcheckbox

if(get(handles.verticalcheckbox,'Value') == get(handles.verticalcheckbox,'Max'))
    set(handles.horizontalcheckbox,'Value',0);
    set(handles.amboscheckbox,'Value',0);
    handles.var_horizontal = 0;
    handles.var_vertical = 1;
    handles.var_ambos = 0;
    guidata(hObject, handles);
else
    set(handles.verticalcheckbox,'Value',0);
    handles.var_horizontal = 0;
    handles.var_vertical = 0;
    handles.var_ambos = 0;
    guidata(hObject, handles);
end
guidata(hObject, handles);


% --- Executes on button press in amboscheckbox.
function amboscheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to amboscheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amboscheckbox

if(get(handles.amboscheckbox,'Value') == get(handles.amboscheckbox,'Max'))
    set(handles.verticalcheckbox,'Value',0);
    set(handles.horizontalcheckbox,'Value',0);
    handles.var_horizontal = 0;
    handles.var_vertical = 0;
    handles.var_ambos = 1;
    guidata(hObject, handles);
else
    set(handles.amboscheckbox,'Value',0);
    handles.var_horizontal = 0;
    handles.var_vertical = 0;
    handles.var_ambos = 0;
    guidata(hObject, handles);
end
guidata(hObject, handles);


function umbralinferior_Callback(hObject, eventdata, handles)
% hObject    handle to umbralinferior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of umbralinferior as text
%        str2double(get(hObject,'String')) returns contents of umbralinferior as a double


% --- Executes during object creation, after setting all properties.
function umbralinferior_CreateFcn(hObject, eventdata, handles)
% hObject    handle to umbralinferior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function umbralsuperior_Callback(hObject, eventdata, handles)
% hObject    handle to umbralsuperior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of umbralsuperior as text
%        str2double(get(hObject,'String')) returns contents of umbralsuperior as a double


% --- Executes during object creation, after setting all properties.
function umbralsuperior_CreateFcn(hObject, eventdata, handles)
% hObject    handle to umbralsuperior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sigma_Callback(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigma as text
%        str2double(get(hObject,'String')) returns contents of sigma as a double


% --- Executes during object creation, after setting all properties.
function sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alisamientotam_Callback(hObject, eventdata, handles)
% hObject    handle to alisamientotam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alisamientotam as text
%        str2double(get(hObject,'String')) returns contents of alisamientotam as a double


% --- Executes during object creation, after setting all properties.
function alisamientotam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alisamientotam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in promediocheckbox.
function promediocheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to promediocheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of promediocheckbox

if(get(handles.promediocheckbox,'Value') == get(handles.promediocheckbox,'Max'))
    set(handles.gaussianocheckbox,'Value',0);
    handles.var_promedio = 1;
    handles.var_gaussiano = 0;
    guidata(hObject, handles);
else
    set(handles.promediocheckbox,'Value',0);
    handles.var_promedio = 0;
    handles.var_gaussiano = 0;    
    guidata(hObject, handles);

end


% --- Executes on button press in gaussianocheckbox.
function gaussianocheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianocheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gaussianocheckbox

if(get(handles.gaussianocheckbox,'Value') == get(handles.gaussianocheckbox,'Max'))
    set(handles.promediocheckbox,'Value',0);
    handles.var_promedio = 0;
    handles.var_gaussiano = 1;
    guidata(hObject,handles);
else
    set(handles.gaussianocheckbox,'Value',0);
    handles.var_promedio = 0;
    handles.var_gaussiano = 0;
    guidata(hObject,handles);
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.umbralinferior,'String',' ');
set(handles.umbralsuperior,'String',' ');
set(handles.sigma,'String','');
set(handles.alisamientotam,'String',' ');
set(handles.umbral,'String',' ');
set(handles.promediocheckbox,'Value',0);
set(handles.gaussianocheckbox,'Value',0);
set(handles.horizontalcheckbox,'Value',0);
set(handles.verticalcheckbox,'Value',0);
set(handles.amboscheckbox,'Value',0);
set(handles.fronteracheckbox,'Value',0);
set(handles.gradienteunocheckbox,'Value',0);
set(handles.gradientedoscheckbox,'Value',0);
set(handles.maggradientecheckbox,'Value',0);
set(handles.imgfrontcheckbox,'Value',0);
    
handles.var_frontera = 0;
handles.var_gradienteuno = 0;
handles.var_gradientedos = 0;
handles.var_maggradiente = 0;
handles.var_imgfront = 0;

handles.var_horizontal = 0;
handles.var_vertical = 0;
handles.var_ambos = 0;

handles.var_promedio = 0;
handles.var_gaussiano = 0;

handles.var_gradienteuno = 0;
handles.var_gradientedos = 0;
handles.var_maggradiente = 0;
handles.var_imgfront = 0;

handles.imagen_original = 0;
handles.imagen_frontera = 0;
handles.gradiente_vertical = 0;
handles.gradiente_horizontal = 0;
handles.imagen_gradiente = 0;

handles.var_autovalor = 0;
handles.var_esquinas = 0;
handles.var_imagesquinas = 0;



% --- Executes on button press in botonesquinas.
function botonesquinas_Callback(hObject, eventdata, handles)
% hObject    handle to botonesquinas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.imagen_original = getimage(handles.axes1);
umbral = str2double(get(handles.umbralesquinas,'String'));
vecindario = str2double(get(handles.vecindario,'String'));
maximo = str2double(get(handles.maxlocal,'String'));


filtro = [-1 0 1];
Ix = imfilter(double(handles.imagen_original), filtro, 'replicate'); %Gradiente Horizontal
Iy = imfilter(double(handles.imagen_original), filtro', 'replicate'); %Gradiente Vertical

mascarasuma = ones(vecindario, vecindario);
Ix2 = Ix.^2;
sumaIx2 = double(imfilter(Ix2, mascarasuma, 'replicate'));
Iy2 = Iy.^2;
sumaIy2 = double(imfilter(Iy2, mascarasuma, 'replicate'));
Ixy = Ix.*Iy;
sumaIxy = double(imfilter(Ixy, mascarasuma, 'replicate'));

[nf nc] = size(handles.imagen_original);
autovalores = zeros(nf,nc);
for i = 1:nf
   for j = 1:nc
       C=([sumaIx2(i,j) sumaIxy(i,j); sumaIxy(i,j) sumaIy2(i,j)]);
       d = eig(C); %Obtenemos los dos autovalores
       autovalores(i,j) = min(d); %Guardamos el menor
   end
end

Esquinas = autovalores > umbral;
[f,c] = find(Esquinas);
[nEsquinas,m] = size(find(Esquinas));
set(handles.esquinasdetec,'String',int2str(nEsquinas));

if(get(handles.supmax,'Value') == get(handles.supmax,'Max'))
 filtro = ordfilt2(double(autovalores), maximo*maximo,ones(maximo,maximo));
 Esquinas = (double(autovalores) > umbral).*(double(autovalores) == filtro);
 [f,c] = find(double(Esquinas));
 [esquinas_max,x] = size(find(double(Esquinas)));
 suprimidas = nEsquinas - esquinas_max;
 set(handles.suprimidas,'String',int2str(suprimidas));
end

if(handles.var_autovalor == 1)
 axes(handles.axes2),imshow(double(autovalores),[],'InitialMagnification',100);
end
if(handles.var_esquinas == 1)
 axes(handles.axes2),imshow(double(Esquinas),[],'InitialMagnification',100);
end
if(handles.var_imagesquinas == 1)
    axes(handles.axes2), imshow(handles.imagen_original,[]), colormap(gray(256)), hold on;
     plot(c,f,'y+','MarkerSize',1.5);
end


function umbralesquinas_Callback(hObject, eventdata, handles)
% hObject    handle to umbralesquinas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of umbralesquinas as text
%        str2double(get(hObject,'String')) returns contents of umbralesquinas as a double


% --- Executes during object creation, after setting all properties.
function umbralesquinas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to umbralesquinas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxlocal_Callback(hObject, eventdata, handles)
% hObject    handle to maxlocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxlocal as text
%        str2double(get(hObject,'String')) returns contents of maxlocal as a double


% --- Executes during object creation, after setting all properties.
function maxlocal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxlocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in autovalorcheckbox.
function autovalorcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to autovalorcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of autovalorcheckbox

if(get(handles.autovalorcheckbox,'Value') == get(handles.autovalorcheckbox,'Max'))
    set(handles.esquinascheckbox,'Value',0);
    set(handles.imagesquinascheckbox,'Value',0);
    handles.var_autovalor = 1;
    handles.var_esquinas = 0;
    handles.var_imagesquinas = 0;
    guidata(hObject, handles);
else
    set(handles.autovalorcheckbox,'Value',0);
    handles.var_autovalor = 1;
    handles.var_esquinas = 0;
    handles.var_imagesquinas = 0;
    guidata(hObject, handles);
end
guidata(hObject, handles);


% --- Executes on button press in esquinascheckbox.
function esquinascheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to esquinascheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of esquinascheckbox

if(get(handles.esquinascheckbox,'Value') == get(handles.esquinascheckbox,'Max'))
    set(handles.autovalorcheckbox,'Value',0);
    set(handles.imagesquinascheckbox,'Value',0);
    handles.var_autovalor = 0;
    handles.var_esquinas = 1;
    handles.var_imagesquinas = 0;
    guidata(hObject, handles);
else
    set(handles.esquinascheckbox,'Value',0);
    handles.var_autovalor = 0;
    handles.var_esquinas = 0;
    handles.var_imagesquinas = 0;
    guidata(hObject, handles);
end
guidata(hObject, handles);


% --- Executes on button press in imagesquinascheckbox.
function imagesquinascheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to imagesquinascheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of imagesquinascheckbox

if(get(handles.imagesquinascheckbox,'Value') == get(handles.imagesquinascheckbox,'Max'))
    set(handles.esquinascheckbox,'Value',0);
    set(handles.autovalorcheckbox,'Value',0);
    handles.var_autovalor = 0;
    handles.var_esquinas = 0;
    handles.var_imagesquinas = 1;
    guidata(hObject, handles);
else
    set(handles.imagesquinascheckbox,'Value',0);
    handles.var_autovalor = 0;
    handles.var_esquinas = 0;
    handles.var_imagesquinas = 0;
    guidata(hObject, handles);
end
guidata(hObject, handles);



function vecindario_Callback(hObject, eventdata, handles)
% hObject    handle to vecindario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vecindario as text
%        str2double(get(hObject,'String')) returns contents of vecindario as a double


% --- Executes during object creation, after setting all properties.
function vecindario_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vecindario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fronteracheckbox.
function fronteracheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to fronteracheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fronteracheckbox

if(get(handles.fronteracheckbox,'Value') == get(handles.fronteracheckbox,'Max'))
    set(handles.gradienteunocheckbox,'Value',0);
    set(handles.gradientedoscheckbox,'Value',0);
    set(handles.maggradientecheckbox,'Value',0);
    set(handles.imgfrontcheckbox,'Value',0);
    
    handles.var_frontera = 1;
    handles.var_gradienteuno = 0;
    handles.var_gradientedos = 0;
    handles.var_maggradiente = 0;
    handles.var_imgfront = 0;
    
    if(handles.imagen_gradiente > 0)
        axes(handles.axes2),imshow(handles.imagen_gradiente);
    else
        axes(handles.axes2),imshow(handles.imagen_frontera);
    end

    guidata(hObject, handles);
else
    set(handles.fronteracheckbox,'Value',0);
    handles.var_frontera = 0;
    handles.var_gradienteuno = 0;
    handles.var_gradientedos = 0;
    handles.var_maggradiente = 0;
    handles.var_imgfront = 0;

    guidata(hObject, handles);
end

guidata(hObject, handles);


% --- Executes on button press in gradienteunocheckbox.
function gradienteunocheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to gradienteunocheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gradienteunocheckbox

if(get(handles.gradienteunocheckbox,'Value') == get(handles.gradienteunocheckbox,'Max'))
    set(handles.fronteracheckbox,'Value',0);
    set(handles.gradientedoscheckbox,'Value',0);
    set(handles.maggradientecheckbox,'Value',0);
    set(handles.imgfrontcheckbox,'Value',0);
    
    handles.var_frontera = 0;
    handles.var_gradienteuno = 1;
    handles.var_gradientedos = 0;
    handles.var_maggradiente = 0;
    handles.var_imgfront = 0;

    axes(handles.axes2),imshow(handles.gradiente_vertical,[]);

    guidata(hObject, handles);
else
    set(handles.gradienteunocheckbox,'Value',0);
    handles.var_frontera = 0;
    handles.var_gradienteuno = 0;
    handles.var_gradientedos = 0;
    handles.var_maggradiente = 0;
    handles.var_imgfront = 0;

    guidata(hObject, handles);
end

guidata(hObject, handles);

% --- Executes on button press in gradientedoscheckbox.
function gradientedoscheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to gradientedoscheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gradientedoscheckbox

if(get(handles.gradientedoscheckbox,'Value') == get(handles.gradientedoscheckbox,'Max'))
    set(handles.fronteracheckbox,'Value',0);
    set(handles.gradienteunocheckbox,'Value',0);
    set(handles.maggradientecheckbox,'Value',0);
    set(handles.imgfrontcheckbox,'Value',0);
    
    handles.var_frontera = 0;
    handles.var_gradienteuno = 0;
    handles.var_gradientedos = 1;
    handles.var_maggradiente = 0;
    handles.var_imgfront = 0;
    
    axes(handles.axes2),imshow(handles.gradiente_horizontal,[]);

    guidata(hObject, handles);
else
    set(handles.gradientedoscheckbox,'Value',0);
    handles.var_frontera = 0;
    handles.var_gradienteuno = 0;
    handles.var_gradientedos = 0;
    handles.var_maggradiente = 0;
    handles.var_imgfront = 0;

    guidata(hObject, handles);
end

guidata(hObject, handles);


% --- Executes on button press in maggradientecheckbox.
function maggradientecheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to maggradientecheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of maggradientecheckbox

if(get(handles.maggradientecheckbox,'Value') == get(handles.maggradientecheckbox,'Max'))
    set(handles.fronteracheckbox,'Value',0);
    set(handles.gradienteunocheckbox,'Value',0);
    set(handles.gradientedoscheckbox,'Value',0);
    set(handles.imgfrontcheckbox,'Value',0);
    
    handles.var_frontera = 0;
    handles.var_gradienteuno = 0;
    handles.var_gradientedos = 0;
    handles.var_maggradiente = 1;
    handles.var_imgfront = 0;
    
    gradiente = sqrt((double(handles.gradiente_vertical).^2)+(double(handles.gradiente_horizontal).^2));
    axes(handles.axes2),imshow(gradiente,[]);
    
    guidata(hObject, handles);
else
    set(handles.maggradientecheckbox,'Value',0);
    handles.var_frontera = 0;
    handles.var_gradienteuno = 0;
    handles.var_gradientedos = 0;
    handles.var_maggradiente = 0;
    handles.var_imgfront = 0;

    guidata(hObject, handles);
end

guidata(hObject, handles);


% --- Executes on button press in imgfrontcheckbox.
function imgfrontcheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to imgfrontcheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of imgfrontcheckbox

img_org = handles.imagen_original;



if(get(handles.imgfrontcheckbox,'Value') == get(handles.imgfrontcheckbox,'Max'))
    set(handles.fronteracheckbox,'Value',0);
    set(handles.gradienteunocheckbox,'Value',0);
    set(handles.gradientedoscheckbox,'Value',0);
    set(handles.maggradientecheckbox,'Value',0);
    
    handles.var_frontera = 0;
    handles.var_gradienteuno = 0;
    handles.var_gradientedos = 0;
    handles.var_maggradiente = 0;
    handles.var_imgfront = 1;
    
    
    [f,c] = find(handles.imagen_frontera);
    axes(handles.axes2),imshow(img_org,[]),colormap(gray(256)), hold on;
    plot(c,f,'ys','MarkerSize',1.5);
    

    guidata(hObject, handles);
else
    set(handles.imgfrontcheckbox,'Value',0);
    handles.var_frontera = 0;
    handles.var_gradienteuno = 0;
    handles.var_gradientedos = 0;
    handles.var_maggradiente = 0;
    handles.var_imgfront = 0;

    guidata(hObject, handles);
end

guidata(hObject, handles);


% --- Executes on button press in supmax.
function supmax_Callback(hObject, eventdata, handles)
% hObject    handle to supmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of supmax
