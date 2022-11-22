
clear all
data_folder=pwd;

%% RUS120618
file2load='RUS_all_120618_250.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)

w2load='W_ICA_RUS120618.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                               
Data=(filtfilt(bandpass_filt,Data_all.Data'))';    
selec_comps=[7 11 2 4 5 16 21];

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
dist_RUS(1).orden=orden;
dist_RUS(1).dist=dist;
%% RUS120619
file2load='RUS_all_120619_250.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)

w2load='W_ICA_RUS120619.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                               
Data=(filtfilt(bandpass_filt,Data_all.Data'))';  

selec_comps=[12 6 5 3 8 11 44];

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
dist_RUS(2).orden=orden;
dist_RUS(2).dist=dist;

%% RUS120622
file2load='RUS_all_120622_250.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)

w2load='W_ICA_RUS120622.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                               
Data=(filtfilt(bandpass_filt,Data_all.Data'))';  
selec_comps=[7 12 6 10 11 23 26];
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
dist_RUS(3).orden=orden;
dist_RUS(3).dist=dist;

%% RUS120627
file2load='RUS_all_120627_250.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)

w2load='W_ICA_RUS120627.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                               
Data=(filtfilt(bandpass_filt,Data_all.Data'))';  

selec_comps=[20 9 6 8 10 17 50];

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
dist_RUS(4).orden=orden;
dist_RUS(4).dist=dist;

%% RUS120702
file2load='RUS_all_120702_250.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)

w2load='W_ICA_RUS120702.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                               
Data=(filtfilt(bandpass_filt,Data_all.Data'))';  
selec_comps=[16 8 14 11 13 27 38]; 

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
dist_RUS(5).orden=orden;
dist_RUS(5).dist=dist;

save('IC_contrib_RUS','dist_RUS')


