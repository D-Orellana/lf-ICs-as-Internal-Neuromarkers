% An example of use

clear all
data_folder=pwd;


%% Apply  ICA
%this code filters the signal between 0-4Hz and then applies ICA
%To use this matrix in the following functions, it is necessary to save the W obtained, and the filter
file2load='SPK_all_121001_250.mat';
N_runs=1;
maxsteps=500;
stopE=1e-9;
[W,bandpass_filt]= lfp_ICA(data_folder,file2load, N_runs,maxsteps,stopE);

 %% Sorting ICs
 % This script suggests a list of the CIs associated with each stage of the 
 % task, however a visual check is necessary to verify the results.
file2load='SPK_all_121001_250.mat';
w2load='W_ICA_SPK121001.mat';
order_ICs=ICs_sorting_SPK(data_folder,file2load, w2load);

% file2load='RUS_all_120618_250.mat';
% w2load='W_ICA_RUS120618.mat';
% order_ICs=ICs_sorting_RUS(data_folder,file2load, w2load);

%% Plot selected ICs  
file2load='SPK_all_121001_250.mat';
w2load='W_ICA_SPK121001.mat';
selected_ICs=[5 101 20 3 13 16 4];
x_ini=11;          % lower limit of the time axis
x_end=26;       % upper limit of the time axis
plot_selected_ICs(data_folder,file2load, w2load,selected_ICs,x_ini,x_end)

%% Plot ICs and Activation Maps
file2load='SPK_all_121001_250.mat';
w2load='W_ICA_SPK121001.mat';
selected_ICs=[5 101 20 3 13 16 4];
plot_maps=1;
plot_ICs_maps(data_folder,file2load,w2load,selected_ICs,plot_maps)

%% Extract Peaks Location
file2load='SPK_all_121001_250.mat';
w2load='W_ICA_SPK121001.mat';
selected_ICs=[5 101 20 3 13 16 4];
fp =1;                  % plot results
[peaks_loc]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,fp);
%selected_ICs=[5 101 20 3 13 16 4];       >>> SPK 121001
%selected_ICs=[13 36 18 2 19 25 5];       >>> SPK 121003 
%selected_ICs=[13 38 17 3 21 14 4];      >>> SPK 121004
%selected_ICs=[27 32 23 5 22 31 17];    >>> SPK 121005
%selected_ICs=[7 26 17 24 21 59 32];    >>> SPK 121107

%% Stage Detection
file2load='SPK_all_121001_250.mat';
w2load='W_ICA_SPK121001.mat';
selected_ICs=[5 101 20 3 13 16 4];
fp =1;                  % plot results
[stg_detect_res]=stage_detection(data_folder, file2load, w2load, selected_ICs,fp);

%  file2load='RUS120618_250.mat';
%  w2load='W_ICA_RUS120618_250.mat';
%  selected_ICs=[7 11 2 4 5 16 21];
%  fp =1;                  % plot results
%  [stg_detect_res]=stage_detection(file2load, w2load, selected_ICs,fp);

%% Stage preference index
file2load='SPK_all_121101_250.mat';
w2load='W_ICA_SPK121101.mat';
go_IC=20;
prefered_stg_SPK_121001= prefer_stg_ix_SPK(data_folder,file2load, w2load,go_IC);

% file2load='RUS_all_120702_250.mat';
% w2load='W_ICA_RUS120702.mat';
% go_IC=14;
% prefered_stg_RUS_120702= prefer_stg_ix_RUS(data_folder,file2load, w2load,go_IC);

%% Plot align examples
% alignment with respect to object presentation
file2load='SPK_all_121001_250.mat';
w2load='W_ICA_SPK121001.mat';
obj_IC=5;
chs2align=[46 109 147];
align_result=align_Obj_SPK(data_folder,file2load, w2load, obj_IC,chs2align);

file2load='RUS_all_120618_250.mat';
w2load='W_ICA_RUS120618.mat';
obj_IC=7;
chs2align=[29 135 178];
align_result=align_Obj_RUS(data_folder,file2load, w2load, obj_IC,chs2align);

% alignment with respect to grip presentation

file2load='RUS_all_120618_250.mat';
w2load='W_ICA_RUS120618.mat';
obj_IC=11;
chs2align=[133 165 166];
align_result=align_Grip_RUS(data_folder,file2load, w2load, obj_IC,chs2align);

file2load='SPK_all_121001_250.mat';
w2load='W_ICA_SPK121001.mat';
obj_IC=101;
chs2align=[9 109 147];
align_result=align_Grip_SPK(data_folder,file2load, w2load, obj_IC,chs2align);

% alignment with respect to go
file2load='SPK_all_121001_250.mat';
w2load='W_ICA_SPK121001.mat';
go_IC=20;
chs2align=[2 3 4 5 6];
align_result=align_GO_SPK(data_folder,file2load, w2load, go_IC,chs2align);

file2load='RUS_all_120618_250.mat';
w2load='W_ICA_RUS120618.mat';
go_IC=2;
chs2align=[1 4 10 14 20];
align_result=align_GO_RUS(data_folder,file2load, w2load, go_IC,chs2align);

% alignment with respect to Start Movement
file2load='SPK_all_121001_250.mat';
w2load='W_ICA_SPK121001.mat';
start_IC=3;
chs2align=[7 8 15];
align_result=align_Start_SPK(data_folder,file2load, w2load, start_IC,chs2align);

file2load='RUS_all_120618_250.mat';
w2load='W_ICA_RUS120618.mat';
start_IC=4;
chs2align=[20 24 29];
align_result=align_Start_RUS(data_folder,file2load, w2load, start_IC,chs2align);

%% Extract trials and Classify
file2load='SPK_all_121003_250.mat';
w2load='W_ICA_SPK121003.mat';
trials_spk121003=extract_trials(data_folder,file2load,w2load);
% object classification
N=100;          % number of runs for cross validation
obj_class_res=obj_classification(data_folder,trials_spk121003,N);

% Grip classification with TC object
obj=1;        % grip with TC object
TC_grip_class_res=grip_classification(data_folder,trials_spk121003,obj,N);

obj=2;        % grip with KG object
KG_grip_class_res=grip_classification(data_folder,trials_spk121003,obj,N);

%% Test distributed activity

 %  file2load='SPK121003_250.mat';
% N_runs=1;
%  lfp_ICA(file2load, N_runs)
%  
%  file2load='SPK121004_250.mat';
% N_runs=1;
%  lfp_ICA(file2load, N_runs)
%  
%   file2load='SPK121005_250.mat';
% N_runs=1;
%  lfp_ICA(file2load, N_runs)
%  
%    file2load='SPK121107_250.mat';
% N_runs=1;
%  lfp_ICA(file2load, N_runs)
%  
%     file2load='RUS120618_250.mat';
% N_runs=1;
%  lfp_ICA(file2load, N_runs)
%  
%     file2load='RUS120619_250.mat';
% N_runs=1;
%  lfp_ICA(file2load, N_runs)
%  
% file2load='RUS120622_250.mat';
% N_runs=1;
%  lfp_ICA(file2load, N_runs)
%  
%  file2load='RUS120627_250.mat';
% N_runs=1;
%  lfp_ICA(file2load, N_runs)
%  
%  file2load='RUS120702_250.mat';
% N_runs=1;
%  lfp_ICA(file2load, N_runs)
