
clear all
data_folder=pwd;
%% SPK 121001
file2load='SPK_all_121001_250.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)

w2load='W_ICA_SPK121001.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                               
Data=(filtfilt(bandpass_filt,Data_all.Data'))';    
selec_comps=[5 101 20 3 13 16 4];

%% Get Distance
for s=1:7
    ic=selec_comps(s);                                      % Selec component
    [~,b]=sort(abs(W(ic,:)),'descend');              % Get index of descent sorting
    orden(s,:)=b;
    W_selec=W(ic,b);                                         % Sort W descend
    Data_selec=Data(b,:);                                  % Sort Data descend              
    pattern=W_selec*Data_selec;
    for k=1:192
        aux_temp=corrcoef(pattern,W_selec(1:k)*Data_selec(1:k,:));
        dist_temp(k)=aux_temp(1,2);
    end
    dist(s,:)=dist_temp;    
end

figure
plot(dist');
dist_SPK(1).orden=orden;
dist_SPK(1).dist=dist;
%% SPK 121003
file2load='SPK_all_121003_250.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)

w2load='W_ICA_SPK121003.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                   % Load unmixing matrix
Data=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering

selec_comps=[13 36 18 2 19 25 5];

%% Get Distance
for s=1:7
    ic=selec_comps(s);                                      % Selec component
    [~,b]=sort(abs(W(ic,:)),'descend');              % Get index of descent sorting
    orden(s,:)=b;
    W_selec=W(ic,b);                                         % Sort W descend
    Data_selec=Data(b,:);                                  % Sort Data descend              
    pattern=W_selec*Data_selec;
    for k=1:192
        aux_temp=corrcoef(pattern,W_selec(1:k)*Data_selec(1:k,:));
        dist_temp(k)=aux_temp(1,2);
    end
    dist(s,:)=dist_temp;    
end
figure
plot(dist');
dist_SPK(2).orden=orden;
dist_SPK(2).dist=dist;

%% SPK 121004
file2load='SPK_all_121004_250.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)

w2load='W_ICA_SPK121004.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                   % Load unmixing matrix
Data=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering
selec_comps=[13 38 17 3 21 14 4];

%% Get Distance
for s=1:7
    ic=selec_comps(s);                                      % Selec component
    [~,b]=sort(abs(W(ic,:)),'descend');              % Get index of descent sorting
    orden(s,:)=b;
    W_selec=W(ic,b);                                         % Sort W descend
    Data_selec=Data(b,:);                                  % Sort Data descend              
    pattern=W_selec*Data_selec;
    for k=1:192
        aux_temp=corrcoef(pattern,W_selec(1:k)*Data_selec(1:k,:));
        dist_temp(k)=aux_temp(1,2);
    end
    dist(s,:)=dist_temp;    
end
figure
plot(dist');
dist_SPK(3).orden=orden;
dist_SPK(3).dist=dist;

%% SPK 121005
file2load='SPK_all_121005_250.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)

w2load='W_ICA_SPK121005.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                   % Load unmixing matrix
Data=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering
selec_comps=[27 32 23 5 22 31 17];

%% Get Distance
for s=1:7
    ic=selec_comps(s);                                      % Selec component
    [~,b]=sort(abs(W(ic,:)),'descend');              % Get index of descent sorting
    orden(s,:)=b;
    W_selec=W(ic,b);                                         % Sort W descend
    Data_selec=Data(b,:);                                  % Sort Data descend              
    pattern=W_selec*Data_selec;
    for k=1:192
        aux_temp=corrcoef(pattern,W_selec(1:k)*Data_selec(1:k,:));
        dist_temp(k)=aux_temp(1,2);
    end
    dist(s,:)=dist_temp;    
end
figure
plot(dist');
dist_SPK(4).orden=orden;
dist_SPK(4).dist=dist;

%% SPK 121107
file2load='SPK_all_121107_250.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)

w2load='W_ICA_SPK121107.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                   % Load unmixing matrix
Data=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering
selec_comps=[7 26 17 24 21 59 32];

%% Get Distance
for s=1:7
    ic=selec_comps(s);                                      % Selec component
    [~,b]=sort(abs(W(ic,:)),'descend');              % Get index of descent sorting
    orden(s,:)=b;
    W_selec=W(ic,b);                                         % Sort W descend
    Data_selec=Data(b,:);                                  % Sort Data descend              
    pattern=W_selec*Data_selec;
    for k=1:192
        aux_temp=corrcoef(pattern,W_selec(1:k)*Data_selec(1:k,:));
        dist_temp(k)=aux_temp(1,2);
    end
    dist(s,:)=dist_temp;    
end
figure
plot(dist');
dist_SPK(5).orden=orden;
dist_SPK(5).dist=dist;

save('IC_contrib_SPK','dist_SPK')


