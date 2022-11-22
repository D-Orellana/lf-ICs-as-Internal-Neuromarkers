
% Code to subsampling the data, the original signal has a sampling frequency of 30000, 
%V2 include clock difference correction
% The new samplingfrequency is equal to 30000/subsamp_factor.
% It also corrects the small shift in the clock between the MI_PMd and PMV arrays
% This script exract data from first executed movement until the last observed movement, do not extract data from sleep stage
% Note: I have not used skipfactor from openNSx because it gave me strange results , instead I used "downsample" from matlab

clear all
num_chs =96;                                %   96chs in MI-PMd and 96chs in PMv
fs_orig=30000;                              % Original sampling frequency
subsamp_factor=120;                     % New sampling frequency =  30000/subsamp_factor
fs_new=fs_orig/subsamp_factor;

datadir = 'D:\Brown_Data\Spyke\';
disp('Subsampling SPK121107...')
name_2_save=strcat('SPK121107_',num2str(30000/subsamp_factor));

%% Load events MI_PMd and PMv
file_MI_PMd='SPK121107_MI_PMd_TT_NOGO_ob\SPK121107_MI_PMd_TT_NOGO_ob001.ns5';
MI_PMd_events=load([datadir 'SPK121107_MI_PMd_TT_NOGO_ob\derived\SPK121107_MI_PMd_TT_NOGO_ob001_ev_explicit.mat'],'ev_ex');

file_PMv='SPK121107_PMv_TT_NOGO_ob\SPK121107_PMv_TT_NOGO_ob001.ns5';
PMv_events= load([datadir 'SPK121107_PMv_TT_NOGO_ob\derived\SPK121107_PMv_TT_NOGO_ob001_ev_explicit.mat'],'ev_ex');

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
samp_fin_MI=(last_trial_MI_PMd+time_after)*fs_orig;
samp_fin_PMv=(last_trial_PMv+time_after)*fs_orig;

temp_data = openNSx_old([datadir file_MI_PMd],'channels' ,1:48,['t:' num2str(1) ':' num2str(samp_fin_MI) ],'sample', 'p:double');
aux_data1= downsample(temp_data.Data',subsamp_factor);
clear vars temp_data

temp_data = openNSx_old([datadir file_MI_PMd],'channels' ,49:96,['t:' num2str(1) ':' num2str(samp_fin_MI) ],'sample', 'p:double');
aux_data2= downsample(temp_data.Data',subsamp_factor);
clear vars temp_data

data_MI_PMd=[aux_data1 aux_data2];
clear vars temp_data last_trial_MI_PMd samp_fin_MI aux_data1 aux_data2
    
temp_data= openNSx_old([datadir file_PMv],'channels' ,1:48,['t:' num2str(1) ':' num2str(samp_fin_PMv) ],'sample', 'p:double');
aux_data1=downsample(temp_data.Data',subsamp_factor);
clear vars temp_data

temp_data= openNSx_old([datadir file_PMv],'channels' ,49:96,['t:' num2str(1) ':' num2str(samp_fin_PMv) ],'sample', 'p:double');
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
Data_M1_PMd.incomplete_events=incomplete_evs;
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
Data_PMv.incomplete_events=incomplete_evs;
Data_PMv.objects=objects;
Data_PMv.grips=grips;
Data_PMv.channels=96;
Data_PMv.fs=fs_new;
Data_PMv.labels_description=labels_description;
Data_PMv.labels_exe=labels_exe;
Data_PMv.labels_ob=labels_ob;

clear vars data_PMv events_exe events_ob incomplete_evs events_temp gripID_exe grips ix_exe ix_ob aux objects 
clear vars obID_exe obID_ob labels_ob labels_exe gripID_ob PMv_events

save(name_2_save,'Data_PMv','Data_M1_PMd');
%save(name_2_save,'Data','events_exe','events_ob','labels_exe','labels_ob','duration','objects','grips','fs','total_chs','labels_description','incomplete_evs','-v7.3');
