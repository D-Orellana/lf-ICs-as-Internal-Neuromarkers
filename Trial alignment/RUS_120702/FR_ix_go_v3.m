
clear all
fso=30000;
N=100;
load('D:\LFP_spikes_analisys\RUS_120702\RUS_all_120702_250.mat')
load('D:\LFP_spikes_analisys\RUS_120702\W_ICA_RUS120702_250.mat')
load('prefered_chs_RUS_120702.mat')

exe_chs=prefered_chs.execution;

Data=(Data_all.Data)';
Data=(filtfilt(bandpass_filt,Data))';
Data_all.ICs=W*Data;

fs=Data_all.fs;
events_exe=Data_all.events_exe;
events_ob=Data_all.events_ob;
incomplete_evs=Data_all.incomplete_evenets;
labels_exe=Data_all.labels_exe;
labels_ob=Data_all.labels_ob;

%Localization of intenal markers
% GO

IC=-Data_all.ICs(14,:);
for k=1:numel(labels_exe)
    ref=events_exe(k,3);
    ini=round((ref-0.1)*fs);              % 60ms before external marker
    fin=round((ref+1.2)*fs);               % 700ms after external marker
    [~,aux]=findpeaks(IC(ini:fin),'SortStr','descend');
    if isempty(aux)
         [~,aux]=findpeaks(IC(ini-200:fin+200),'SortStr','descend');
    end
    locs_go(k)=aux(1)+ini;
end

% figure;
% plot(IC)
% hold on
% plot(locs_go,IC(locs_go),'Marker','v', 'LineStyle', 'none' )
% for k=1:numel(labels_exe)
%     xline(events_exe(k,3)*fs,'LineWidth',1.5)
% end
% for k=1:numel(labels_ob)
%     xline(events_ob(k,3)*fs,'g','LineWidth',1.5)
% end
% for k=1:numel(incomplete_evs.go)
%     xline(incomplete_evs.go(k)*fs,'r','LineWidth',1.5)
% end
% for k=1:numel(incomplete_evs.grip)
%     xline(incomplete_evs.grip(k)*fs,'r','LineWidth',1.5)
% end
% title ('GO Internal Markers')
locs_go=locs_go/fs;

long=(events_exe(end,8)+4)*fso;                   % Longitud de toda la sesión.
%% Execution  Raster Plot
for kch=1:numel(exe_chs)
    kch
       ch_id=exe_chs(kch);
        spk_indx=round((spks_all(ch_id).index)*30);         %index*30000/1000, los indices esta en ms
        raster_vec=zeros(1,long);
        raster_vec(spk_indx)=1;                                             % raster plot de toda la sesión
        for k=1:numel(labels_exe)
            ini=round((locs_go(k)-0.65)*fso);
            fin=ini + round(1.7*fso);
            int_raster_full(k,:)=raster_vec(ini:fin);
            
            ini=round((events_exe(k,3)-0.0)*fso);
            fin=ini + round(1.7*fso);
            ext_raster_full(k,:)=raster_vec(ini:fin);
        end
        
    for kN=1:N
        aux=randperm(numel(labels_exe),round(0.8*numel(labels_exe)));
        int_raster= int_raster_full(aux,:);
        ext_raster= ext_raster_full(aux,:);
        win=0.1*30000;
        cont=0;
        for k=1:win/10:(numel(ext_raster(1,:))-win-1)
            cont=cont+1;
            ini=k;
            fin=k+win;
            ext_FR(cont)=(fso/win)*sum(ext_raster(:,ini:fin),'all')/numel(labels_exe);
            int_FR(cont)=(fso/win)*sum(int_raster(:,ini:fin),'all')/numel(labels_exe);
        end
        
%     figure
% 	plot(ext_FR)
%     hold on
%     plot(int_FR)
%     hold off

        ext_mean=mean(ext_FR);
        int_mean=mean(int_FR);
        [ext_max,~]=max(abs(ext_FR-ext_mean));
        [int_max,~]=max(abs(int_FR-int_mean));

        ext_FR_ix(kch,kN)=((ext_max+ext_mean)/ext_mean)-1;
        int_FR_ix(kch,kN)=((int_max+int_mean)/int_mean)-1;

    end
end

figure
bar(mean(int_FR_ix,2)*100);
hold on;
bar(mean(ext_FR_ix,2)*100);
mean_improve=round(100*mean(mean(int_FR_ix,2)-mean(ext_FR_ix,2)),1)
std_improve=round(100*mean(std((int_FR_ix-ext_FR_ix)')),1)
%text(1,280,strcat(num2str(mean_improve),'±',num2str(std_improve),' %'))
xlabel('channels')
ylabel('alignment index')

figure
bar(100*(mean(int_FR_ix,2)-mean(ext_FR_ix,2)));
mean_improve=round(100*mean(mean(int_FR_ix,2)-mean(ext_FR_ix,2)),3)
%text(1,280,strcat(num2str(mean_improve),'±',num2str(std_improve),' %'))
xlabel('channels')
ylabel('SPI Diference')


FR_dif=mean(int_FR_ix,2)-mean(ext_FR_ix,2);
histogram(100*FR_dif,20)

name2save='FR_diff_go.mat';
save(name2save,'FR_dif','exe_chs','int_FR_ix','ext_FR_ix');

