
clear all
fso=30000;
N=100;
load('D:\LFP_spikes_analisys\RUS_120627\RUS_all_120627_250.mat')
load('D:\LFP_spikes_analisys\RUS_120627\W_ICA_RUS120627_250.mat')
load('prefered_chs_RUS_120627.mat')

grip_chs=prefered_chs.grip;
grip_chs=[34 55 98 133 135 137 168 169 175];

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
%Grip
IC=-Data_all.ICs(9,:);
for k=1:numel(labels_exe)
    ref=events_exe(k,2);
    ini=round((ref-0.0)*fs);              % 60ms before external marker
    fin=round((ref+1.2)*fs);               % 700ms after external marker
    [~,aux]=findpeaks(IC(ini:fin),'SortStr','descend');
    if isempty(aux)
         [~,aux]=findpeaks(IC(ini-200:fin+200),'SortStr','descend');
    end
    locs_grip(k)=aux(1)+ini;
end

% figure;
% plot(IC)
% hold on
% plot(locs_grip,IC(locs_grip),'Marker','v', 'LineStyle', 'none' )
% for k=1:numel(labels_exe)
%     xline(events_exe(k,2)*fs,'LineWidth',1.5)
% end
% for k=1:numel(labels_ob)
%     xline(events_ob(k,2)*fs,'g','LineWidth',1.5)
% end
% for k=1:numel(incomplete_evs.go)
%     xline(incomplete_evs.grip(k)*fs,'r','LineWidth',1.5)
% end
% title ('Grip Internal Markers')
locs_grip=locs_grip/fs;


long=(events_exe(end,8)+4)*fso;                   % Longitud de toda la sesión.
%% Execution  Raster Plot
for kch=1:numel(grip_chs)
    kch
       ch_id=grip_chs(kch);
        spk_indx=round((spks_all(ch_id).index)*30);         %index*30000/1000, los indices esta en ms
        raster_vec=zeros(1,long);
        raster_vec(spk_indx)=1;                                             % raster plot de toda la sesión
        for k=1:numel(labels_exe)
            ini=round((locs_grip(k)-0.46)*fso);
            fin=ini + round(0.7*fso);
            int_raster_full(k,:)=raster_vec(ini:fin);
            
            ini=round((events_exe(k,2)+0.33)*fso);
            fin=ini + round(0.7*fso);
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
%     plot(ext_FR)
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


mean_improve=round(mean(100*(mean(int_FR_ix,2)-mean(ext_FR_ix,2))),2)
std_improve=round(100*mean(std((int_FR_ix-ext_FR_ix)')),2)

figure
FR_dif=mean(int_FR_ix,2)-mean(ext_FR_ix,2);
histogram(100*FR_dif,20)

mean(int_FR_ix,2)-mean(ext_FR_ix,2)

name2save='FR_diff_grip.mat';
save(name2save,'FR_dif','grip_chs','int_FR_ix','ext_FR_ix');

