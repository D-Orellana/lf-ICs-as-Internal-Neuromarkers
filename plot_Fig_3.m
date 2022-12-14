clear all
data_folder=pwd;

figure ('Position',[500 120 1300 800])
e1=subplot('Position',[0.1 0.57 0.8 0.36]);
e2=subplot('Position',[0.08 0.1 0.39 0.35]);
e3=subplot('Position',[0.53 0.1 0.39 0.35]);
    
file2load='SPK_all_121001_250_rev1.mat';
w2load='W_ICA_SPK121001.mat';
selected_ICs=[5 101 20 3 13 16 4];
fp =0;                  % plot results
[stg_detect_res]=stage_detection(data_folder, file2load, w2load, selected_ICs,fp);
presicion(1,:)=stg_detect_res.Prec_opt;
recall(1,:)=stg_detect_res.Rec_opt;
th(1,:)=stg_detect_res.Th_opt;

file2load='SPK_all_121003_250_rev1.mat';
w2load='W_ICA_SPK121003.mat';
selected_ICs=[13 36 18 2 19 25 5];
[stg_detect_res]=stage_detection(data_folder, file2load, w2load, selected_ICs,fp);
presicion(2,:)=stg_detect_res.Prec_opt;
recall(2,:)=stg_detect_res.Rec_opt;
th(2,:)=stg_detect_res.Th_opt;

file2load='SPK_all_121004_250_rev1.mat';
w2load='W_ICA_SPK121004.mat';
selected_ICs=[13 38 17 3 9 14 4];
[stg_detect_res]=stage_detection(data_folder, file2load, w2load, selected_ICs,fp);
presicion(3,:)=stg_detect_res.Prec_opt;
recall(3,:)=stg_detect_res.Rec_opt;
th(3,:)=stg_detect_res.Th_opt;

file2load='SPK_all_121005_250_rev1.mat';
w2load='W_ICA_SPK121005.mat';
selected_ICs=[27 32 23 5 22 31 17];
[stg_detect_res]=stage_detection(data_folder, file2load, w2load, selected_ICs,fp);
presicion(4,:)=stg_detect_res.Prec_opt;
recall(4,:)=stg_detect_res.Rec_opt;
th(4,:)=stg_detect_res.Th_opt;

file2load='SPK_all_121107_250_rev1.mat';
w2load='W_ICA_SPK121107.mat';
selected_ICs=[7 26 17 24 21 59 32];
[stg_detect_res]=stage_detection(data_folder, file2load, w2load, selected_ICs,fp);
presicion(5,:)=stg_detect_res.Prec_opt;
recall(5,:)=stg_detect_res.Rec_opt;
th(5,:)=stg_detect_res.Th_opt;

p_mean=mean(presicion);
p_std=std(presicion);
r_mean=mean(recall);
r_std=std(recall);

axes(e2)
ep=[0.9 1.9 2.9 3.9 4.9 5.9 6.9];

errhigh = 100*(p_std);
errhigh(4)=errhigh(4)-0.0155;
errhigh(5)= errhigh(5)-0.2125;
errhigh(7)= errhigh(7)-3.7472;
errlow  = 100*(p_std);
bar(ep,p_mean*100, 0.3)

hold on
er = errorbar(ep,100*p_mean',errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 


er=[1.2 2.2 3.2 4.2 5.2 6.2 7.2];
bar(er,r_mean*100, 0.3)
errhigh = 100*(r_std);
errhigh(5)=errhigh(5)-0.5788;
errhigh(7)=errhigh(7)-1.5528;
errlow  = 100*(r_std);
er = errorbar(er,100*r_mean',errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
%xlabel('Stage')
ylabel('Value (%)')
title('Presicion and Recall,  Monkey "S"')
box off
xticks([1 2 3 4 5 6 7])
xticklabels({'Obj\_P','Grip\_C','Go\_C','Start\_M','Beg\_L','End\_L','Rwd'})

%% Plot Waveform
file2load='SPK_all_121001_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)                                                    % Subsampled and merged data

w2load='W_ICA_SPK121001.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);  


fs=Data_all.fs;
events_exe=Data_all.events_exe;
events_NM=Data_all.events_NM;
incomplete_evs=Data_all.incomplete_events;
labels_exe=Data_all.labels_exe;

Data=(Data_all.Data)';
Data=(filtfilt(bandpass_filt,Data))';
ICs=W*Data;

IC=-ICs(5,:);
t=(1:numel(IC))*(1/fs);
[a,b]=findpeaks(IC,'MinPeakHeight',3.41*std(IC));
axes(e1)
plot(t,IC,'LineWidth',1.2);
hold on
plot(b/fs,a+0.5,'Marker','v','LineStyle', 'none','MarkerFaceColor','g','MarkerEdgeColor','k','MarkerSize',10);
yline(3.41*std(IC),'LineWidth',1.5,'Color','r');
for k=1:numel(labels_exe)
    xline(events_exe(k,1),'LineWidth',1.5)
end
yline(3.41*std(IC),'LineWidth',1.5,'Color','r');
xlim([664 710])
xlabel('time(s)')
ylabel('Amplitude (AU)')
title('Object Stage Detection, Monkey "S"- Session 1' )
box off
legend('IC','Detect Stg', 'Treshold',' Ext Marker','location','southeast')

clear vars a b bandpass_filt Data Data_all  events_exe events_NM fc1 fc2 FPR IC ICs k incomplete_evs spks_all t th Th_opt W
clear vars labels_exe  p_mean r_mean p_std r_mean r_std Prec_opt Rec_opt presicion recall  TH_opt TPR ep er fs

%% Plot RUS results
file2load='RUS_all_120618_250_rev1.mat';
w2load='W_ICA_RUS120618.mat';
selected_ICs=[7 11 2 4 5 16 21];
[stg_detect_res]=stage_detection(data_folder, file2load, w2load, selected_ICs,fp);
presicion(1,:)=stg_detect_res.Prec_opt;
recall(1,:)=stg_detect_res.Rec_opt;
th(1,:)=stg_detect_res.Th_opt;

file2load='RUS_all_120619_250_rev1.mat';
w2load='W_ICA_RUS120619.mat';
selected_ICs=[12 6 5 3 8 11 44];
[stg_detect_res]=stage_detection(data_folder, file2load, w2load, selected_ICs,fp);
presicion(2,:)=stg_detect_res.Prec_opt;
recall(2,:)=stg_detect_res.Rec_opt;
th(2,:)=stg_detect_res.Th_opt;

file2load='RUS_all_120622_250_rev1.mat';
w2load='W_ICA_RUS120622.mat';
selected_ICs=[7 12 6 10 11 23 26];
[stg_detect_res]=stage_detection(data_folder, file2load, w2load, selected_ICs,fp);
presicion(3,:)=stg_detect_res.Prec_opt;
recall(3,:)=stg_detect_res.Rec_opt;
th(3,:)=stg_detect_res.Th_opt;

file2load='RUS_all_120627_250_rev1.mat';
w2load='W_ICA_RUS120627.mat';
selected_ICs=[20 9 6 8 10 17 50];
[stg_detect_res]=stage_detection(data_folder, file2load, w2load, selected_ICs,fp);
presicion(4,:)=stg_detect_res.Prec_opt;
recall(4,:)=stg_detect_res.Rec_opt;
th(4,:)=stg_detect_res.Th_opt;

file2load='RUS_all_120702_250_rev1.mat';
w2load='W_ICA_RUS120702.mat';
selected_ICs=[16 8 14 11 13 27 38];
[stg_detect_res]=stage_detection(data_folder, file2load, w2load, selected_ICs,fp);
presicion(5,:)=stg_detect_res.Prec_opt;
recall(5,:)=stg_detect_res.Rec_opt;
th(5,:)=stg_detect_res.Th_opt;

p_mean=mean(presicion);
p_std=std(presicion);
r_mean=mean(recall);
r_std=std(recall);

axes(e3)
ep=[0.9 1.9 2.9 3.9 4.9 5.9 6.9];
errhigh = 100*(p_std);
errhigh(4)=errhigh(4)-2.3293;
errhigh(5)=errhigh(5)--0.0303;
errlow  = 100*(p_std);
bar(ep,p_mean*100, 0.3)

hold on
er = errorbar(ep,100*p_mean',errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 


er=[1.2 2.2 3.2 4.2 5.2 6.2 7.2];
bar(er,r_mean*100, 0.3)
errhigh = 100*(r_std);
errhigh(4)=errhigh(4)-0.1434;
errlow  = 100*(r_std);
er = errorbar(er,100*r_mean',errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 

title('Presicion and Recall,  Monkey "R"')
xlim([0.3 7.5])
%xlabel('Stage')
ylabel('Value (%)')
xticks([1 2 3 4 5 6 7])
xticklabels({'Obj\_P','Grip\_C','Go\_C','Start\_M','Beg\_L','End\_L','Rwd'})
box off
