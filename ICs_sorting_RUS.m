
function order_ICs=ICs_sorting_RUS(data_folder,file2load, w2load)
    % function to sort ICs based on the location and value of amplitude peaks
    % This script suggests a list of the CIs associated with each stage of the 
 % task, however a visual check is necessary to verify the results.
    
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)                                                    % Subsampled data

aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                   % Load unmixing matrix

% FIlter Data
Data=(filtfilt(bandpass_filt,Data_all.Data'))';

% Organize trials in a structure
ICA_comps=W*Data;
events_exe=Data_all.events_exe;
labels_exe=Data_all.labels_exe;
clear bandpass_filt events_ob labels_ob full_file2load bandpass_filt            % Observed event are not used

for cont=1:size(labels_exe,2)
    start_trial=(events_exe(cont,1)-1);
    end_trial=(events_exe(cont,1)+7);
    trials_ICA(cont).Data=ICA_comps(:,round(start_trial*Data_all.fs):round(end_trial*Data_all.fs));         %  sec before and 
    trials_ICA(cont).Object=events_exe(cont,1)-start_trial;
    trials_ICA(cont).Grip=events_exe(cont,2)-start_trial;
    trials_ICA(cont).GO=events_exe(cont,3)-start_trial;
    trials_ICA(cont).Start=events_exe(cont,4)-start_trial;
    trials_ICA(cont).Contact=events_exe(cont,5)-start_trial;
    trials_ICA(cont).Begin=events_exe(cont,6)-start_trial;
    trials_ICA(cont).End=events_exe(cont,7)-start_trial;
    trials_ICA(cont).Reward=events_exe(cont,8)-start_trial;
end
clear vars start_trial end_trial    

time_object_grip=mean(events_exe(:,2)-events_exe(:,1));
time_grip_go=mean(events_exe(:,3)-events_exe(:,2));
time_go_start=mean(events_exe(:,4)-events_exe(:,3));
time_start_contact=mean(events_exe(:,5)-events_exe(:,4));
time_contact_beginLift=mean(events_exe(:,6)-events_exe(:,5));
time_beginLift_endLift=mean(events_exe(:,7)-events_exe(:,6));
time_endLift_rwd=mean(events_exe(:,8)-events_exe(:,7));
fprintf('Mean time Object    ->   Grip Cue  = %g s\n',time_object_grip);
fprintf('Mean time Grip cue  ->   Go Cue    = %g s\n',time_grip_go);
fprintf('Mean time GO cue    ->   StartMov  = %g s\n',time_go_start);
fprintf('Mean time StartMov  ->  Contact    = %g s\n',time_start_contact);
fprintf('Mean time Contact   ->  BeginLift  = %g s\n',time_contact_beginLift);
fprintf('Mean time BeginLif  ->   EndLiftt  = %g s\n',time_beginLift_endLift);
fprintf('Mean time endLif  ->   rwdLiftt  = %g s\n',time_endLift_rwd);

%% Organize each stage of the movement in a matrix
time_bef=0.06;                                       %time before begining of each stage
time_aft=0.8;                                           % time after begining of each stage
length_stg=(time_aft+time_bef)*Data_all.fs;
time=(1:length_stg+1)/Data_all.fs-time_bef;      % time axis 

for cont=1:size(labels_exe,2)
        ref_pt=trials_ICA(cont).Object;                         % At this point the stage begins
        start_pt=round((ref_pt-time_bef)*Data_all.fs);
        end_pt=round((ref_pt+time_aft)*Data_all.fs);
        Object_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);

        ref_pt=trials_ICA(cont).Grip;         
        start_pt=round((ref_pt-time_bef)*Data_all.fs);
        end_pt=round((ref_pt+time_aft)*Data_all.fs);
        Grip_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);

        ref_pt=trials_ICA(cont).GO;          
        start_pt=round((ref_pt-time_bef)*Data_all.fs);
        end_pt=round((ref_pt+time_aft)*Data_all.fs);
        GO_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);

        ref_pt=trials_ICA(cont).Start;        
        start_pt=round((ref_pt-time_bef)*Data_all.fs);
        end_pt=round((ref_pt+time_aft)*Data_all.fs);
        Start_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);

        ref_pt=trials_ICA(cont).Contact;
        start_pt=round((ref_pt-time_bef)*Data_all.fs);
        end_pt=round((ref_pt+time_aft)*Data_all.fs);
        Contact_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);

        ref_pt=trials_ICA(cont).Begin;
        start_pt=round((ref_pt-time_bef)*Data_all.fs);
        end_pt=round((ref_pt+time_aft)*Data_all.fs);
        Begin_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);

        ref_pt=trials_ICA(cont).End;
        start_pt=round((ref_pt-time_bef)*Data_all.fs);
        end_pt=round((ref_pt+time_aft)*Data_all.fs);
        End_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);
        
        ref_pt=trials_ICA(cont).Reward;
        start_pt=round((ref_pt-time_bef)*Data_all.fs);
        end_pt=round((ref_pt+time_aft)*Data_all.fs);
        Rwd_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);
end
clear vars ref_pt start_pt end_pt time_bef time_aft W W_sort

%% Find the peak amplitudes of the entire set of ICs around the start of each stage.

for ch=1:size(Data,1)
    % Find the maxima of all ICs around the object presentation
    aux=squeeze(Object_stg(ch,:,:));
    for tr=1:size(aux,2)
        [m,p]= findpeaks(abs(aux(:,tr)),'SortStr','descend', 'NPeaks',1);
        if isempty(m)
            locs_obj(ch,tr)=randi([1,size(aux,1)]);
            max_obj(ch,tr)=aux(locs_obj(ch,tr),tr);
        else
            max_obj(ch,tr)=m;
            locs_obj(ch,tr)=p;
        end
    end
    
    % Find the maxima of all ICs around the GRIP CUE
    aux=squeeze(Grip_stg(ch,:,:));
    for tr=1:size(aux,2)
        [m,p]= findpeaks(abs(aux(:,tr)),'SortStr','descend', 'NPeaks',1);
        if isempty(m)
            locs_grip(ch,tr)=randi([1,size(aux,1)]);
            max_grip(ch,tr)=aux(locs_grip(ch,tr),tr);
        else
            max_grip(ch,tr)=m;
            locs_grip(ch,tr)=p;
        end
    end 
    
    % Find the maxima of all ICs around the GO CUE    
    aux=squeeze(GO_stg(ch,1:round(time_go_start*Data_all.fs),:));
    for tr=1:size(aux,2)
        [m,p]= findpeaks(abs(aux(:,tr)),'SortStr','descend', 'NPeaks',1);
        if isempty(m)
            locs_go(ch,tr)=randi([1,size(aux,1)]);
            max_go(ch,tr)=aux(locs_go(ch,tr),tr);
        else
            max_go(ch,tr)=m;
            locs_go(ch,tr)=p;
        end
    end   
    
    % Find the maxima of all ICs around START of MOVEMENT
	aux=squeeze(Start_stg(ch,1:round(time_start_contact*Data_all.fs),:));
    for tr=1:size(aux,2)
        [m,p]= findpeaks(abs(aux(:,tr)),'SortStr','descend', 'NPeaks',1);
        if isempty(m)
            locs_start(ch,tr)=randi([1,size(aux,1)]);
            max_start(ch,tr)=aux(locs_start(ch,tr),tr);
        else
            max_start(ch,tr)=m;
            locs_start(ch,tr)=p;
        end
    end  
    
    % Find the maxima of all ICs around BEGIN LIFT
    aux=squeeze(Contact_stg(ch,1:round((time_contact_beginLift+time_beginLift_endLift)*Data_all.fs),:));
    for tr=1:size(aux,2)
        [m,p]= findpeaks(abs(aux(:,tr)),'SortStr','descend', 'NPeaks',1);
        if isempty(m)
            locs_contc(ch,tr)=randi([1,size(aux,1)]);
            max_contc(ch,tr)=aux(locs_contc(ch,tr),tr);
        else
            max_contc(ch,tr)=m;
            locs_contc(ch,tr)=p;
        end
    end 
    
% Find the maxima of all ICs around END LIFT
    aux=squeeze(End_stg(ch,1:round(time_endLift_rwd*Data_all.fs),:));
    for tr=1:size(aux,2)
        [m,p]= findpeaks(abs(aux(:,tr)),'SortStr','descend', 'NPeaks',1);
        if isempty(m)
            locs_end(ch,tr)=randi([1,size(aux,1)]);
            max_end(ch,tr)=aux(locs_end(ch,tr),tr);
        else
            max_end(ch,tr)=m;
            locs_end(ch,tr)=p;
        end
    end 

    % Find the maxima of all ICs around REWARD
    aux=squeeze(Rwd_stg(ch,:,:));
    for tr=1:size(aux,2)
        [m,p]=findpeaks(abs(aux(:,tr)),'SortStr','descend', 'NPeaks',1);
        if isempty(m)
            locs_rwd(ch,tr)=randi([1,size(aux,1)]);
            max_rwd(ch,tr)=aux(locs_rwd(ch,tr),tr);
        else
            max_rwd(ch,tr)=m;
            locs_rwd(ch,tr)=p;
        end
    end 
end

maximos(1,:)=mean(max_obj','omitnan');
maximos(2,:)=mean(max_grip','omitnan');
maximos(3,:)=mean(max_go','omitnan');
maximos(4,:)=mean(max_start','omitnan');
maximos(5,:)=mean(max_contc','omitnan');
maximos(6,:)=mean(max_end','omitnan');
maximos(7,:)=mean(max_rwd','omitnan');

varianzas(1,:)=var(locs_obj','omitnan');
varianzas(2,:)=var(locs_grip','omitnan');
varianzas(3,:)=var(locs_go','omitnan');
varianzas(4,:)=var(locs_start','omitnan');
varianzas(5,:)=var(locs_contc','omitnan');
varianzas(6,:)=var(locs_end','omitnan');
varianzas(7,:)=var(locs_rwd','omitnan');
varianzas=1./varianzas;

dist_medias(1,:)=mean(locs_obj','omitnan');
dist_medias(2,:)=mean(locs_grip','omitnan');
dist_medias(3,:)=mean(locs_go','omitnan');
dist_medias(4,:)=mean(locs_start','omitnan');
dist_medias(5,:)=mean(locs_contc','omitnan');
dist_medias(6,:)=mean(locs_end','omitnan');
dist_medias(7,:)=mean(locs_rwd','omitnan');
dist_medias=1./dist_medias;
for k=1:7
    norm_max(k,:) = (maximos(k,:) - min(maximos(k,:))) / ( max(maximos(k,:)) - min(maximos(k,:)) );
    norm_var(k,:)=(varianzas(k,:) - min(varianzas(k,:))) / ( max(varianzas(k,:)) - min(varianzas(k,:)) );
    norm_dist(k,:)=(dist_medias(k,:) - min(dist_medias(k,:))) / ( max(dist_medias(k,:)) - min(dist_medias(k,:)) );
end

metric=0.6.*norm_var+0.4.*norm_max;
%+0.1*norm_max;
[a,locs]=sort(metric,2,'descend');
order_ICs=[locs(1,1:5); locs(2,1:5); locs(3,1:5); locs(4,1:5); locs(5,1:5); locs(6,1:5); locs(7,1:5) ];

disp(strcat('ICs linked to Obj Pres: ',num2str(locs(1,1)),', ',num2str(locs(1,2)), ', ',num2str(locs(1,3)),', ', num2str(locs(1,4)),', ',num2str(locs(1,5))))
disp(strcat('ICs linked to Grip Cue: ',num2str(locs(2,1)),', ',num2str(locs(2,2)), ', ',num2str(locs(2,3)),', ', num2str(locs(2,4)),', ',num2str(locs(2,5))))
disp(strcat('ICs linked to Go Cue: ',num2str(locs(3,1)),', ',num2str(locs(3,2)), ', ',num2str(locs(3,3)),', ', num2str(locs(3,4)),', ',num2str(locs(3,5))))
disp(strcat('ICs linked to Start Mov: ',num2str(locs(4,1)),', ',num2str(locs(4,2)), ', ',num2str(locs(4,3)),', ', num2str(locs(4,4)),', ',num2str(locs(4,5))))
disp(strcat('ICs linked to Begin Lift: ',num2str(locs(5,1)),', ',num2str(locs(5,2)), ', ',num2str(locs(5,3)),', ', num2str(locs(5,4)),', ',num2str(locs(5,5))))
disp(strcat('ICs linked to End Lift: ',num2str(locs(6,1)),', ',num2str(locs(6,2)), ', ',num2str(locs(6,3)),', ', num2str(locs(6,4)),', ',num2str(locs(6,5))))
disp(strcat('ICs linked to Reward: ',num2str(locs(7,1)),', ',num2str(locs(7,2)), ', ',num2str(locs(7,3)),', ', num2str(locs(7,4)),', ',num2str(locs(7,5))))


