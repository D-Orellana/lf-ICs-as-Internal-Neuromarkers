
clear all

load('RUS120627_250.mat')

events_MI=Data_M1_PMd.events_exe;
events_PMv=Data_PMv.events_exe;

time_dif=events_PMv(1,1)-events_MI(1,1);        % Diferencia en el inicio PMv inicia mas pronto
samples_dif=round(time_dif*Data_PMv.fs);        %   Diferencia en muestras a fs=250 Hz

data_MI=Data_M1_PMd.Data;
data_PMv=Data_PMv.Data;
data_PMv(1:samples_dif,:)=[];

length_dif=numel(data_MI(:,1))-numel(data_PMv(:,1));        % existe diferencia en el clock de MI y PMv hay q igular el tamaño de los vectores

aux =round(numel(data_MI(:,1))/(length_dif+1));    % espacio entre muestras a borrar
samples2del=(1:length_dif)*aux;

data_MI(samples2del,:)=[];

data=[data_MI' ; data_PMv'];

Data_all=Data_M1_PMd;
Data_all.Data=data;
Data_all.channels=192;

clear vars length_dif aux data_MI data_PMv  events_MI events_PMv samples2del samples_dif Data_M1_PMd Data_PMv

load('spks_RUS_MI_120627.mat');
spks_MI=Spikes;  clear var Spikes

load('spks_RUS_PMv_120627.mat')
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

save('RUS_all_120627_250','Data_all','spks_all')



