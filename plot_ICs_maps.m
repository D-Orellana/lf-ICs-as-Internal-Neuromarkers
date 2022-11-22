
function plot_ICs_maps(data_folder,file2load,w2load,selected_ICs,plot_maps)
    % file2load corresponds to the subsampled lfp signals.
    % w2load corresponds to the unmixing matrix w obtained by lfp_ICA.m 
    % selected_comps: there are 192 ICs available, in this variable you can select which ICs to plot
    % plot_maps: 1= plot maps, 0=no plot maps
    
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)                                                    % Subsampled and merged data

aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                   % Load unmixing matrix
Data=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering

if ~isempty(regexp(file2load, '\w*SPK\w*','match')) ==1
    load('coords_SPK.mat')
    coords=[coord_MI_PMd ; coord_PMv];
    clear vars coord_MI_PMd coord_PMv
end

if ~isempty(regexp(file2load, '\w*RUS\w*','match')) ==1
    load('coords_RUS.mat')
    coords=[coord_MI_PMd ; coord_PMv];
    clear vars coord_MI_PMd coord_PMv
end

%% Organize trials in a structure
ICA_comps=W*Data;
labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;
fs=Data_all.fs;
for cont=1:size(labels_exe,2)
    start_trial=(events_exe(cont,1)-1);
    end_trial=(events_exe(cont,1)+7);
    trials_ICA(cont).Data=ICA_comps(:,round(start_trial*fs):round(end_trial*fs));         %  sec before and 
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

%% Organize each stage of the movement in a matrix

time_bef=0.3;                                          %time before begining of each stage
time_aft=0.9;                                           % time after begining of each stage
length_stg=(time_aft+time_bef)*fs;
time=(1:length_stg+1)/fs-time_bef;                       % time axis 

for cont=1:size(labels_exe,2)
        ref_pt=trials_ICA(cont).Object;                         % At this point the stage begins
        start_pt=round((ref_pt-time_bef)*fs);
        end_pt=round((ref_pt+time_aft)*fs);
        Object_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);    %chs x time x trials

        ref_pt=trials_ICA(cont).Grip;                               % At this point the stage begins
        start_pt=round((ref_pt-time_bef)*fs);
        end_pt=round((ref_pt+time_aft)*fs);
        Grip_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);            %chs x time x trials

        ref_pt=trials_ICA(cont).GO;                                 % At this point the stage begins
        start_pt=round((ref_pt-time_bef)*fs);
        end_pt=round((ref_pt+time_aft)*fs);
        GO_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);              %chs x time x trials

        ref_pt=trials_ICA(cont).Start;                              % At this point the stage begins
        start_pt=round((ref_pt-time_bef)*fs);
        end_pt=round((ref_pt+time_aft)*fs);
        Start_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);           %chs x time x trials

        ref_pt=trials_ICA(cont).Contact;                        % At this point the stage begins
        start_pt=round((ref_pt-time_bef)*fs);
        end_pt=round((ref_pt+time_aft)*fs);
        Contact_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);     %chs x time x trials

        ref_pt=trials_ICA(cont).Begin;                              % At this point the stage begins
        start_pt=round((ref_pt-time_bef)*fs);
        end_pt=round((ref_pt+time_aft)*fs);
        Begin_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);           %chs x time x trials

        ref_pt=trials_ICA(cont).End;                                % At this point the stage begins
        start_pt=round((ref_pt-time_bef)*fs);
        end_pt=round((ref_pt+time_aft)*fs);
        End_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);                 %chs x time x trials
        
        ref_pt=trials_ICA(cont).Reward;                                % At this point the stage begins
        start_pt=round((ref_pt-time_bef)*fs);
        end_pt=round((ref_pt+time_aft)*fs);
        Rwd_stg(:,:,cont)=trials_ICA(cont).Data(:,start_pt:end_pt);                 %chs x time x trials
end
clear vars ref_pt start_pt end_pt time_bef time_aft

%% Draw each component separately in stages
%A figure will be created for each component
%The object, grip, go, start, contact and begin-lift stages will be drawn

% Separate indexes for each class
ix_c11=find(labels_exe==11);
ix_c21=find(labels_exe==21);
ix_c12=find(labels_exe==12);
ix_c23=find(labels_exe==23);    

for   cont=1:numel(selected_ICs)
       comp=selected_ICs(cont);

       %Object Stage
       % There are two objects
        figure('Name',num2str(comp),'Position',[10 600 1900 350]);
        e1=subplot('Position',[0.01 0.13 0.13 0.77]);
        Trials_ob1=[squeeze(Object_stg(comp,:,ix_c11)) squeeze(Object_stg(comp,:,ix_c12))];      %Combines classes 11 and 12 that correspond to the same object
        Trials_ob2=[squeeze(Object_stg(comp,:,ix_c21)) squeeze(Object_stg(comp,:,ix_c23))];      %Combines classes 21 and 23 that correspond to the same object

        g1=plot(time,Trials_ob1,'b');           hold on;
        g2=plot(time,Trials_ob2,'r');
        xline(0,'Linewidth',1.2);
        e1.YAxis.Visible = 'off';      
        legend([g1(1), g2(1)], 'TC Object', 'KG Object','Location','southwest')
        xlabel('time (s)');
        title('Object Presentation');
        
       %Grip Stage
       % There are three grips
        e2=subplot('Position',[0.15 0.13 0.13 0.77]);
        Trials_pow=[squeeze(Grip_stg(comp,:,ix_c11)) squeeze(Grip_stg(comp,:,ix_c21))];         % Classes 11 and 21 have power grip
        Trials_prec=[squeeze(Grip_stg(comp,:,ix_c12))];                                                                     % Precision grip
        Trials_key=[squeeze(Grip_stg(comp,:,ix_c23))];                                                                      %  Key grip
        g1=plot(time,Trials_pow,'b');         hold on;
        g2=plot(time,Trials_prec,'r');
        g3=plot(time,Trials_key,'k');
        xline(0,'Linewidth',1.2);
        legend([g1(1), g2(1),g3(1)], 'Power', 'Precision','Key','Location','southwest')
        title('Grip Cue');
        xlabel('time (s)');
        e2.YAxis.Visible = 'off';      
        
        %GO Stage
        e3=subplot('Position',[0.29 0.13 0.13 0.77]);        
        Trials_c1=squeeze(GO_stg(comp,:,ix_c11));
        Trials_c2=squeeze(GO_stg(comp,:,ix_c21));
        Trials_c3=squeeze(GO_stg(comp,:,ix_c12));
        Trials_c4=squeeze(GO_stg(comp,:,ix_c23));
        
        g1=plot(time,Trials_c1,'b'); 
        hold on;
        g2=plot(time,Trials_c2,'r');
        g3=plot(time,Trials_c3,'g');
        g4=plot(time,Trials_c4,'k');
        xline(0,'Linewidth',1.2);
        legend([g1(1), g2(1),g3(1),g4(1)], 'TC+Pwr', 'TC+presc','KG+Pwr','KG+key','Location','southwest')
        title('GO Cue');
        xlabel('time (s)');
        e3.YAxis.Visible = 'off';              

        %Start Movement Stage
        e4=subplot('Position',[0.43 0.13 0.13 0.77]);
        Trials_c1=squeeze(Start_stg(comp,:,ix_c11));
        Trials_c2=squeeze(Start_stg(comp,:,ix_c21));
        Trials_c3=squeeze(Start_stg(comp,:,ix_c12));
        Trials_c4=squeeze(Start_stg(comp,:,ix_c23));
        
        g1=plot(time,Trials_c1,'b'); 
        hold on;
        g2=plot(time,Trials_c2,'r');
        g3=plot(time,Trials_c3,'g');
        g4=plot(time,Trials_c4,'k');
        xline(0,'Linewidth',1.2);
       %legend([g1(1), g2(1),g3(1),g4(1)], 'TC+Pwr', 'TC+presc','KG+Pwr','KG+key','Location','southwest')
        title('Start Movement ');
        xlabel('time (s)');
         e4.YAxis.Visible = 'off';     
         
        %Contact/Begin  with the object Stage
         e5=subplot('Position',[0.57 0.13 0.13 0.77]);
        Trials_c1=squeeze(Begin_stg(comp,:,ix_c11));
        Trials_c2=squeeze(Begin_stg(comp,:,ix_c21));
        Trials_c3=squeeze(Begin_stg(comp,:,ix_c12));
        Trials_c4=squeeze(Begin_stg(comp,:,ix_c23));

        g1=plot(time,Trials_c1,'b'); 
        hold on;
        g2=plot(time,Trials_c2,'r');
        g3=plot(time,Trials_c3,'g');
        g4=plot(time,Trials_c4,'k');
        xline(0,'Linewidth',1.2);
        %legend([g1(1), g2(1),g3(1),g4(1)], 'TC+Pwr', 'TC+presc','KG+Pwr','KG+key','Location','southwest')
        xlabel('time (s)');
        title('Begin Lift ');
        xlabel('time (s)');
        e5.YAxis.Visible = 'off'; 
        
        % End Lift
        e6=subplot('Position',[0.71 0.13 0.13 0.77]);
        Trials_c1=squeeze(End_stg(comp,:,ix_c11));
        Trials_c2=squeeze(End_stg(comp,:,ix_c21));
        Trials_c3=squeeze(End_stg(comp,:,ix_c12));
        Trials_c4=squeeze(End_stg(comp,:,ix_c23));

        g1=plot(time,Trials_c1,'b'); 
        hold on;
        g2=plot(time,Trials_c2,'r');
        g3=plot(time,Trials_c3,'g');
        g4=plot(time,Trials_c4,'k');
        xline(0,'Linewidth',1.2);
        %legend([g1(1), g2(1),g3(1),g4(1)], 'TC+Pwr', 'TC+presc','KG+Pwr','KG+key','Location','southwest')
        xlabel('time (s)');
        title('End Lift ');
        xlabel('time (s)');
        e6.YAxis.Visible = 'off'; 

  % EReward lift
        e7=subplot('Position',[0.85 0.13 0.13 0.77]);
         Trials_c1=squeeze(Rwd_stg(comp,:,ix_c11));
        Trials_c2=squeeze(Rwd_stg(comp,:,ix_c21));
        Trials_c3=squeeze(Rwd_stg(comp,:,ix_c12));
        Trials_c4=squeeze(Rwd_stg(comp,:,ix_c23));

        g1=plot(time,Trials_c1,'b'); 
        hold on;
        g2=plot(time,Trials_c2,'r');
        g3=plot(time,Trials_c3,'g');
        g4=plot(time,Trials_c4,'k');
        xline(0,'Linewidth',1.2);
        %legend([g1(1), g2(1),g3(1),g4(1)], 'TC+Pwr', 'TC+presc','KG+Pwr','KG+key','Location','southwest')
        xlabel('time (s)');
        title('Reward ');
        xlabel('time (s)');
        e7.YAxis.Visible = 'off';         
        
        linkaxes([e1 e2 e3 e4 e5 e6 e7], 'xy');
        suptitle(strcat('Component =',num2str(comp)))

        % Heatmap
        if plot_maps==1
            figure;
            aux_comp=abs(W(comp,:));
            aux_comp_norm=(aux_comp-min(aux_comp))/(max(aux_comp)-min(aux_comp));
            scatter(coords(:,1),coords(:,2),60,aux_comp_norm,'filled')
            set(gca,'View', [0,-90]);
            title(strcat(' Component = ',num2str(comp)));
            colorbar

            if ~isempty(regexp(file2load, '\w*SPK\w*','match')) ==1
                annotation('textbox',[0.210714285714286 0.471428571428572 0.0821428571428572 0.0585238095238096],'String','PMv','FontWeight','bold','FitBoxToText','off');
                annotation('textbox',[0.65892857142857 0.292857142857146 0.0535714285714299 0.0585238095238096],'String','MI','FontWeight','bold','FitBoxToText','off');
                annotation('textbox',[0.339285714285711 0.797619047619054 0.0732142857142883 0.0585238095238096],'String','PMd','FontWeight','bold','FitBoxToText','off');
            end

            if ~isempty(regexp(file2load, '\w*RUS\w*','match')) ==1
                annotation('textbox',[0.65 0.203 0.07 0.047],'String','PMv','FontWeight','bold','FitBoxToText','off');
                annotation('textbox',[0.13 0.298 0.06 0.047],'String','MI','FontWeight','bold','FitBoxToText','off');
                annotation('textbox',[0.3 0.815 0.07 0.047],'String','PMd','FontWeight','bold','FitBoxToText','off');
            end
            axis off         
        end
end    

