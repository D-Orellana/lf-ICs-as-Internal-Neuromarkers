
function [Data_PMv,Data_M1_PMd]=SPK_subsamp(data_folder, ID_monkey, ID_session, subsamp_factor,sf)
% Code to subsampling the data, the original signal has a sampling frequency of 30000, 
% Corrects the small shift in the clock between the MI_PMd and PMV arrays
% The new samplingfrequency is equal to 30000/subsamp_factor.
% This script extract data from first executed movement until the last observed movement, do not extract data from sleep stage
% data_folder=directory where the recordings are stored
%ID monkey: 'SPK' or 'RUS', 
% ID_session:   SPK -> '121001', '121003', '121004', '121005','121107'
% ID_session:   RUS -> '120618', '120619', '120622', '120627','120702'
%subsamp_factor corresponds to the subsampling factor.  fs_new=fs_raw/subsamo_factor

num_chs =96;                                %   96chs in MI-PMd and 96chs in PMv
fs_raw=30000;                              % Original sampling frequency
fs_new=fs_raw/subsamp_factor;

% Load Data and Events
    switch ID_session
        case '121001'
            %data
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\SPK121001_MI_PMd_TT_SEQSIM001.ns5'));
            file_name_MI_PMd=strcat(aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name);
            aux_info_PMv=dir(strcat(data_folder,'\**\SPK121001_PMv_TT_SEQSIM001.ns5'));
            file_name_PMv=strcat(aux_info_PMv.folder,'\',aux_info_PMv.name);
            %eventos
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\SPK121001_MI_PMd_TT_SEQSIM001_ev_explicit.mat'));
            MI_PMd_events=load([aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name], 'ev_ex');
            aux_info_PMv=dir(strcat(data_folder,'\**\SPK121001_PMv_TT_SEQSIM001_ev_explicit.mat'));
            PMv_events=load([aux_info_PMv.folder,'\',aux_info_PMv.name], 'ev_ex');
        case '121003'
            %data
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\SPK121003_MI_PMd_TT_SEQSIM001.ns5'));
            file_name_MI_PMd=strcat(aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name);
            aux_info_PMv=dir(strcat(data_folder,'\**\SPK121003_PMv_TT_SEQSIM001.ns5'));
            file_name_PMv=strcat(aux_info_PMv.folder,'\',aux_info_PMv.name);
            %eventos
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\SPK121003_MI_PMd_TT_SEQSIM001_ev_explicit.mat'));
            MI_PMd_events=load([aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name], 'ev_ex');
            aux_info_PMv=dir(strcat(data_folder,'\**\SPK121003_PMv_TT_SEQSIM001_ev_explicit.mat'));
            PMv_events=load([aux_info_PMv.folder,'\',aux_info_PMv.name], 'ev_ex');
                        
        case '121004'
            %data
             aux_info_MI_PMd=dir(strcat(data_folder,'\**\SPK121004_MI_PMd_TT_SEQSIM001.ns5'));
            file_name_MI_PMd=strcat(aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name);
            aux_info_PMv=dir(strcat(data_folder,'\**\SPK121004_PMv_TT_SEQSIM001.ns5'));
            file_name_PMv=strcat(aux_info_PMv.folder,'\',aux_info_PMv.name);
            %eventos
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\SPK121004_MI_PMd_TT_SEQSIM001_ev_explicit.mat'));
            MI_PMd_events=load([aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name], 'ev_ex');
            aux_info_PMv=dir(strcat(data_folder,'\**\SPK121004_PMv_TT_SEQSIM001_ev_explicit.mat'));
            PMv_events=load([aux_info_PMv.folder,'\',aux_info_PMv.name], 'ev_ex');
        case '121005'
            %data
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\SPK121005_MI_PMd_TT_SEQSIM001.ns5'));
            file_name_MI_PMd=strcat(aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name);
            aux_info_PMv=dir(strcat(data_folder,'\**\SPK121005_PMv_TT_SEQSIM001.ns5'));
            file_name_PMv=strcat(aux_info_PMv.folder,'\',aux_info_PMv.name);
            %events
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\SPK121005_MI_PMd_TT_SEQSIM001_ev_explicit.mat'));
            MI_PMd_events=load([aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name], 'ev_ex');
            aux_info_PMv=dir(strcat(data_folder,'\**\SPK121005_PMv_TT_SEQSIM001_ev_explicit.mat'));
            PMv_events=load([aux_info_PMv.folder,'\',aux_info_PMv.name], 'ev_ex');
        case '121107'
            %data
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\SPK121107_MI_PMd_TT_NOGO_ob001.ns5'));
            file_name_MI_PMd=strcat(aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name);
            aux_info_PMv=dir(strcat(data_folder,'\**\SPK121107_PMv_TT_NOGO_ob001.ns5'));
            file_name_PMv=strcat(aux_info_PMv.folder,'\',aux_info_PMv.name);
            %events
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\SPK121107_MI_PMd_TT_NOGO_ob001_ev_explicit.mat'));
            MI_PMd_events=load([aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name], 'ev_ex');
            aux_info_PMv=dir(strcat(data_folder,'\**\SPK121107_PMv_TT_NOGO_ob001_ev_explicit.mat'));
            PMv_events=load([aux_info_PMv.folder,'\',aux_info_PMv.name], 'ev_ex');
    end
%% Last executed trial
% MI-PMd
events_temp=MI_PMd_events.ev_ex;
aux = find(events_temp.Completion.Completed & events_temp.Stage.Reward & events_temp.Mode.Execution);     %  The experiment include execution and observation
last_trial_MI_PMd=events_temp.timestamps(aux(1,end));

% PMv
events_temp=PMv_events.ev_ex;
aux = find(events_temp.Completion.Completed & events_temp.Stage.Reward & events_temp.Mode.Execution); 
last_trial_PMv=events_temp.timestamps(aux(1,end));

%% Extract data, Correct length difference and Subsampling
% Data is extracted from the begining to some seconds after the end of the last trial
time_after=7;
samp_fin_MI=(last_trial_MI_PMd+time_after)*fs_raw;
samp_fin_PMv=(last_trial_PMv+time_after)*fs_raw;

temp_data = openNSx_old(file_name_MI_PMd,'channels' ,1:48,['t:' num2str(1) ':' num2str(samp_fin_MI) ],'sample', 'p:double');
aux_data1= downsample(temp_data.Data',subsamp_factor);
clear vars temp_data

temp_data = openNSx_old(file_name_MI_PMd,'channels' ,49:96,['t:' num2str(1) ':' num2str(samp_fin_MI) ],'sample', 'p:double');
aux_data2= downsample(temp_data.Data',subsamp_factor);
clear vars temp_data

data_MI_PMd=[aux_data1 aux_data2];
clear vars temp_data last_trial_MI_PMd samp_fin_MI aux_data1 aux_data2
    
temp_data= openNSx_old(file_name_PMv,'channels' ,1:48,['t:' num2str(1) ':' num2str(samp_fin_PMv) ],'sample', 'p:double');
aux_data1=downsample(temp_data.Data',subsamp_factor);
clear vars temp_data

temp_data= openNSx_old(file_name_PMv,'channels' ,49:96,['t:' num2str(1) ':' num2str(samp_fin_PMv) ],'sample', 'p:double');
aux_data2=downsample(temp_data.Data',subsamp_factor);
clear vars temp_data

data_PMv=[aux_data1 aux_data2];
clear vars temp_data last_trial_PMv samp_fin_PMv ux_data1 aux_data2
clear vars file_MI_PMd file_PMv datadir

%% Create behavioral marker table and labels
% exe = executed movements
% ob  = observed movements
events_temp=MI_PMd_events.ev_ex;

ix_exe(:,1) = (find(events_temp.Completion.Completed & events_temp.Stage.ObjectPresent & events_temp.Mode.Execution))';  
ix_exe(:,2) = (find(events_temp.Completion.Completed & events_temp.Stage.GripCue & events_temp.Mode.Execution))';  
ix_exe(:,3) = find(events_temp.Completion.Completed & events_temp.Stage.GoCue & events_temp.Mode.Execution);  
ix_exe(:,4) = find(events_temp.Completion.Completed & events_temp.Stage.StartMov & events_temp.Mode.Execution);  
ix_exe(:,5) = find(events_temp.Completion.Completed & events_temp.Stage.Contact & events_temp.Mode.Execution);  
ix_exe(:,6) = find(events_temp.Completion.Completed & events_temp.Stage.BeginLift & events_temp.Mode.Execution);  
ix_exe(:,7) = find(events_temp.Completion.Completed & events_temp.Stage.EndLift & events_temp.Mode.Execution); 
ix_exe(:,8) = find(events_temp.Completion.Completed & events_temp.Stage.Reward & events_temp.Mode.Execution);       % Indices de eventos completos en ejecución e inicio del movimiento
events_exe=events_temp.timestamps(ix_exe(:,:));

% Labels for executed movements    
%11 = TC object +  Power Grip,   12 = TC Object +Presicion Grip
% 21 = KG Object +Power  Grip,   23 = KG Object +Key Grip

obID_exe =  (events_temp.Object.TC(ix_exe(:,4))*10) + (events_temp.Object.KG(ix_exe(:,4))*20);    %TC=10, KG=20
gripID_exe = events_temp.Grip.Power(ix_exe(:,4))+events_temp.Grip.Precision(ix_exe(:,4))*2+ events_temp.Grip.Key(ix_exe(:,4))*3;      % Power=1,   Presicion=2,  key=3
labels_exe = [obID_exe + gripID_exe];  

ix_ob(:,1) = find(events_temp.Completion.Completed & events_temp.Stage.ObjectPresent & events_temp.Mode.Observation);  
ix_ob(:,2) = find(events_temp.Completion.Completed & events_temp.Stage.GripCue & events_temp.Mode.Observation);  
ix_ob(:,3) = find(events_temp.Completion.Completed & events_temp.Stage.GoCue & events_temp.Mode.Observation);  
ix_ob(:,4) = find(events_temp.Completion.Completed & events_temp.Stage.StartMov & events_temp.Mode.Observation);  
ix_ob(:,5) = find(events_temp.Completion.Completed & events_temp.Stage.Contact & events_temp.Mode.Observation);  
ix_ob(:,6) = find(events_temp.Completion.Completed & events_temp.Stage.BeginLift & events_temp.Mode.Observation);  
ix_ob(:,7) = find(events_temp.Completion.Completed & events_temp.Stage.EndLift & events_temp.Mode.Observation); 
ix_ob(:,8) = find(events_temp.Completion.Completed & events_temp.Stage.Reward & events_temp.Mode.Observation);  
events_ob=events_temp.timestamps(ix_ob(:,:));

% Labels for observated movements
obID_ob =  (events_temp.Object.TC(ix_ob(:,4))*10) + (events_temp.Object.KG(ix_ob(:,4))*20);    %TC=10, KG=20
gripID_ob = events_temp.Grip.Power(ix_ob(:,4))+events_temp.Grip.Precision(ix_ob(:,4))*2+ events_temp.Grip.Key(ix_ob(:,4))*3;      % Power=1,   Presicion=2,  key=3
labels_ob = [obID_ob + gripID_ob];                      

%incomplete events from execution and observation
aux=find(~events_temp.Completion.Completed & events_temp.Stage.ObjectPresent);
incomplete_evs.object = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.GripCue);
incomplete_evs.grip = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.GoCue);
incomplete_evs.go = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.StartMov);
incomplete_evs.start = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.Contact);
incomplete_evs.contact = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.BeginLift);
incomplete_evs.begin = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.EndLift);
incomplete_evs.end = events_temp.timestamps(aux);

%% Adittional information and save data
objects=fieldnames(events_temp.Object);
grips=fieldnames(events_temp.Grip);
labels_description={'11=TC object +  Power Grip','12 = TC Object +Presicion Grip','21 = KG Object +Power  Grip','23 = KG Object +Key Grip'};

Data_M1_PMd.Data=data_MI_PMd;
Data_M1_PMd.events_exe=events_exe;
Data_M1_PMd.events_ob=events_ob;
Data_M1_PMd.incomplete_evenets=incomplete_evs;
Data_M1_PMd.objects=objects;
Data_M1_PMd.grips=grips;
Data_M1_PMd.channels=96;
Data_M1_PMd.fs=fs_new;
Data_M1_PMd.labels_description=labels_description;
Data_M1_PMd.labels_exe=labels_exe;
Data_M1_PMd.labels_ob=labels_ob;

clear vars data_MI_PMd events_exe events_ob incomplete_evs events_temp gripID_exe grips ix_exe ix_ob aux objects 
clear vars obID_exe obID_ob labels_ob labels_exe gripID_ob MI_PMd_events

%% Create behavioral marker table and labels
events_temp=PMv_events.ev_ex;
ix_exe(:,1) = (find(events_temp.Completion.Completed & events_temp.Stage.ObjectPresent & events_temp.Mode.Execution))';  
ix_exe(:,2) = (find(events_temp.Completion.Completed & events_temp.Stage.GripCue & events_temp.Mode.Execution))';  
ix_exe(:,3) = find(events_temp.Completion.Completed & events_temp.Stage.GoCue & events_temp.Mode.Execution);  
ix_exe(:,4) = find(events_temp.Completion.Completed & events_temp.Stage.StartMov & events_temp.Mode.Execution);  
ix_exe(:,5) = find(events_temp.Completion.Completed & events_temp.Stage.Contact & events_temp.Mode.Execution);  
ix_exe(:,6) = find(events_temp.Completion.Completed & events_temp.Stage.BeginLift & events_temp.Mode.Execution);  
ix_exe(:,7) = find(events_temp.Completion.Completed & events_temp.Stage.EndLift & events_temp.Mode.Execution); 
ix_exe(:,8) = find(events_temp.Completion.Completed & events_temp.Stage.Reward & events_temp.Mode.Execution);       % Indices de eventos completos en ejecución e inicio del movimiento
events_exe=events_temp.timestamps(ix_exe(:,:));

% Labels for executed movements    
%11 = TC object +  Power Grip,   12 = TC Object +Presicion Grip
% 21 = KG Object +Power  Grip,   23 = KG Object +Key Grip

obID_exe =  (events_temp.Object.TC(ix_exe(:,4))*10) + (events_temp.Object.KG(ix_exe(:,4))*20);    %TC=10, KG=20
gripID_exe = events_temp.Grip.Power(ix_exe(:,4))+events_temp.Grip.Precision(ix_exe(:,4))*2+ events_temp.Grip.Key(ix_exe(:,4))*3;      % Power=1,   Presicion=2,  key=3
labels_exe = [obID_exe + gripID_exe];  

ix_ob(:,1) = find(events_temp.Completion.Completed & events_temp.Stage.ObjectPresent & events_temp.Mode.Observation);  
ix_ob(:,2) = find(events_temp.Completion.Completed & events_temp.Stage.GripCue & events_temp.Mode.Observation);  
ix_ob(:,3) = find(events_temp.Completion.Completed & events_temp.Stage.GoCue & events_temp.Mode.Observation);  
ix_ob(:,4) = find(events_temp.Completion.Completed & events_temp.Stage.StartMov & events_temp.Mode.Observation);  
ix_ob(:,5) = find(events_temp.Completion.Completed & events_temp.Stage.Contact & events_temp.Mode.Observation);  
ix_ob(:,6) = find(events_temp.Completion.Completed & events_temp.Stage.BeginLift & events_temp.Mode.Observation);  
ix_ob(:,7) = find(events_temp.Completion.Completed & events_temp.Stage.EndLift & events_temp.Mode.Observation); 
ix_ob(:,8) = find(events_temp.Completion.Completed & events_temp.Stage.Reward & events_temp.Mode.Observation);  
events_ob=events_temp.timestamps(ix_ob(:,:));

% Labels for observated movements
obID_ob =  (events_temp.Object.TC(ix_ob(:,4))*10) + (events_temp.Object.KG(ix_ob(:,4))*20);    %TC=10, KG=20
gripID_ob = events_temp.Grip.Power(ix_ob(:,4))+events_temp.Grip.Precision(ix_ob(:,4))*2+ events_temp.Grip.Key(ix_ob(:,4))*3;      % Power=1,   Presicion=2,  key=3
labels_ob = [obID_ob + gripID_ob];                      

%incomplete events from execution and observation
aux=find(~events_temp.Completion.Completed & events_temp.Stage.ObjectPresent);
incomplete_evs.object = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.GripCue);
incomplete_evs.grip = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.GoCue);
incomplete_evs.go = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.StartMov);
incomplete_evs.start = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.Contact);
incomplete_evs.contact = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.BeginLift);
incomplete_evs.begin = events_temp.timestamps(aux);

aux=find(~events_temp.Completion.Completed & events_temp.Stage.EndLift);
incomplete_evs.end = events_temp.timestamps(aux);

%% Adittional information and save data
objects=fieldnames(events_temp.Object);
grips=fieldnames(events_temp.Grip);
labels_description={'11=TC object +  Power Grip','12 = TC Object +Presicion Grip','21 = KG Object +Power  Grip','23 = KG Object +Key Grip'};

Data_PMv.Data=data_PMv;
Data_PMv.events_exe=events_exe;
Data_PMv.events_ob=events_ob;
Data_PMv.incomplete_evenets=incomplete_evs;
Data_PMv.objects=objects;
Data_PMv.grips=grips;
Data_PMv.channels=96;
Data_PMv.fs=fs_new;
Data_PMv.labels_description=labels_description;
Data_PMv.labels_exe=labels_exe;
Data_PMv.labels_ob=labels_ob;

clear vars data_PMv events_exe events_ob incomplete_evs events_temp gripID_exe grips ix_exe ix_ob aux objects 
clear vars obID_exe obID_ob labels_ob labels_exe gripID_ob PMv_events



