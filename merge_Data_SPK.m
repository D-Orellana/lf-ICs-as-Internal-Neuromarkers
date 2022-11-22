
function [Data_all]=merge_Data_SPK(Data_PMv, Data_M1_PMd,svf)

events_MI=Data_M1_PMd.events_exe;
events_PMv=Data_PMv.events_exe;

time_dif=events_PMv(1,1)-events_MI(1,1);       % the recording start time of PMv and MI_PMd is not the same.

if time_dif>0                                                                   % PMv starts first it is necesary to delete the samples at the begining
    samples_dif=round(time_dif*Data_PMv.fs);       
    data_MI=Data_M1_PMd.Data;
    data_PMv=Data_PMv.Data;
    data_PMv(1:samples_dif,:)=[];
else
    time_dif=events_MI(1,1)-events_PMv(1,1);        % PMv starts after it is necesary to fill with zeros at the begining
    samples_dif=round(time_dif*Data_PMv.fs);        
    data_MI=Data_M1_PMd.Data;
    aux_data=zeros(samples_dif,96);
    data_PMv=[aux_data;Data_PMv.Data];
end





length_dif=numel(data_MI(:,1))-numel(data_PMv(:,1));        % existe diferencia en el clock de MI y PMv hay q igular el tamaño de los vectores
aux =round(numel(data_MI(:,1))/(length_dif+1));    % espacio entre muestras a borrar
samples2del=(1:length_dif)*aux;
data_MI(samples2del,:)=[];
data=[data_MI' ; data_PMv'];
Data_all=Data_M1_PMd;
Data_all.Data=data;
Data_all.channels=192;




length_dif=numel(data_MI(:,1))-numel(data_PMv(:,1));        % existe diferencia en el clock de MI y PMv hay q igular el tamaño de los vectores

aux =round(numel(data_MI(:,1))/(length_dif+1));    % espacio entre muestras a borrar
samples2del=(1:length_dif)*aux;

data_MI(samples2del,:)=[];

data=[data_MI' ; data_PMv'];

Data_all=Data_M1_PMd;
Data_all.Data=data;
Data_all.channels=192;

clear vars length_dif aux data_MI data_PMv  events_MI events_PMv samples2del samples_dif Data_M1_PMd Data_PMv

load('spks_SPK_MI_121001.mat');
spks_MI=Spikes;  clear var Spikes

load('spks_SPK_PMv_121001.mat')
spks_all=spks_MI;
for k=1:96
    %aux=Spikes(k).index+0.5;
    aux=Spikes(k).index-time_dif*1000;  % los spikes estan em ms entonces la dif tambien debe estar en ms
    a=find(aux<0);
    if ~isempty(a)
        aux(a)=[];
    end
    spks_all(k+96).index=aux;
end

%save('SPK_all_121001_250','Data_all','spks_all')



