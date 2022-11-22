
function RUS_subsamp(data_folder, ID_monkey, ID_session, subsamp_factor)
% Code to subsampling the data, the original signal has a sampling frequency of 30000, 
% Corrects the small shift in the clock between the MI_PMd and PMV arrays
% The new samplingfrequency is equal to 30000/subsamp_factor.
% This script extract data from first executed movement until the last observed movement, do not extract data from sleep stage

num_chs =96;                                %   96chs in MI-PMd and 96chs in PMv
fs_raw=30000;                              % Original sampling frequency
fs_new=fs_raw/subsamp_factor;

% Load Data and Events
    switch ID_session
        case '120618'
            %data
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\RUSRH120618_MI_PMd_TT_KG_TC_NOGO001.ns5'));
            file_name_MI_PMd=strcat(aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name);
            aux_info_PMv=dir(strcat(data_folder,'\**\RUSRH120618_PMv_TT_KG_TC_NOGO001.ns5'));
            file_name_PMv=strcat(aux_info_PMv.folder,'\',aux_info_PMv.name);
            %eventos
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\RUSRH120618_MI_PMd_TT_KG_TC_NOGO001_ev_explicit.mat'));
            MI_PMd_events=load([aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name], 'ev_ex');
            aux_info_PMv=dir(strcat(data_folder,'\**\RUSRH120618_PMv_TT_KG_TC_NOGO001_ev_explicit.mat'));
            PMv_events=load([aux_info_PMv.folder,'\',aux_info_PMv.name], 'ev_ex');

        case '120619'
            %data
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\RUSRH120619_MI_PMd_TT_KG_TC_NOGO_Ob001.ns5'));
            file_name_MI_PMd=strcat(aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name);
            aux_info_PMv=dir(strcat(data_folder,'\**\RUSRH120619_PMv_TT_KG_TC_NOGO_Ob002.ns5'));
            file_name_PMv=strcat(aux_info_PMv.folder,'\',aux_info_PMv.name);
            %eventos
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\RUSRH120619_MI_PMd_TT_KG_TC_NOGO_Ob001_ev_explicit.mat'));
            MI_PMd_events=load([aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name], 'ev_ex');
            aux_info_PMv=dir(strcat(data_folder,'\**\RUSRH120619_PMv_TT_KG_TC_NOGO_Ob002_ev_explicit.mat'));
            PMv_events=load([aux_info_PMv.folder,'\',aux_info_PMv.name], 'ev_ex');
                        
        case '120622'
            %data
             aux_info_MI_PMd=dir(strcat(data_folder,'\**\RUSRH120622_MI_PMd_TT_KG_TC_NOGO_Ob001.ns5'));
            file_name_MI_PMd=strcat(aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name);
            aux_info_PMv=dir(strcat(data_folder,'\**\RUSRH120622_PMv_TT_KG_TC_NOGO_Ob001.ns5'));
            file_name_PMv=strcat(aux_info_PMv.folder,'\',aux_info_PMv.name);
            %eventos
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\RUSRH120622_MI_PMd_TT_KG_TC_NOGO_Ob001_ev_explicit.mat'));
            MI_PMd_events=load([aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name], 'ev_ex');
            aux_info_PMv=dir(strcat(data_folder,'\**\RUSRH120622_PMv_TT_KG_TC_NOGO_Ob001_ev_explicit.mat'));
            PMv_events=load([aux_info_PMv.folder,'\',aux_info_PMv.name], 'ev_ex');
        case '120627'
            %data
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\RUSRH120627_MI_PMd_TT_KG_TC_NOGO4_Ob001.ns5'));
            file_name_MI_PMd=strcat(aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name);
            aux_info_PMv=dir(strcat(data_folder,'\**\RUSRH120627_PMv_TT_KG_TC_NOGO4_Ob001.ns5'));
            file_name_PMv=strcat(aux_info_PMv.folder,'\',aux_info_PMv.name);
            %events
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\RUSRH120627_MI_PMd_TT_KG_TC_NOGO4_Ob001_ev_explicit.mat'));
            MI_PMd_events=load([aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name], 'ev_ex');
            aux_info_PMv=dir(strcat(data_folder,'\**\RUSRH120627_PMv_TT_KG_TC_NOGO4_Ob001_ev_explicit.mat'));
            PMv_events=load([aux_info_PMv.folder,'\',aux_info_PMv.name], 'ev_ex');
        case '120702'
            %data
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\RUSRH120702_MI_PMd_TT_KG_TC_NOGO4_Ob001.ns5'));
            file_name_MI_PMd=strcat(aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name)
            aux_info_PMv=dir(strcat(data_folder,'\**\RUSRH120702_PMv_TT_KG_TC_NOGO4_Ob001.ns5'));
            file_name_PMv=strcat(aux_info_PMv.folder,'\',aux_info_PMv.name);
            %events
            aux_info_MI_PMd=dir(strcat(data_folder,'\**\RUSRH120702_MI_PMd_TT_KG_TC_NOGO4_Ob001_ev_explicit.mat'));
            MI_PMd_events=load([aux_info_MI_PMd.folder,'\',aux_info_MI_PMd.name], 'ev_ex');
            aux_info_PMv=dir(strcat(data_folder,'\**\RUSRH120702_PMv_TT_KG_TC_NOGO4_Ob001_ev_explicit.mat'));
            PMv_events=load([aux_info_PMv.folder,'\',aux_info_PMv.name], 'ev_ex');
    end

%% Find first and last trial
% MI-PMd
events_temp=MI_PMd_events.ev_ex;
aux = (find(events_temp.Completion.Completed & events_temp.Stage.ObjectPresent & events_temp.Mode.Execution));  % Object Presentation in executed movements
first_trial_MI_PMd=events_temp.timestamps(aux(1,1));

aux = find(events_temp.Completion.Completed & events_temp.Stage.Reward & events_temp.Mode.Observation);     % Reward Stage in Observed movementes
last_trial_MI_PMd=events_temp.timestamps(aux(1,end));

% PMv
events_temp=PMv_events.ev_ex;
aux = (find(events_temp.Completion.Completed & events_temp.Stage.ObjectPresent & events_temp.Mode.Execution));  % Strat stage in executed movements
first_trial_PMv=events_temp.timestamps(aux(1,1));

aux = find(events_temp.Completion.Completed & events_temp.Stage.Reward & events_temp.Mode.Observation);     % Reward Stage in Observed movementes
last_trial_PMv=events_temp.timestamps(aux(1,end));

%% Extract data, Correct length difference and Subsampling
% Data is extracted some seconds before the start of the first trial and some seconds after the end of the last trial
time_bef=3;
time_after=5;

first_samp_MI=(first_trial_MI_PMd-time_bef)*fs_raw;     % sample from which the information is to be extracted
last_samp_MI=(last_trial_MI_PMd+time_after)*fs_raw;
length_MI_PMd= last_samp_MI-first_samp_MI;

first_samp_PMv=(first_trial_PMv-time_bef)*fs_raw;
last_samp_PMv=(last_trial_PMv+time_after)*fs_raw;
length_PMv= last_samp_PMv-first_samp_PMv;

length_difference= length_MI_PMd-length_PMv;
fprintf('Length difference = %g samples\n',length_difference);                %  MI_PMd is longer, so we will remove samples every certain time interval

segment_2_skip=round(length_MI_PMd/length_difference)-1;                  % We will remove 1 sample every 'samples_2_skip' samples
samples_2_remove=(1:length_difference)*segment_2_skip;

for ch=1:96
    temp_data = openNSx_old(file_name_MI_PMd,'channels' ,ch,['t:' num2str(0) ':' num2str(last_trial_MI_PMd+time_after+2) ],'sec', 'p:double');   %,subsamp_factor 
    raw_data_MI_PMd=temp_data.Data;
    raw_data_MI_PMd=raw_data_MI_PMd(first_samp_MI:last_samp_MI);    % this line is necessary because openNSx rounds off the time values 
    
    raw_data_MI_PMd(samples_2_remove)=[];                               % Here certain samples are removed to correct the clock error
    Data_MI_PMd(ch,:)=downsample(raw_data_MI_PMd,subsamp_factor);

	temp_data= openNSx_old(file_name_PMv,'channels' ,ch,['t:' num2str(0) ':' num2str(last_trial_PMv+time_after+2) ],'sec', 'p:double');   %,subsamp_factor        
    raw_data_PMv=temp_data.Data;
    raw_data_PMv=raw_data_PMv(first_samp_PMv:last_samp_PMv);    %% this line is necessary because openNSx rounds off the time values 
    
    Data_PMv(ch,:)= downsample(raw_data_PMv,subsamp_factor);
end
Data=[Data_MI_PMd; Data_PMv];

clear vars  temp_data raw_data_MI_PMd Data_MI_PMd Data_PMv

%% Create behavioral marker table and labels
% exe = executed movements
% ob  = observed movements
events_temp=MI_PMd_events.ev_ex;

ix_exe(:,1) = find(events_temp.Completion.Completed & events_temp.Stage.ObjectPresent & events_temp.Mode.Execution);  
ix_exe(:,2) = find(events_temp.Completion.Completed & events_temp.Stage.GraspCue & events_temp.Mode.Execution);  
if ID_session=='120618'
    bad_events=[21 39 40 48 53 54 59 60 70 76 118 119 122 123 125 132 135 137 138];
    ix_exe(bad_events,:)=[];        % algo anda mal con estos eventos
end

ix_exe(:,3) = find(events_temp.Completion.Completed & events_temp.Stage.GoCue & events_temp.Mode.Execution);  
ix_exe(:,4) = find(events_temp.Completion.Completed & events_temp.Stage.StartMov & events_temp.Mode.Execution);  
ix_exe(:,5) = find(events_temp.Completion.Completed & events_temp.Stage.Contact & events_temp.Mode.Execution);  
ix_exe(:,6) = find(events_temp.Completion.Completed & events_temp.Stage.BeginLift & events_temp.Mode.Execution);  
ix_exe(:,7) = find(events_temp.Completion.Completed & events_temp.Stage.EndLift & events_temp.Mode.Execution); 
if ID_session=='120618'
    aux_end= find(events_temp.Completion.Completed & events_temp.Stage.Reward & events_temp.Mode.Execution);       % Indices de eventos completos en ejecución e inicio del movimiento
    aux_end([45 54 55 65 71 113 116 118 125 129])=[];
    ix_exe(:,8) =aux_end;
else
    ix_exe(:,8) = find(events_temp.Completion.Completed & events_temp.Stage.Reward & events_temp.Mode.Execution);
end
events_exe=events_temp.timestamps(ix_exe(:,:));

ix_NoGo(:,1)= find(events_temp.Stage.ObjectPresent & events_temp.Mode.NoGo);
ix_NoGo(:,2)= find(events_temp.Stage.GraspCue & events_temp.Mode.NoGo);
ix_NoGo(:,3)= find(events_temp.Stage.GoCue & events_temp.Mode.NoGo);
events_NoGo=events_temp.timestamps(ix_NoGo(:,:));

% Labels for executed movements    
%11 = TC object +  Power Grip,   12 = TC Object +Presicion Grip
% 21 = KG Object +Power  Grip,   23 = KG Object +Key Grip

obID_exe =  (events_temp.Object.TC(ix_exe(:,4))*10) + (events_temp.Object.KG(ix_exe(:,4))*20);    %TC=10, KG=20
gripID_exe = events_temp.Grip.Power(ix_exe(:,4))+events_temp.Grip.Precision(ix_exe(:,4))*2+ events_temp.Grip.Key(ix_exe(:,4))*3;      % Power=1,   Presicio=2,  key=3
labels_exe = [obID_exe + gripID_exe];  

if ID_session~='120618'
    ix_ob(:,1) = find(events_temp.Completion.Completed & events_temp.Stage.ObjectPresent & events_temp.Mode.Observation);  
    ix_ob(:,2) = find(events_temp.Completion.Completed & events_temp.Stage.GraspCue & events_temp.Mode.Observation);  
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
else
    events_ob=[];
    labels_ob=[];
end

%incomplete events from execution and observation
aux = (find(events_temp.Completion.Completed & events_temp.Stage.ObjectPresent & events_temp.Mode.Execution));  % Strat stage in executed movements
first_ix_MI_PMd=aux(1,1);

ix_inc_obj=find(~events_temp.Completion.Completed & events_temp.Stage.ObjectPresent);
aux=ix_inc_obj(ix_inc_obj>first_ix_MI_PMd);
incomplete_evs.object = events_temp.timestamps(aux)- (first_trial_MI_PMd-time_bef);

ix_inc_grip=find(~events_temp.Completion.Completed & events_temp.Stage.GraspCue);
aux=ix_inc_grip(ix_inc_grip>first_ix_MI_PMd);
incomplete_evs.grip = events_temp.timestamps(aux)- (first_trial_MI_PMd-time_bef);

ix_inc_go=find(~events_temp.Completion.Completed & events_temp.Stage.GoCue);
aux=ix_inc_go(ix_inc_go>first_ix_MI_PMd);
incomplete_evs.go = events_temp.timestamps(aux)- (first_trial_MI_PMd-time_bef);

ix_inc_start=find(~events_temp.Completion.Completed & events_temp.Stage.StartMov);
aux=ix_inc_start(ix_inc_start>first_ix_MI_PMd);
incomplete_evs.start = events_temp.timestamps(aux)- (first_trial_MI_PMd-time_bef);

ix_inc_contact=find(~events_temp.Completion.Completed & events_temp.Stage.Contact);
aux=ix_inc_contact(ix_inc_contact>first_ix_MI_PMd);
incomplete_evs.contact = events_temp.timestamps(aux)- (first_trial_MI_PMd-time_bef);

ix_inc_begin=find(~events_temp.Completion.Completed & events_temp.Stage.BeginLift);
aux=ix_inc_begin(ix_inc_begin>first_ix_MI_PMd);
incomplete_evs.begin = events_temp.timestamps(aux)- (first_trial_MI_PMd-time_bef);

ix_inc_end=find(~events_temp.Completion.Completed & events_temp.Stage.EndLift);
aux=ix_inc_end(ix_inc_end>first_ix_MI_PMd);
incomplete_evs.end = events_temp.timestamps(aux)- (first_trial_MI_PMd-time_bef);

%% Correct behavioral markers 
%because we started taking data only 3 s before the first event
events_ob=events_ob-(first_trial_MI_PMd-time_bef);
events_exe=events_exe-(first_trial_MI_PMd-time_bef);
events_NoGo=events_NoGo-(first_trial_MI_PMd-time_bef);

%% Adittional information and save data
objects=fieldnames(events_temp.Object);
grips=fieldnames(events_temp.Grip);
duration=length(Data)/fs_new;
total_chs=96*2;
fs=fs_new;
labels_description={'11=TC object +  Power Grip','12 = TC Object +Presicion Grip','21 = KG Object +Power  Grip','23 = KG Object +Key Grip'};
name2save=strcat(ID_monkey,ID_session,'_',num2str(fs_raw/subsamp_factor));
save(name2save,'Data','events_exe','events_ob','labels_exe','labels_ob','duration','objects','grips','fs','total_chs','labels_description','incomplete_evs','events_NoGo','-v7.3');
disp(strcat('Data saved in -> ',name2save));
