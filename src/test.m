function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 27-May-2014 17:03:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;

handles.dir = './train/';
handles.dir2 = './test/';
handles.imgidx = 0;
handles.sz1 = 240;
handles.sz2 = 180;
temp = imread(strcat(handles.dir2,'img (0).jpg'));
handles.im_test = reshape(imresize(rgb2gray(temp),[handles.sz1 handles.sz2],'bicubic'),[],1);

imshow(temp,'Parent',handles.axes1);
x = zeros(handles.sz1,handles.sz2);
imshow(x,'Parent',handles.axes2);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
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
handles.imgidx = handles.imgidx + 1;
if(handles.imgidx>10)
    handles.imgidx = 0;
end
temp = imread(strcat(handles.dir2,'img (', num2str(handles.imgidx) ,').jpg'));
handles.im_test = reshape(imresize(rgb2gray(temp),[handles.sz1 handles.sz2],'bicubic'),[],1);
imshow(temp,'Parent',handles.axes1);
x = zeros(handles.sz1,handles.sz2);
imshow(x,'Parent',handles.axes2);
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    load data;
    Uj = double(handles.im_test) - mean_face;
    k = m;
    wi = vi'*Uj;
    image = zeros(size(Uj));
    for i=1:1:k
        image = image + wi(i)*vi(:,1);
    end
    
    for i=1:1:lenx
        e(i) = sum ((wi - wj(:,i)).*(wi - wj(:,i)));
    end
    min(e)
    if ( min(e) < 1.6e15 )
        idx = find(e == min(e)) - 1;
        img_det = imread(strcat(handles.dir,'img (', num2str(idx) ,').jpg'));
        imshow(img_det,'Parent',handles.axes2);
    else
        msgbox('Person not identified');
    end
