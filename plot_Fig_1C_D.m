
%% GO SPK
% Sesion 1
clear all
data_folder=pwd;

file2load='SPK_all_121001_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);   
Data=Data_all.Data;
fs=Data_all.fs;
labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;

antes=1;        % time before Start Movement
despues=1;  % time after Start Movement
bef_Start=[];
aft_Start=[];
overlap=38;

for k=1:numel(labels_exe)
    ref=events_exe(k,4);
    aux=Data(:,round(ref-antes)*fs:round(ref*fs));
    bef_Start=[bef_Start aux];
    
    aux=Data(:,round(ref*fs):round((ref+despues)*fs));
    aft_Start=[aft_Start aux];
end

for k=1:size(Data,1)
    [psd_BG(k,:),f]=pwelch(bef_Start(k,:),375,overlap,375,fs); % segment length 375, overlap 275, DFT with 375 points, fs=250
    [psd_AG(k,:),f]=pwelch(aft_Start(k,:),375,overlap,375,fs);
end
psd_BG_SPK_final(1,:)=mean(psd_BG,1);
psd_AG_SPK_final(1,:)=mean(psd_AG,1);
 diff_log_spk(:,1)=10*log10(psd_AG_SPK_final(1,:))-10*log10(psd_BG_SPK_final(1,:));
 diff_abs_spk(:,1)=psd_AG_SPK_final(1,:)-psd_BG_SPK_final(1,:);

clear vars  aft_go antes aux bef_go Data despues duration events_exe events_ob fs grips incomplete_evs k labels_description labels_exe
clear vars labels_ob objects ref total_chs psd_AG psd_BG f

% Sesion 2
file2load='SPK_all_121003_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);   
Data=Data_all.Data;
fs=Data_all.fs;
labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;

antes=1;
despues=1;
bef_Start=[];
aft_Start=[];

for k=1:numel(labels_exe)
    ref=events_exe(k,4);
    aux=Data(:,round((ref-antes)*fs):round(ref*fs));
    bef_Start=[bef_Start aux];
    
    aux=Data(:,round(ref*fs):round((ref+despues)*fs));
    aft_Start=[aft_Start aux];
end

for k=1:size(Data,1)
    [psd_BG(k,:),f]=pwelch(bef_Start(k,:),375,overlap,375,fs);
    [psd_AG(k,:),f]=pwelch(aft_Start(k,:),375,overlap,375,fs);
end
psd_BG_SPK_final(2,:)=mean(psd_BG,1);
psd_AG_SPK_final(2,:)=mean(psd_AG,1);
diff_log_spk(:,2)=10*log10(psd_AG_SPK_final(2,:))-10*log10(psd_BG_SPK_final(2,:));
diff_abs_spk(:,2)=psd_AG_SPK_final(2,:)-psd_BG_SPK_final(2,:);

clear vars  aft_go antes aux bef_go Data despues duration events_exe events_ob fs grips incomplete_evs k labels_description labels_exe
clear vars labels_ob objects ref total_chs psd_AG psd_BG f

% Sesion 3
file2load='SPK_all_121004_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);   
Data=Data_all.Data;
fs=Data_all.fs;
labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;

antes=1;
despues=1;
bef_Start=[];
aft_Start=[];

for k=1:numel(labels_exe)
    ref=events_exe(k,3);
    aux=Data(:,round((ref-antes)*fs):round(ref*fs));
    bef_Start=[bef_Start aux];
    
    aux=Data(:,round(ref*fs):round((ref+despues)*fs));
    aft_Start=[aft_Start aux];
end

for k=1:size(Data,1)
    [psd_BG(k,:),f]=pwelch(bef_Start(k,:),375,overlap,375,fs);
    [psd_AG(k,:),f]=pwelch(aft_Start(k,:),375,overlap,375,fs);
end
psd_BG_SPK_final(3,:)=mean(psd_BG,1);
psd_AG_SPK_final(3,:)=mean(psd_AG,1);

 diff_log_spk(:,3)=10*log10(psd_AG_SPK_final(3,:))-10*log10(psd_BG_SPK_final(3,:));
 diff_abs_spk(:,3)=psd_AG_SPK_final(3,:)-psd_BG_SPK_final(3,:);
 
clear vars  aft_go antes aux bef_go Data despues duration events_exe events_ob fs grips incomplete_evs k labels_description labels_exe
clear vars labels_ob objects ref total_chs psd_AG psd_BG 

% % Sesion 4
file2load='SPK_all_121005_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);   
Data=Data_all.Data;
fs=Data_all.fs;
labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;

antes=1;
despues=1;
bef_Start=[];
aft_Start=[];

for k=1:numel(labels_exe)
    ref=events_exe(k,4);
    aux=Data(:,round((ref-antes)*fs):round(ref*fs));
    bef_Start=[bef_Start aux];
    
    aux=Data(:,round(ref*fs):round((ref+despues)*fs));
    aft_Start=[aft_Start aux];
end

for k=1:size(Data,1)
    [psd_BG(k,:),f]=pwelch(bef_Start(k,:),375,overlap,375,fs);
    [psd_AG(k,:),f]=pwelch(aft_Start(k,:),375,overlap,375,fs);
end
psd_BG_SPK_final(4,:)=mean(psd_BG,1);
psd_AG_SPK_final(4,:)=mean(psd_AG,1);
diff_log_spk(:,4)=10*log10(psd_AG_SPK_final(4,:))-10*log10(psd_BG_SPK_final(4,:));
diff_abs_spk(:,4)=psd_AG_SPK_final(4,:)-psd_BG_SPK_final(4,:);

 clear vars  aft_go antes aux bef_go Data despues duration events_exe events_ob fs grips incomplete_evs k labels_description labels_exe
 clear vars labels_ob objects ref total_chs psd_AG psd_BG f
% 
% % Sesion 5
file2load='SPK_all_121107_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);   
Data=Data_all.Data;
fs=Data_all.fs;
labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;

antes=1;
despues=1;
bef_Start=[];
aft_Start=[];

for k=1:numel(labels_exe)
    ref=events_exe(k,4);
    aux=Data(:,round((ref-antes)*fs):round(ref*fs));
    bef_Start=[bef_Start aux];
    
    aux=Data(:,round(ref*fs):round((ref+despues)*fs));
    aft_Start=[aft_Start aux];
end

for k=1:size(Data,1)
    [psd_BG(k,:),f]=pwelch(bef_Start(k,:),375,overlap,375,fs);
    [psd_AG(k,:),f]=pwelch(aft_Start(k,:),375,overlap,375,fs);
end
psd_BG_SPK_final(5,:)=mean(psd_BG,1);
psd_AG_SPK_final(5,:)=mean(psd_AG,1);
 diff_log_spk(:,5)=10*log10(psd_AG_SPK_final(5,:))-10*log10(psd_BG_SPK_final(5,:));
 diff_abs_spk(:,5)=psd_AG_SPK_final(4,:)-psd_BG_SPK_final(5,:);

%% RUSTY
% Sesion 1

file2load='RUS_all_120618_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);   
Data=Data_all.Data;
fs=Data_all.fs;
labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;

antes=1;
despues=1;
bef_Start=[];
aft_Start=[];

for k=1:numel(labels_exe)
    ref=events_exe(k,4);
    aux=Data(:,round((ref-antes)*fs):round(ref*fs));
    bef_Start=[bef_Start aux];
    aux=Data(:,round(ref*fs):round((ref+despues)*fs));
    aft_Start=[aft_Start aux];
end

for k=1:size(Data,1)
    [psd_BG(k,:),f]=pwelch(bef_Start(k,:),375,overlap,375,fs);
    [psd_AG(k,:),f]=pwelch(aft_Start(k,:),375,overlap,375,fs);
end
psd_BG_RUS_final(1,:)=mean(psd_BG,1);
psd_AG_RUS_final(1,:)=mean(psd_AG,1);
diff_log_rus(:,1)=10*log10(psd_AG_RUS_final(1,:))-10*log10(psd_BG_RUS_final(1,:));
diff_abs_rus(:,1)=psd_AG_RUS_final(1,:)-psd_BG_RUS_final(1,:);

clear vars  aft_go antes aux bef_go Data despues duration events_exe events_ob grips incomplete_evs k labels_description labels_exe
clear vars labels_ob objects ref total_chs psd_AG psd_BG

% Sesion 2
file2load='RUS_all_120619_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);   
Data=Data_all.Data;
fs=Data_all.fs;
labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;

antes=1;
despues=1;
bef_Start=[];
aft_Start=[];

for k=1:numel(labels_exe)
    ref=events_exe(k,4);
    aux=Data(:,round((ref-antes)*fs):round(ref*fs));
    bef_Start=[bef_Start aux];
    aux=Data(:,round(ref*fs):round((ref+despues)*fs));
    aft_Start=[aft_Start aux];
end

for k=1:size(Data,1)
    [psd_BG(k,:),f]=pwelch(bef_Start(k,:),375,overlap,375,fs);
    [psd_AG(k,:),f]=pwelch(aft_Start(k,:),375,overlap,375,fs);
end
psd_BG_RUS_final(2,:)=mean(psd_BG,1);
psd_AG_RUS_final(2,:)=mean(psd_AG,1);

diff_log_rus(:,2)=10*log10(psd_AG_RUS_final(2,:))-10*log10(psd_BG_RUS_final(2,:));
diff_abs_rus(:,2)=psd_AG_RUS_final(2,:)-psd_BG_RUS_final(2,:);

clear vars  aft_go antes aux bef_go Data despues duration events_exe events_ob grips incomplete_evs k labels_description labels_exe
clear vars labels_ob objects ref total_chs psd_AG psd_BG

% Sesion 3
file2load='RUS_all_120622_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);   
Data=Data_all.Data;
fs=Data_all.fs;
labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;

antes=1;
despues=1;
bef_Start=[];
aft_Start=[];

for k=1:numel(labels_exe)
    ref=events_exe(k,4);
    aux=Data(:,round((ref-antes)*fs):round(ref*fs));
    bef_Start=[bef_Start aux];
    
    ref=events_exe(k,3);
    aux=Data(:,round(ref*fs):round((ref+despues)*fs));
    aft_Start=[aft_Start aux];
end

for k=1:size(Data,1)
    [psd_BG(k,:),f]=pwelch(bef_Start(k,:),375,overlap,375,fs);
    [psd_AG(k,:),f]=pwelch(aft_Start(k,:),375,overlap,375,fs);
end
psd_BG_RUS_final(3,:)=mean(psd_BG,1);
psd_AG_RUS_final(3,:)=mean(psd_AG,1);
diff_log_rus(:,3)=10*log10(psd_AG_RUS_final(3,:))-10*log10(psd_BG_RUS_final(3,:));
diff_abs_rus(:,3)=psd_AG_RUS_final(3,:)-psd_BG_RUS_final(3,:);

clear vars  aft_go antes aux bef_go Data despues duration events_exe events_ob grips incomplete_evs k labels_description labels_exe
clear vars labels_ob objects ref total_chs psd_AG psd_BG

% Sesion 4
file2load='RUS_all_120627_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);   
Data=Data_all.Data;
fs=Data_all.fs;
labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;

antes=1;
despues=1;
bef_Start=[];
aft_Start=[];

for k=1:numel(labels_exe)
    ref=events_exe(k,4);
    aux=Data(:,round((ref-antes)*fs):round(ref*fs));
    bef_Start=[bef_Start aux];
    aux=Data(:,round(ref*fs):round((ref+despues)*fs));
    aft_Start=[aft_Start aux];
end

for k=1:size(Data,1)
    [psd_BG(k,:),f]=pwelch(bef_Start(k,:),375,overlap,375,fs);
    [psd_AG(k,:),f]=pwelch(aft_Start(k,:),375,overlap,375,fs);
end
psd_BG_RUS_final(4,:)=mean(psd_BG,1);
psd_AG_RUS_final(4,:)=mean(psd_AG,1);
diff_log_rus(:,4)=10*log10(psd_AG_RUS_final(4,:))-10*log10(psd_BG_RUS_final(4,:));
diff_abs_rus(:,4)=psd_AG_RUS_final(4,:)-psd_BG_RUS_final(4,:);

clear vars  aft_go antes aux bef_go Data despues duration events_exe events_ob grips incomplete_evs k labels_description labels_exe
clear vars labels_ob objects ref total_chs psd_AG psd_BG

% Sesion 5
file2load='RUS_all_120702_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);   
Data=Data_all.Data;
fs=Data_all.fs;
labels_exe=Data_all.labels_exe;
events_exe=Data_all.events_exe;

antes=1;
despues=1;
bef_Start=[];
aft_Start=[];

for k=1:numel(labels_exe)
    ref=events_exe(k,3);
    aux=Data(:,(round(ref-antes)*fs):round(ref*fs));
    bef_Start=[bef_Start aux];
    aux=Data(:,round(ref*fs):round((ref+despues)*fs));
    aft_Start=[aft_Start aux];
end

for k=1:size(Data,1)
    [psd_BG(k,:),f]=pwelch(bef_Start(k,:),375,overlap,375,fs);
    [psd_AG(k,:),f]=pwelch(aft_Start(k,:),375,overlap,375,fs);
end
psd_BG_RUS_final(5,:)=mean(psd_BG,1);
psd_AG_RUS_final(5,:)=mean(psd_AG,1);
diff_log_rus(:,5)=10*log10(psd_AG_RUS_final(5,:))-10*log10(psd_BG_RUS_final(5,:));
diff_abs_rus(:,5)=psd_AG_RUS_final(5,:)-psd_BG_RUS_final(5,:);

clear vars  aft_go antes aux bef_go Data despues duration events_exe events_ob fs grips incomplete_evs k labels_description labels_exe
clear vars labels_ob objects ref total_chs psd_AG psd_BG

mbgRUS=10*log10(mean(psd_BG_RUS_final));
magRUS=10*log10(mean(psd_AG_RUS_final));


%% Versión con un eje a cada lado
a=(abs(mean(diff_log_spk(:,1:3),2)))';
b=(10*log10(mean(psd_BG_SPK_final(1:3,:))));
c=(10*log10(mean(psd_AG_SPK_final(1:3,:))));
figure('Position',[600 600 735 320]);
colororder({'b','k'})
yyaxis left
hold on
plot(f',b,'-','Color','r')
plot(f',c,'-','Color','b')
ylim([0 35])
yyaxis right
plot(f',a,'Color','k','Linewidth',1.5)
ylim([0 8])
xlim([0 35])
hold on
area([0.1 3], [80 80],'FaceColor','b','FaceAlpha',.1,'EdgeAlpha',.1);
area([3 6], [80 80],'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.1);
area([7 10], [80 80],'FaceColor','c','FaceAlpha',.1,'EdgeAlpha',.1);
area([13 17], [80 80],'FaceColor','y','FaceAlpha',.1,'EdgeAlpha',.1);
area([21 25], [80 80],'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.1);
%title('Power Spectral Density Monkey "A"')
legend('PSD BG -> A1','PSD AG -> A1','PSD difference --> A2')
xlabel('Frequency (Hz)')

a=(abs(mean(diff_log_rus,2)))';
b=(10*log10(mean(psd_BG_RUS_final(1:5,:))));
c=(10*log10(mean(psd_AG_RUS_final(1:5,:))));
figure('Position',[600 100 735 320]);
colororder({'b','k'})
yyaxis left
hold on
plot(f',b,'-','Color','r')
plot(f',c,'-','Color','b')
ylim([0 40])
yyaxis right
plot(f',a,'Color','k','Linewidth',1.5)
ylim([0 8])
xlim([0 35])
hold on
area([0.1 3], [80 80],'FaceColor','b','FaceAlpha',.1,'EdgeAlpha',.1);
area([3.5 6.5], [80 80],'FaceColor','r','FaceAlpha',.1,'EdgeAlpha',.1);
area([8 11], [80 80],'FaceColor','c','FaceAlpha',.1,'EdgeAlpha',.1);
area([16.5 19.5], [80 80],'FaceColor','y','FaceAlpha',.1,'EdgeAlpha',.1);
area([26 32], [80 80],'FaceColor','g','FaceAlpha',.1,'EdgeAlpha',.1);
%title('Power Spectral Density Monkey "B"')
legend('PSD BG -> A1','PSD AG -> A1','PSD difference --> A2')
xlabel('Frequency (Hz)')
