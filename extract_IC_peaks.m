
function [peaks_loc]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,fp)
% Plot selected ICs, does not include activation map plotting   
% file2load corresponds to the previously subsampled data.
% w2load corresponds to the unmixing matrix obtained from ICA
% selected_ICs should be the 7 ICs linked to each stage of the movement. No more than 7 ICs should be entered

aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)                                                    % Subsampled and merged data

aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                   % Load unmixing matrix
Data_filt=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering

W_selected=W(selected_ICs,:);
ICA_comps=W_selected*Data_filt;
clear bandpass_filt order fc1 fc2 Data_filt W events_ob labels_ob Data

labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;
fs=Data_all.fs;

 for cont=1:numel(labels_exe)
    ini=events_exe(cont,1)-1;
    Data_ICA(cont).Data=ICA_comps(:,round(ini*fs):round((ini+8)*fs-1));
    Data_ICA(cont).Object=events_exe(cont,1)-ini;
    Data_ICA(cont).Grip=events_exe(cont,2)-ini;
    Data_ICA(cont).GO=events_exe(cont,3)-ini;
    Data_ICA(cont).Start=events_exe(cont,4)-ini;
    Data_ICA(cont).Contact=events_exe(cont,5)-ini;
    Data_ICA(cont).Begin=events_exe(cont,6)-ini;
    Data_ICA(cont).End=events_exe(cont,7)-ini;
    Data_ICA(cont).Reward=events_exe(cont,8)-ini;
end
    
t_before=0.3;
long=1.4;
for cont=1:numel(labels_exe)
    ref=Data_ICA(cont).Object;
    ini=round((ref-t_before)*fs);
    obj_ICA(:,cont)=Data_ICA(cont).Data(1,ini:ini+long*fs);
    [~,b]=max(abs(obj_ICA(75:200,cont)));
    locs_obj(cont)=b/250;
	
    ref=Data_ICA(cont).Grip;
    ini=round((ref-t_before)*fs);
    grip_ICA(:,cont)=Data_ICA(cont).Data(2,ini:ini+long*fs);
    [~,b]=max(abs(grip_ICA(75:end,cont)));
    locs_grip(cont)=b/250;
    
    ref=Data_ICA(cont).GO;
    ini=round((ref-t_before)*fs);
    go_ICA(:,cont)=Data_ICA(cont).Data(3,ini:ini+long*fs);
    [~,b]=max(abs(go_ICA(75:end,cont)));
    locs_go(cont)=b/250;

	ref=Data_ICA(cont).Start;
    ini=round((ref-t_before)*fs);
    start_ICA(:,cont)=Data_ICA(cont).Data(4,ini:ini+long*fs);
	[~,b]=max(abs(start_ICA(50:200,cont)));
    locs_start(cont)=b/250-0.1;
        
    ref=Data_ICA(cont).Begin;
    ini=round((ref-t_before)*fs);
    beg_ICA(:,cont)=Data_ICA(cont).Data(5,ini:ini+long*fs);
	[~,b]=max(abs(beg_ICA(50:200,cont)));
    locs_beg(cont)=b/250-0.1;    
    
    ref=Data_ICA(cont).End;
    ini=round((ref-t_before)*fs);
    end_ICA(:,cont)=Data_ICA(cont).Data(6,ini:ini+long*fs);
	[~,b]=max(abs(end_ICA(50:200,cont)));
    locs_end(cont)=b/250-0.1;    

    ref=Data_ICA(cont).Reward;
    ini=round((ref-t_before)*fs);
    rwd_ICA(:,cont)=Data_ICA(cont).Data(7,ini:ini+long*fs);
	[~,b]=max(abs(rwd_ICA(50:200,cont)));
    locs_rwd(cont)=b/250-0.1;        
end
peaks_loc=[locs_obj' locs_grip' locs_go' locs_start' locs_beg' locs_end' locs_rwd'];

if fp==1
    figure('Position',[100 100 1150 760])
    ax1=subplot('Position',[0.06 0.76  0.2 0.18]);
    ax2=subplot('Position',[0.06 0.53  0.2 0.18]);
    ax3=subplot('Position',[0.06 0.3  0.2 0.18]);
    ax4=subplot('Position',[0.06 0.07  0.2 0.18]);
    ax5=subplot('Position',[0.32 0.67  0.2 0.18]);
    ax6=subplot('Position',[0.32 0.41  0.2 0.18]);
    ax7=subplot('Position',[0.32 0.15  0.2 0.18]);
    ax8=subplot('Position',[0.62 0.37 0.32 0.3]);

    t=(1:size(obj_ICA,1))/fs-0.3;

    axes(ax1);     plot(t,-obj_ICA,'g--');     xline(0,'Linewidth',1.2);     xlim([-0.3 1.2]);      axis off;
    title('Object IC');
    axes(ax2);    plot(t,grip_ICA,'r--');     xline(0,'Linewidth',1.2);      xlim([-0.3 1.2]);        axis off;
    title('Grip IC')
    axes(ax3);     plot(t,grip_ICA,'b--');     xline(0,'Linewidth',1.2);      xlim([-0.3 1.2]);       axis off;
    title('GO IC')
    axes(ax4);     plot(t,start_ICA,'m--');    xline(0,'Linewidth',1.2);     xlim([-0.3 1.2]);    ax4.XAxis.Visible = 'on';  axis off;
    title('Start Mov IC')
    axes(ax5);     plot(t,beg_ICA,'--','Color',[0.4660 0.6740 0.1880]);     xline(0,'Linewidth',1.2);      xlim([-0.3 1.2]);      axis off;
    title('Begin Lift IC')
    axes(ax6);     plot(t,-end_ICA,'--','Color',[0.8500 0.3250 0.0980]);    xline(0,'Linewidth',1.2);     xlim([-0.3 1.2]);     axis off  ;
    title('End Lift IC')
    axes(ax7);     plot(t,-rwd_ICA,'--','Color',[0.9290, 0.6940, 0.1250]);    xline(0,'Linewidth',1.2);    xlim([-0.3 1.2]);    ax7.XAxis.Visible = 'on';     axis off  
    title('Reward IC')

    axes(ax8);     boxplot(peaks_loc,'Notch','on','Labels',{'Obj','Grip','Go','Start','BL','EL','Rwd'});     ylabel('time(s)')
    title('Peak location box plot');
    suptitle('Peaks latency')
end
