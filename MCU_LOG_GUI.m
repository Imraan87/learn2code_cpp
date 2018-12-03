function varargout = MCU_LOG_Tool(varargin)
% MCU_LOG_TOOL MATLAB code for MCU_LOG_Tool.fig
%      MCU_LOG_TOOL, by itself, creates a new MCU_LOG_TOOL or raises the existing
%      singleton*.
%
%      H = MCU_LOG_TOOL returns the handle to a new MCU_LOG_TOOL or the handle to
%      the existing singleton*.
%
%      MCU_LOG_TOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MCU_LOG_TOOL.M with the given input arguments.
%
%      MCU_LOG_TOOL('Property','Value',...) creates a new MCU_LOG_TOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MCU_LOG_Tool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MCU_LOG_Tool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MCU_LOG_Tool

% Last Modified by GUIDE v2.5 18-Mar-2015 18:56:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MCU_LOG_Tool_OpeningFcn, ...
                   'gui_OutputFcn',  @MCU_LOG_Tool_OutputFcn, ...
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


% --- Executes just before MCU_LOG_Tool is made visible.
function MCU_LOG_Tool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MCU_LOG_Tool (see VARARGIN)

% Choose default command line output for MCU_LOG_Tool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MCU_LOG_Tool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MCU_LOG_Tool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Logbutton.
function Logbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Logbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.LogObj = MCU_Log_file;
set(handles.RelDate,'String','v1.1   03/12/2018')

[filename, pathname, filterindex] = uigetfile('*.txt', ...
    'Please Select a logfile');
set(handles.StatusTXT,'String','Select Logfile')

timingStringNo = 14;
set(handles.TimingTXT,'String',repmat({''},[timingStringNo 1]))
t = nan(timingStringNo,1);

if filterindex >0
    %% Extract logfile
    set(handles.StatusTXT,'String','Extracting Data from Logfile')
    pause(0.01)
    try
        extractLogfile(handles.LogObj,pathname,filename)
        %% Extract Data from logfile
        tic
        getPLLData(handles.LogObj)
        getPFFData(handles.LogObj)
        getCKBUF(handles.LogObj)
        getPI(handles.LogObj)
        getPhaseAlign(handles.LogObj)
        getCalibration(handles.LogObj)
        get3gt(handles.LogObj)
        t(1)           = toc;
        TimingTXT    = repmat({''},[timingStringNo 1]);
        TimingTXT{1} = sprintf('Time taken to extract all Data:                                 %.2f seconds',t(1));
        set(handles.TimingTXT,'String',TimingTXT)
        %% Plot Data
        set(handles.StatusTXT,'String','Generating Plots')
        
        tic
        plotSingleLogPLL(handles.LogObj);
        t(2)           = toc;
        TimingTXT    = get(handles.TimingTXT,'String');
        TimingTXT{2} = sprintf('Generating PLL Plots:                                              %.2f seconds',t(2));
        set(handles.TimingTXT,'String',TimingTXT)
        
        
        tic
        plotSingleLogPPF(handles.LogObj);
        t(3)           = toc;
        TimingTXT    = get(handles.TimingTXT,'String');
        TimingTXT{3} = sprintf('Generating PPF Plots:                                              %.2f seconds',t(3));
        set(handles.TimingTXT,'String',TimingTXT)
        
        
        tic
        plotSingleLogCKBUF(handles.LogObj);
        t(4)           = toc;
        TimingTXT    = get(handles.TimingTXT,'String');
        TimingTXT{4} = sprintf('Generating CKBUF Plots:                                         %.2f seconds',t(4));
        set(handles.TimingTXT,'String',TimingTXT)
        
        
        tic
        plotSingleLogPI(handles.LogObj);
        t(5)           = toc;
        TimingTXT    = get(handles.TimingTXT,'String');
        TimingTXT{5} = sprintf('Generating PI Plots:                                                  %.2f seconds',t(5));
        set(handles.TimingTXT,'String',TimingTXT)
        
        
        
        tic
        plotSingleLogDAC_Phase_Alignment(handles.LogObj);
        t(6)           = toc;
        TimingTXT    = get(handles.TimingTXT,'String');
        TimingTXT{6} = sprintf('Generating DAC Phase Alignment Plots:                  %.2f seconds',t(6));
        set(handles.TimingTXT,'String',TimingTXT)
        
        
        tic
        plotSingleLog3GT(handles.LogObj);
        t(7)           = toc;
        TimingTXT    = get(handles.TimingTXT,'String');
        TimingTXT{7} = sprintf('Generating 3GT Plots:                                              %.2f seconds',t(7));
        set(handles.TimingTXT,'String',TimingTXT)
        
        
        tic
        plotSingleLogADC_CAL(handles.LogObj)
        t(8)           = toc;
        TimingTXT    = get(handles.TimingTXT,'String');
        TimingTXT{8} = sprintf('Generating ADC CAL Plots:                                     %.2f seconds',t(8));
        set(handles.TimingTXT,'String',TimingTXT)
        
        
        tic
        plotSingleLogDAC_CAL(handles.LogObj)
        t(9)           = toc;
        TimingTXT    = get(handles.TimingTXT,'String');
        TimingTXT{9} = sprintf('Generating DAC CAL Plots:                                     %.2f seconds',t(9));
        set(handles.TimingTXT,'String',TimingTXT)
        
        
        %% Save Data
        set(handles.StatusTXT,'String','Saving Plots')
        tic
        saveSingleLogPlots(handles.LogObj)
        t(11)           = toc;
        TimingTXT{11}   = sprintf('Saving Plots:                                                          %.2f seconds',t(11));
        
        set(handles.StatusTXT,'String','Saving XML')
        tic
        saveSingleLogXML(handles.LogObj)
        t(12)           = toc;
        TimingTXT{12}   = sprintf('Saving XML:                                                             %.2f seconds',t(12));
        
        set(handles.TimingTXT,'String',TimingTXT)
        set(handles.StatusTXT,'String','Complete')
        TimingTXT{14}   = sprintf('Total Time Taken                                                     %.2f seconds',sum(t(~isnan(t))));
        set(handles.TimingTXT,'String',TimingTXT)
    catch ME
        Indx = find(isnan(t),1,'first');
        TimingTXT{Indx}   = 'ERROR:';
        TimingTXT{Indx+1} = ME.identifier;
        TimingTXT{Indx+2} = ME.message;
        set(handles.TimingTXT,'String',TimingTXT)
        set(handles.StatusTXT,'String','Stopped due to Error')
        rethrow(ME)
    end
    
end
