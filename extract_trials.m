
function trials_2_class=extract_trials(data_folder,file2load,w2load)

aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);                                                % Subsampled and merged data
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);    
Data=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering

clear vars bandpass_filt events_ob labels_ob incomplete_evs w2load file2load

%% Organize trials in a structure
ICA_comps=W*Data;
fs=Data_all.fs;
events_exe=Data_all.events_exe;
labels_exe=Data_all.labels_exe;


for k1=1:size(labels_exe,2)
    start_trial=(events_exe(k1,1)-1);
    end_trial=(events_exe(k1,1)+9);
    trials_ICA(k1).Data=ICA_comps(:,round(start_trial*fs):round(end_trial*fs));         %  sec before and 
    trials_ICA(k1).Object=events_exe(k1,1)-start_trial;
    trials_ICA(k1).Contact=events_exe(k1,5)-start_trial;
end
clear vars start_trial end_trial    

%% Organize each stage of the movement in a matrix
time_bef=1;                                          %time before begining of each stage
time_aft=3;                                           % time after begining of each stage
length_stg=(time_aft+time_bef)*fs;
time=(1:length_stg+1)/fs-time_bef;                       % time axis 

% Object Presentation Segment
for k1=1:size(labels_exe,2)
        ref_pt=trials_ICA(k1).Object;                         % At this point the stage begins
        start_pt=round((ref_pt-time_bef)*fs)+1;
        end_pt=round((ref_pt+time_aft)*fs);
        Trials_p1(:,:,k1)=trials_ICA(k1).Data(:,start_pt:end_pt);    %chs x time x trials
end

% Movement Segment
for k1=1:size(labels_exe,2)
        ref_pt=trials_ICA(k1).Contact;                         % At this point the stage begins
        start_pt=round((ref_pt-time_bef)*fs)+1;
        end_pt=round((ref_pt+time_aft)*fs);
        Trials_p2(:,:,k1)=trials_ICA(k1).Data(:,start_pt:end_pt);    %chs x time x trials
end

trials_2_class.labels_exe=labels_exe;
trials_2_class.Trials_p1=Trials_p1;
trials_2_class.Trials_p2=Trials_p2;

