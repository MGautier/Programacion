function varargout = ejercicio7(varargin)
% EJERCICIO7 MATLAB code for ejercicio7.fig
%      EJERCICIO7, by itself, creates a new EJERCICIO7 or raises the existing
%      singleton*.
%
%      H = EJERCICIO7 returns the handle to a new EJERCICIO7 or the handle to
%      the existing singleton*.
%
%      EJERCICIO7('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EJERCICIO7.M with the given input arguments.
%
%      EJERCICIO7('Property','Value',...) creates a new EJERCICIO7 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ejercicio7_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ejercicio7_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ejercicio7

% Last Modified by GUIDE v2.5 16-Dec-2013 03:21:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ejercicio7_OpeningFcn, ...
                   'gui_OutputFcn',  @ejercicio7_OutputFcn, ...
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


% --- Executes just before ejercicio7 is made visible.
function ejercicio7_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ejercicio7 (see VARARGIN)

% Choose default command line output for ejercicio7
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ejercicio7 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ejercicio7_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonaxes.
function buttonaxes_Callback(hObject, eventdata, handles)
% hObject    handle to buttonaxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hallamos el numero de muestras de la que dispone la señal.

n = length(handles.signal);

% Voy a calcular la fft (Fast Fourier Transform) para nuestra ventana
% especificada por el usuario. Así pues tenemos que ver cuál será el
% tamaño de dicha ventana y el de la muestra tomada en cada instante.

ventana = str2num(get(handles.textoventana,'String'));
tam = 0;

% Ahora vamos a obtener los datos relacionados con la ventana
% que se ha seleccionado en el popup junto con su valor 
% para dicha ventana

if(get(handles.popupventana,'Value') == 1)
        % Hamming
        ventana_muestra = hamming(ventana);
elseif get(handles.popupventana,'Value') == 2
        % Bartlett
        ventana_muestra = bartlett(ventana);
elseif get(handles.popupventana,'Value') == 3
        % Rectangular
        ventana_muestra = rectwin(ventana);
end


% Inicializamos la matriz auxiliar en donde almacenaremos el resultado
% de la transforma sobre nuestra señal.

y = zeros(128,n/ventana);

while (ventana*(tam+1)<= n)
% En esta variable guardaremos las muestras de nuestra señal.

x = handles.signal((ventana*tam+1):(ventana*(tam+1)));

% Se multiplica la señal por la ventana que el usuario ha especificado.

xventana_muestra = x.*ventana_muestra;

% Calculamos la fft para la muestra actual obtenida según la ventana
% que vamos a emplear.

xventana_muestrafft = fft(xventana_muestra,256);

% Almacenamos los valores positivos de la tranformada.

y(:,tam+1) = xventana_muestrafft(1:length(xventana_muestrafft)/2);

% Una vez hecho esto pasamos a la siguiente muestra para nuestra
% ventana.

tam = tam + 1;

end

% Voy a representar una vez realizada la transformada sobre el tiempo
% de nuestra señal de entrada, la señal también en frecuencia sobre
% el axes de la interfaz y a su vez en una figura que se visualice
% en una nueva ventana.

% Calculamos el tiempo. La frecuencia de muestreo la he expresado en Hz

frecuencia = str2double(get(handles.textofrecuencia,'String'));
t = 0:0.05:n/frecuencia;

% Calculamos la frecuencia para nuestro sistema

f = 0:frecuencia/2;

% Representamos graficamente y almaceno los resultados en las
% variables globales para que podamos crear una ventana nueva
% donde visualizarla mejor.

handles.t_figura = t;
handles.f_figura = f;
handles.y_figura = y;
set(handles.buttonfigura,'Visible','on');

axes(handles.axes1), imagesc(t,f,20*log10(abs(y))), axis xy, colormap(jet);
xlabel('Tiempo')
ylabel('Frecuencia')
title('\it{Espectograma}','FontSize',16)
guidata(hObject, handles);

function textoventana_Callback(hObject, eventdata, handles)
% hObject    handle to textoventana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textoventana as text
%        str2double(get(hObject,'String')) returns contents of textoventana as a double


% --- Executes during object creation, after setting all properties.
function textoventana_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textoventana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popupventana.
function popupventana_Callback(hObject, eventdata, handles)
% hObject    handle to popupventana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupventana contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupventana


% --- Executes during object creation, after setting all properties.
function popupventana_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupventana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonfigura.
function buttonfigura_Callback(hObject, eventdata, handles)
% hObject    handle to buttonfigura (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure, imagesc(handles.t_figura,handles.f_figura,20*log10(abs(handles.y_figura))), axis xy, colormap(jet);
xlabel('Tiempo')
ylabel('Frecuencia')
title('\it{Espectograma}','FontSize',16)


% --- Executes on button press in buttoncargar.
function buttoncargar_Callback(hObject, eventdata, handles)
% hObject    handle to buttoncargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname, filterindex] = uigetfile( ...
{  '*.asc','ASCII Files'; ...
   '*.*',  'Todos los archivos (*.*)'}, ...
   'Selecciona los archivos');

cla(handles.axes1,'reset');

if(filename == 0)
        set(handles.textstaticventana,'Visible','off');
        set(handles.popupventana,'Visible','off');
        set(handles.textoventana,'Visible','off');
        set(handles.buttonaxes,'Visible','off');
        set(handles.buttonfigura,'Visible','off');
        set(handles.textostaticfrecuencia,'Visible','off');
        set(handles.textofrecuencia,'Visible','off');
        set(handles.textotamventana,'Visible','off');
        
        handles.signal = 0;
        error('No se ha introducido ningún archivo\n');
        guidata(hObject, handles);
else
        set(handles.textstaticventana,'Visible','on');
        set(handles.popupventana,'Visible','on');
        set(handles.textoventana,'Visible','on');
        set(handles.buttonaxes,'Visible','on');
        set(handles.textostaticfrecuencia,'Visible','on');
        set(handles.textofrecuencia,'Visible','on');
        set(handles.textotamventana,'Visible','on');
        
        handles.signal = importdata(filename);
        guidata(hObject, handles);
end



function textofrecuencia_Callback(hObject, eventdata, handles)
% hObject    handle to textofrecuencia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textofrecuencia as text
%        str2double(get(hObject,'String')) returns contents of textofrecuencia as a double


% --- Executes during object creation, after setting all properties.
function textofrecuencia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textofrecuencia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonexit.
function buttonexit_Callback(hObject, eventdata, handles)
% hObject    handle to buttonexit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
