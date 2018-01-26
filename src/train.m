function varargout = train(varargin)
% TRAIN MATLAB code for train.fig
%      TRAIN, by itself, creates a new TRAIN or raises the existing
%      singleton*.
%
%      H = TRAIN returns the handle to a new TRAIN or the handle to
%      the existing singleton*.
%
%      TRAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAIN.M with the given input arguments.
%
%      TRAIN('Property','Value',...) creates a new TRAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before train_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to train_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help train

% Last Modified by GUIDE v2.5 27-May-2014 16:48:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @train_OpeningFcn, ...
                   'gui_OutputFcn',  @train_OutputFcn, ...
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


% --- Executes just before train is made visible.
function train_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to train (see VARARGIN)

% Choose default command line output for train
handles.output = hObject;

handles.dir = './train/';
handles.dir2 = './test/';
delete data.mat;
handles.sz1 = 240;
handles.sz2 = 180;

x = zeros(handles.sz1,handles.sz2);
imshow(x);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes train wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = train_OutputFcn(hObject, eventdata, handles) 
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
    for i=1:1:10
        temp = imread(strcat(handles.dir,'img (', num2str(i-1) ,').jpg'));
        im(:,i) = reshape(imresize(rgb2gray(temp),[handles.sz1 handles.sz2],'bicubic'),[],1);
        imshow(temp);
        pause(0.1)
    end
    
    X = double(im);
    mean_face = mean(X,2);
    lenx = size(X,2);
    for i=1:lenx
        U(:,i) = X(:,i) - mean_face;           %face - meanface
    end
    M = U'*U;                                  
    
    [V,D] = eig(M);
    eig_val = eig(M);
    eig_vec = V;
    eig_val_sort = sort(eig_val,'descend');    % sorted eig val
    sum_val = 0;
    m=1;
    temp = 0;
    s = sum(eig_val_sort);
    while ( temp < 95 )
        sum_val = eig_val_sort(m) + sum_val;
        temp = (sum_val/s) * 100;
        m = m + 1;
    end
    eig_vec_sort = zeros(lenx,m);               
    for i=1:m
        idx = find(eig_val == eig_val_sort(i));
        eig_vec_sort(:,i) = eig_vec(:,idx);        % sorted eig vec
    end
    vi = U*eig_vec_sort;                       %eigen face / eigen vectors
    for i=1:1:lenx
        wj(:,i) = vi'*U(:,i);           %feature vectors 10X8
    end
    save('data.mat','mean_face','wj','m','vi','lenx');
    set(handles.text3,'Visible','on');
    
    
