% Script to plot ICa components related to the stages of "Object presentation", "Grip cue" and "Start of Movement"
clear all
data_folder=pwd;

%% Loading Data
file2load='SPK_all_121001_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);  

fs=Data_all.fs;
events_exe=Data_all.events_exe;
labels_exe=Data_all.labels_exe;

w2load='W_ICA_SPK121001.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                       % Load unmixing matrix


%% Filtering and ICA
Data=Data_all.Data;
Data_filt=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering

ICA_comps=W*Data_filt;
clear bandpass_filt order fc1 fc2

%% Create figure
figure('Position',[100 100 950 660])
ax1=subplot('Position',[0.04 0.88  0.37 0.11]);
ax2=subplot('Position',[0.04 0.75  0.37 0.11]);
ax3=subplot('Position',[0.04 0.61  0.37 0.11]);
ax4=subplot('Position',[0.04 0.47  0.37 0.11]);
ax5=subplot('Position',[0.04 0.33  0.37 0.11]);
ax6=subplot('Position',[0.04 0.19  0.37 0.11]);
ax7=subplot('Position',[0.04 0.05  0.37 0.11]);

ax8=subplot('Position',[0.46 0.88 0.12 0.11]);
ax9=subplot('Position',[0.46 0.75 0.12 0.11]);
ax10=subplot('Position',[0.46 0.61 0.12 0.11]);
ax11=subplot('Position',[0.46 0.47 0.12 0.11]);
ax12=subplot('Position',[0.46 0.33 0.12 0.11]);
ax13=subplot('Position',[0.46 0.19 0.12 0.11]);
ax14=subplot('Position',[0.46 0.05 0.12 0.11]);

ax15=subplot('Position',[0.66 0.57 0.32 0.26]);
ax16=subplot('Position',[0.66 0.14 0.32 0.26]);

%% Plot  ICs
time=(1:length(Data))/fs;         %time axis
comp=[5 101 20 3 13 16 4];

axes(ax1)
plot(time,-ICA_comps(comp(1),:),'Linewidth',1.4);
findpeaks(-ICA_comps(comp(1),:),fs,'MinPeakHeight',std(ICA_comps(comp(1),1:numel(time)))*3,'MinPeakDistance',2)
yline(0)
axis off
ax1.YAxis.Visible = 'on';

axes(ax2)
plot(time,ICA_comps(comp(2),:),'Linewidth',1.4);
findpeaks(ICA_comps(comp(2),:),fs,'MinPeakHeight',std(ICA_comps(comp(2),1:numel(time)))*3,'MinPeakDistance',2)
yline(0)
axis off
ax2.YAxis.Visible = 'on';

axes(ax3)
plot(time,-ICA_comps(comp(3),:),'Linewidth',1.4);
findpeaks(-ICA_comps(comp(3),:),fs,'MinPeakHeight',std(ICA_comps(comp(3),1:numel(time)))*3,'MinPeakDistance',2)
yline(0)
axis off
ax3.YAxis.Visible = 'on';

axes(ax4)
plot(time,ICA_comps(comp(4),:),'Linewidth',1.4);
findpeaks(ICA_comps(comp(4),:),fs,'MinPeakHeight',std(ICA_comps(comp(4),1:numel(time)))*3,'MinPeakDistance',2)
yline(0)
axis off
ax4.YAxis.Visible = 'on';

axes(ax5)
plot(time,ICA_comps(comp(5),:),'Linewidth',1.4);
findpeaks(ICA_comps(comp(5),:),fs,'MinPeakHeight',std(ICA_comps(comp(5),1:numel(time)))*3,'MinPeakDistance',2)
yline(0)
axis off
ax5.YAxis.Visible = 'on';

axes(ax6)
plot(time,-ICA_comps(comp(6),:),'Linewidth',1.4);
findpeaks(-ICA_comps(comp(6),:),fs,'MinPeakHeight',std(ICA_comps(comp(6),1:numel(time)))*3,'MinPeakDistance',2)
yline(0)
axis off
ax6.YAxis.Visible = 'on';

axes(ax7)
plot(time,-ICA_comps(comp(7),:),'Linewidth',1.4);
findpeaks(-ICA_comps(comp(7),:),fs,'MinPeakHeight',std(ICA_comps(comp(7),1:numel(time)))*3,'MinPeakDistance',2)
yline(0)
axis off
ax7.YAxis.Visible = 'on';
ax7.XAxis.Visible = 'on';
xlabel('time (s)')
linkaxes([ax1 ax2 ax3 ax4 ax5 ax6 ax7], 'x'); 
xlim([11 26])

 for cont=1:3
    axes(ax1); xline(events_exe(cont,1),'Linewidth',1.4,'Color','green'); 
    text(events_exe(cont,1)+0.1,-6,'Obj\_P','Color','green');
    
    axes(ax2); xline(events_exe(cont,2),'Linewidth',1.4,'Color','red');
    text(events_exe(cont,2)+0.1,-6,'Grip\_C','Color','red')
    
    axes(ax3); xline(events_exe(cont,3),'Linewidth',1.4,'Color','blue'); 
    text(events_exe(cont,3)+0.1,-6,'Go\_C','Color','blue')
    
    axes(ax4); xline(events_exe(cont,4),'Linewidth',1.4,'Color','magenta');
    text(events_exe(cont,4)+0.1,-6,'Start\_M','Color','magenta')
    
    axes(ax5); xline(events_exe(cont,5),'Linewidth',1.4,'Color',[0.4660 0.6740 0.1880]);
    text(events_exe(cont,5)+0.1,-6,'Begin\_L','Color',[0.4660 0.6740 0.1880]);
    
    axes(ax6); xline(events_exe(cont,7),'Linewidth',1.4,'Color',[0.8500 0.3250 0.0980]);
    text(events_exe(cont,7)+0.1,-6,'End\_L','Color',[0.8500 0.3250 0.0980])
    
    axes(ax7);xline(events_exe(cont,8),'Linewidth',1.4,'Color',[0.9290, 0.6940, 0.1250]);
    text(events_exe(cont,8)+0.1,-6,'Rwd','Color',[0.9290, 0.6940, 0.1250])

 end
 
 %% Single Trials and max locs
for cont=1:91
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
    
antes=0.3;
long=1.3;

for cont=1:numel(labels_exe)
    ref=Data_ICA(cont).Object;
    ini=round((ref-antes)*fs);
    obj_ICA(:,cont)=Data_ICA(cont).Data(comp(1),ini:ini+long*fs);
	
    ref=Data_ICA(cont).Grip;
    ini=round((ref-antes)*fs);
    grip_ICA(:,cont)=Data_ICA(cont).Data(comp(2),ini:ini+long*fs);
    
    ref=Data_ICA(cont).GO;
    ini=round((ref-antes)*fs);
    go_ICA(:,cont)=Data_ICA(cont).Data(comp(3),ini:ini+long*fs);

	ref=Data_ICA(cont).Start;
    ini=round((ref-antes)*fs);
    start_ICA(:,cont)=Data_ICA(cont).Data(comp(4),ini:ini+long*fs);
        
    ref=Data_ICA(cont).Begin;
    ini=round((ref-antes)*fs);
    beg_ICA(:,cont)=Data_ICA(cont).Data(comp(5),ini:ini+long*fs);
    
    ref=Data_ICA(cont).End;
    ini=round((ref-antes)*fs);
    end_ICA(:,cont)=Data_ICA(cont).Data(comp(6),ini:ini+long*fs);

    ref=Data_ICA(cont).Reward;
    ini=round((ref-antes)*fs);
    rwd_ICA(:,cont)=Data_ICA(cont).Data(comp(7),ini:ini+long*fs);
end

%% Plot Single trials
t=(1:size(obj_ICA,1))/fs-0.3;

    axes(ax8)
    plot(t,-obj_ICA,'g--');
    xline(0,'Linewidth',1.2);
    yline(0,'Linewidth',1.2);
    xlim([-0.3 1]);
    ylim([-5 17]);
     axis off
     ax8.YAxis.Visible = 'off';
     
    axes(ax9)
    plot(t,grip_ICA,'r--');
    xline(0,'Linewidth',1.2);
    yline(0,'Linewidth',1.2);
    xlim([-0.3 1]);
    ylim([-6 16]);     
     axis off
     ax9.YAxis.Visible = 'off';
 
    axes(ax10)
    plot(t,grip_ICA,'b--');
    xline(0,'Linewidth',1.2);
    yline(0,'Linewidth',1.2);
    xlim([-0.3 1]);
    ylim([-6 16]);        
     axis off
     ax10.YAxis.Visible = 'off';
     
    axes(ax11)
    plot(t,start_ICA,'m--');
    xline(0,'Linewidth',1.2);
    yline(0,'Linewidth',1.2);
     xlim([-0.3 1]);
     axis off
     ax11.YAxis.Visible = 'off';

    axes(ax12)
    plot(t,beg_ICA,'--','Color',[0.4660 0.6740 0.1880]);
    xline(0,'Linewidth',1.2);
    yline(0,'Linewidth',1.2);
    xlim([-0.3 1]);
     axis off     
     ax12.YAxis.Visible = 'off';
     
	axes(ax13)
    plot(t,-end_ICA,'--','Color',[0.8500 0.3250 0.0980]);
    xline(0,'Linewidth',1.2);
     xlim([-0.3 1]);
     yline(0,'Linewidth',1.2);
     axis off  
     ax13.YAxis.Visible = 'off';
	
     axes(ax14)
    plot(t,-rwd_ICA,'--','Color',[0.9290, 0.6940, 0.1250]);
    xline(0,'Linewidth',1.2);
    yline(0,'Linewidth',1.2);
    xlim([-0.3 1]);
    ax14.XAxis.Visible = 'on';
	xlabel('time (s)')
    axis off  
    ax14.YAxis.Visible = 'off';

%% Violin Plots    

clear vars ancho antes b beg_ICA comp cont Data Data_filt Data_ICA duration end_ICA
clear vars events_exe events_ob fs go_ICA grip_ICA grips hd ICA_comps
clear vars incomplete_evs ini ini_v labels_description labels_exe labels_ob
clear vars locs_beg locs_end locs_grip locs_obj locs_rwd locs_start long
clear vars obj_ICA objects ref rwd_ICA start_ICA t time totals_chs W locs_go

file2load='SPK_all_121001_250_rev1.mat';
w2load='W_ICA_SPK121001.mat';
selected_ICs=[5 101 20 3 13 16 4];
[spk_s1]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,0);

file2load='SPK_all_121003_250_rev1.mat';
w2load='W_ICA_SPK121003.mat';
selected_ICs=[13 36 18 2 19 25 5];
[spk_s2]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,0);

file2load='SPK_all_121004_250_rev1.mat';
w2load='W_ICA_SPK121004.mat';
selected_ICs=[13 38 17 3 21 14 4];
[spk_s3]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,0);

file2load='SPK_all_121005_250_rev1.mat';
w2load='W_ICA_SPK121005.mat';
selected_ICs=[27 32 23 5 22 31 17];
[spk_s4]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,0);

file2load='SPK_all_121107_250_rev1.mat';
w2load='W_ICA_SPK121107.mat';
selected_ICs=[7 26 17 24 21 59 32];
[spk_s5]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,0);

file2load='RUS_all_120618_250_rev1.mat';
w2load='W_ICA_RUS120618.mat';
selected_ICs=[7 11 2 4 5 16 21];
[rus_s1]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,0);

file2load='RUS_all_120619_250_rev1.mat';
w2load='W_ICA_RUS120619.mat';
selected_ICs=[12 6 5 3 8 11 44];
[rus_s2]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,0);

file2load='RUS_all_120622_250_rev1.mat';
w2load='W_ICA_RUS120622.mat';
selected_ICs=[7 12 6 10 11 23 26];
[rus_s3]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,0);

file2load='RUS_all_120627_250_rev1.mat';
w2load='W_ICA_RUS120627.mat';
selected_ICs=[20 9 6 8 10 17 50];
[rus_s4]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,0);

file2load='RUS_all_120702_250_rev1.mat';
w2load='W_ICA_RUS120702.mat';
selected_ICs=[16 8 14 11 13 27 38]; 
[rus_s5]=extract_IC_peaks(data_folder,file2load, w2load, selected_ICs,0);

SPK=[spk_s1;spk_s2;spk_s3;spk_s4;spk_s5];
RUS=[rus_s1;rus_s2;rus_s3;rus_s4;rus_s5];

   
     axes(ax15)
    %names=({'Obj','Grip','Go','Start','BL','EL','Rwd'});
    %violinplot(SPK,names,'ViolinAlpha',0.02, 'MedianColor',[0 0 0]);
    violin_v2(SPK,'facecolor',[0 1 0;1 0 0;0 0 1;0.75 0 0.75;0.466 0.674 0.188;0.85 0.325 0.098; 0.929 0.694 0.125],'facealpha',0.5,'medc',[]);
    xticklabels({'Obj','Grip','Go','StartM','BL','EL','Rwd'})
    set(gca,'fontsize',8)
    xticks([1 2 3 4 5 6 7])
    xticklabels({'Obj\_P','Grip\_C','Go\_C','Start\_M','Begin\_L','End\_L','Rwd'})
    ylabel('time(s)','Fontsize',11)
    title ('Monkey S','Fontsize',11)
    
	axes(ax16)
    %names=({'Obj','Grip','Go','Start','BL','EL','Rwd'});
    %violinplot_v2(RUS,names,'ViolinAlpha',0.02, 'MedianColor',[0 0 0])
    violin_v2(RUS,'facecolor',[0 1 0;1 0 0;0 0 1;0.75 0 0.75;0.466 0.674 0.188;0.85 0.325 0.098; 0.929 0.694 0.125],'facealpha',0.5,'medc',[]);
    set(gca,'fontsize',8)
    xticks([1 2 3 4 5 6 7])
     xticklabels({'Obj\_P','Grip\_C','Go\_C','Start\_M','Begin\_L','End\_L','Rwd'})
    ylabel('time(s)','Fontsize',11)
    title ('Monkey R','Fontsize',11)
