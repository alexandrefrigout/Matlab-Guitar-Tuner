function varargout = accordeur_v(varargin)
%
% ACCORDEUR_V M-file for accordeur_v.fig
%      ACCORDEUR_V, by itself, creates a new ACCORDEUR_V or raises the existing
%      singleton*.
%
%      H = ACCORDEUR_V returns the handle to a new ACCORDEUR_V or the handle to
%      the existing singleton*.
%
%      ACCORDEUR_V('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACCORDEUR_V.M with the given input arguments.
%
%      ACCORDEUR_V('Property','Value',...) creates a new ACCORDEUR_V or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before accordeur_v_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to accordeur_v_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help accordeur_v

% Last Modified by GUIDE v2.5 18-Nov-2008 11:36:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @accordeur_v_OpeningFcn, ...
                   'gui_OutputFcn',  @accordeur_v_OutputFcn, ...
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


% --- Executes just before accordeur_v is made visible.
function accordeur_v_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to accordeur_v (see VARARGIN)

% Choose default command line output for accordeur_v
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes accordeur_v wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = accordeur_v_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%          set(handles.axes1,'YLim',[-1 1],...  % apply scaling and 
%                  'XLim',[0 0.3], 'Xscale', 10,... %turn on grid              
%                  'XGrid', 'on', 'YGrid', 'on');
%   
% --- Executes on button press in radiobutton1.



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%initialize the flag variable

i = 1;
 set(handles.pushbutton1,'UserData',1); 
 freq = str2num(get(handles.text6, 'String'));
 %  if (get(handles.radiobutton1,'Value') == get(handles.radiobutton1,'Min'))
% 
%  
%  end
%  
%while the flag variable is one, the loop continues
while (get(handles.pushbutton1,'UserData') ==1)

        gain = get(handles.slider3,'Value');
        set(handles.text16, 'String', num2str(gain));
    
        AI = analoginput('winsound');
        addchannel(AI, 1);
        Fs = 44100;              % Sample Rate is 8000 Hz
        set (AI, 'SampleRate', Fs)
        duration = 1;           % 2 second acquisition
        set(AI, 'SamplesPerTrigger', duration*Fs);
        total = Fs*duration;
        

        start(AI);
        data = getdata(AI);
        delete(AI);
        data = data*gain;        %Gain
        
%         for t = 1 : length(data)
%         time_x(t) = t / Fs;
%         end
        tot = length(data); 
  
            set(handles.axes1,'YLim',[-1 1],...  % apply scaling and
                 'XLim',[0 tot],... %turn on grid              
                 'XGrid', 'on', 'YGrid', 'on');

         plot(handles.axes1,data);
        
        set(handles.text2, 'String', num2str(i));

        
        %   tot = length(data); 
        
% 
%         NFFT = 2^nextpow2(length(data)); 
%         f = Fs/2*linspace(0,1,NFFT/2);
        
        f = (0 : tot)*(Fs/tot); % x4 pour obtenir la bonne frequence

        xfft = abs(fft(data));
        mag = 20*log10(xfft);
        mag = mag(1:end/2);

        %[ymax,maxindex]=max(mag);
        %set(handles.axes2, 'XLim', [100 1000]);
        [mx,freq0]=max(xfft);
        set(handles.edit1, 'String', num2str(f(freq0)));
     %f(freq0)
        if i == 1
            user_entry = str2double(get(handles.edit2,'string'));
            if isnan(user_entry)
            gamme = 20;
            else
            gamme = str2num(get(handles.edit2, 'String'))/2;
            end

            for t = 1:tot/10
            if f(t) < freq+-5
              center = t;
            end
            % f(t);
            end
            if center < gamme
            center = gamme+1;
            else
            %  center;
            end
       
            plot(handles.axes2,f(center-gamme:center+gamme),xfft(center-gamme:center+gamme));
            %plot(handles.axes2,f(1:tot/10),xfft(1:tot/10));
     
            if freq > f(freq0)+3
              set(handles.text3,'Backgroundcolor', 'red');
              set(handles.text5, 'Backgroundcolor', [1 1 1])
              set(handles.text4, 'Backgroundcolor', [1 1 1])
      
            else if freq < f(freq0)-3
              set(handles.text5, 'Backgroundcolor', 'red');
              set(handles.text3,'Backgroundcolor', [1 1 1]);
              set(handles.text4, 'Backgroundcolor', [1 1 1])
                
            else
              set(handles.text4, 'Backgroundcolor', 'red');
              set(handles.text3,'Backgroundcolor', [1 1 1]);
              set(handles.text5, 'Backgroundcolor', [1 1 1])
      
            end
            end
        else 
            user_entry = str2double(get(handles.edit2,'string'));
            if isnan(user_entry)
            gamme = 20;
            else
            gamme = str2num(get(handles.edit2, 'String'))/2;
            end

            if center < gamme
            center = gamme+1;
            else
            center;
            end
       
     
             plot(handles.axes2,f(center-gamme:center+gamme),xfft(center-gamme:center+gamme));
            % plot(handles.axes2,f(1:tot/10),xfft(1:tot/10));
     
            if freq > f(freq0)+3
              set(handles.text3,'Backgroundcolor', 'red');
              set(handles.text5, 'Backgroundcolor', [1 1 1])
              set(handles.text4, 'Backgroundcolor', [1 1 1])
      
            else if freq < f(freq0)-3
              set(handles.text5, 'Backgroundcolor', 'red');
              set(handles.text3,'Backgroundcolor', [1 1 1]);
              set(handles.text4, 'Backgroundcolor', [1 1 1])
                
            else
              set(handles.text4, 'Backgroundcolor', 'red');
              set(handles.text3,'Backgroundcolor', [1 1 1]);
              set(handles.text5, 'Backgroundcolor', [1 1 1])
      
            end
        end
        end
            
     
      
      
      
        i = i + 1;
 end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text3, 'Backgroundcolor', [1 1 1])
set(handles.text4, 'Backgroundcolor', [1 1 1])
set(handles.text5, 'Backgroundcolor', [1 1 1])
clear i;
clear data;
      

set(handles.pushbutton1,'UserData',0);
clear i;
clear data;
      
guidata(hObject, handles);




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function radiobutton1_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.text6, 'String',num2str(330));
    set(handles.radiobutton3, 'Value', 0);
    set(handles.radiobutton7, 'Value', 0);
	set(handles.radiobutton4, 'Value', 0);
	set(handles.radiobutton5, 'Value', 0);
	set(handles.radiobutton6, 'Value', 0);
    set(handles.radiobutton8, 'Value', 0);
	set(handles.radiobutton9, 'Value', 0);
	set(handles.radiobutton10, 'Value', 0);
	set(handles.radiobutton11, 'Value', 0);

	% Radio button is selected, take appropriate action
else
    tmp = str2num(get(handles.text6, 'String'));
    
    set(handles.text6, 'String',num2str(tmp));
    

	% Radio button is not selected, take appropriate action
end


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.text6, 'String',num2str(440));
    set(handles.radiobutton1, 'Value', 0);
	set(handles.radiobutton7, 'Value', 0);
	set(handles.radiobutton4, 'Value', 0);
	set(handles.radiobutton5, 'Value', 0);
	set(handles.radiobutton6, 'Value', 0);
    set(handles.radiobutton8, 'Value', 0);
	set(handles.radiobutton9, 'Value', 0);
	set(handles.radiobutton10, 'Value', 0);
	set(handles.radiobutton11, 'Value', 0);
	
	% Radio button is selected, take appropriate action
else
    set(handles.text6, 'String',handles.text6);

	% Radio button is not selected, take appropriate action
end


% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3




% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over radiobutton1.
function radiobutton1_ButtonDownFcn(hObject, eventdata, handles)
 set(handles.text6, 'String','rien');

% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over radiobutton3.
function radiobutton3_ButtonDownFcn(hObject, eventdata, handles)
 set(handles.text6, 'String','rien');

% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on key press with focus on radiobutton3 and no controls selected.
function radiobutton3_KeyPressFcn(hObject, eventdata, handles)
set(handles.text6, 'String','rien');

% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.text6, 'String',num2str(597));
    set(handles.radiobutton1, 'Value', 0);
	set(handles.radiobutton3, 'Value', 0);
	set(handles.radiobutton5, 'Value', 0);
	set(handles.radiobutton6, 'Value', 0);
	set(handles.radiobutton7, 'Value', 0);
    set(handles.radiobutton8, 'Value', 0);
	set(handles.radiobutton9, 'Value', 0);
	set(handles.radiobutton10, 'Value', 0);
	set(handles.radiobutton11, 'Value', 0);
	% Radio button is selected, take appropriate action
else
    tmp = str2num(get(handles.text6, 'String'));
    
    set(handles.text6, 'String',num2str(tmp));
    

	% Radio button is not selected, take appropriate action
end

% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.text6, 'String',num2str(784));
    set(handles.radiobutton1, 'Value', 0);
	set(handles.radiobutton3, 'Value', 0);
	set(handles.radiobutton4, 'Value', 0);
	set(handles.radiobutton6, 'Value', 0);
	set(handles.radiobutton7, 'Value', 0);
    set(handles.radiobutton8, 'Value', 0);
	set(handles.radiobutton9, 'Value', 0);
	set(handles.radiobutton10, 'Value', 0);
	set(handles.radiobutton11, 'Value', 0);
	% Radio button is selected, take appropriate action
else
    tmp = str2num(get(handles.text6, 'String'));
    
    set(handles.text6, 'String',num2str(tmp));
    

	% Radio button is not selected, take appropriate action
end
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.text6, 'String',num2str(988));
    set(handles.radiobutton1, 'Value', 0);
	set(handles.radiobutton3, 'Value', 0);
	set(handles.radiobutton4, 'Value', 0);
	set(handles.radiobutton5, 'Value', 0);
	set(handles.radiobutton7, 'Value', 0);
    set(handles.radiobutton8, 'Value', 0);
	set(handles.radiobutton9, 'Value', 0);
	set(handles.radiobutton10, 'Value', 0);
	set(handles.radiobutton11, 'Value', 0);
	% Radio button is selected, take appropriate action
else
    tmp = str2num(get(handles.text6, 'String'));
    
    set(handles.text6, 'String',num2str(tmp));
    

	% Radio button is not selected, take appropriate action
end
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.text6, 'String',num2str(1318));
    set(handles.radiobutton1, 'Value', 0);
	set(handles.radiobutton3, 'Value', 0);
	set(handles.radiobutton4, 'Value', 0);
	set(handles.radiobutton5, 'Value', 0);
	set(handles.radiobutton6, 'Value', 0);
    set(handles.radiobutton8, 'Value', 0);
	set(handles.radiobutton9, 'Value', 0);
	set(handles.radiobutton10, 'Value', 0);
	set(handles.radiobutton11, 'Value', 0);
	% Radio button is selected, take appropriate action
else
    tmp = str2num(get(handles.text6, 'String'));
    
    set(handles.text6, 'String',num2str(tmp));
    

	% Radio button is not selected, take appropriate action
end
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7






% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.text6, 'String',num2str(41.2));
    set(handles.radiobutton1, 'Value', 0);
	set(handles.radiobutton3, 'Value', 0);
	set(handles.radiobutton4, 'Value', 0);
	set(handles.radiobutton5, 'Value', 0);
	set(handles.radiobutton6, 'Value', 0);
    set(handles.radiobutton7, 'Value', 0);
	set(handles.radiobutton9, 'Value', 0);
	set(handles.radiobutton10, 'Value', 0);
	set(handles.radiobutton11, 'Value', 0);
	% Radio button is selected, take appropriate action
else
    tmp = str2num(get(handles.text6, 'String'));
    
    set(handles.text6, 'String',num2str(tmp));
    

	% Radio button is not selected, take appropriate action
end
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton8


% --------------------------------------------------------------------
 


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.text6, 'String',num2str(55));
    set(handles.radiobutton1, 'Value', 0);
	set(handles.radiobutton3, 'Value', 0);
	set(handles.radiobutton4, 'Value', 0);
	set(handles.radiobutton5, 'Value', 0);
	set(handles.radiobutton6, 'Value', 0);
    set(handles.radiobutton7, 'Value', 0);
	set(handles.radiobutton8, 'Value', 0);
	set(handles.radiobutton10, 'Value', 0);
	set(handles.radiobutton11, 'Value', 0);
	% Radio button is selected, take appropriate action
else
    tmp = str2num(get(handles.text6, 'String'));
    
    set(handles.text6, 'String',num2str(tmp));
    

	% Radio button is not selected, take appropriate action
end
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9




% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.text6, 'String',num2str(73.4));
    set(handles.radiobutton1, 'Value', 0);
	set(handles.radiobutton3, 'Value', 0);
	set(handles.radiobutton4, 'Value', 0);
	set(handles.radiobutton5, 'Value', 0);
	set(handles.radiobutton6, 'Value', 0);
    set(handles.radiobutton7, 'Value', 0);
	set(handles.radiobutton9, 'Value', 0);
	set(handles.radiobutton8, 'Value', 0);
	set(handles.radiobutton11, 'Value', 0);
	% Radio button is selected, take appropriate action
else
    tmp = str2num(get(handles.text6, 'String'));
    
    set(handles.text6, 'String',num2str(tmp));
    

	% Radio button is not selected, take appropriate action
end
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10




% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.text6, 'String',num2str(98));
    set(handles.radiobutton1, 'Value', 0);
	set(handles.radiobutton3, 'Value', 0);
	set(handles.radiobutton4, 'Value', 0);
	set(handles.radiobutton5, 'Value', 0);
	set(handles.radiobutton6, 'Value', 0);
    set(handles.radiobutton7, 'Value', 0);
	set(handles.radiobutton9, 'Value', 0);
	set(handles.radiobutton10, 'Value', 0);
	set(handles.radiobutton8, 'Value', 0);
	% Radio button is selected, take appropriate action
else
    tmp = str2num(get(handles.text6, 'String'));
    
    set(handles.text6, 'String',num2str(tmp));
    

	% Radio button is not selected, take appropriate action
end






function edit2_Callback(hObject, eventdata, handles)

    
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
user_entry = str2double(get(hObject,'String'));
if isnan(user_entry)
	set(hObject,'Min',0) 
    set(hObject,'Max',10)
else
     mini = str2num(get(handles.edit3, 'String'));
    maxi = str2num(get(handles.edit4, 'String'));

    set(hObject,'Min',mini) 
    set(hObject,'Max',maxi)
    
end

% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
set(hObject,'Value',1)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function text16_CreateFcn(hObject, eventdata, handles)

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


