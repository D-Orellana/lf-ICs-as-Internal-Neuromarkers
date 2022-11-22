
clear all
fso=30000;
N=100;
load('D:\LFP_spikes_analisys\RUS_120702\RUS_all_120702_250.mat')
load('D:\LFP_spikes_analisys\RUS_120702\W_ICA_RUS120702_250.mat')
load('prefered_chs_RUS_120702.mat')

obj_chs=prefered_chs.object;
obj_chs=[4 6 55 56 133 161 169  173 ];

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
%Object
IC=-Data_all.ICs(16,:);
for k=1:numel(labels_exe)
    ref=events_exe(k,1);
    ini=round((ref-0.0)*fs);              % 60ms before external marker
    fin=round((ref+0.7)*fs);               % 700ms after external marker
    [~,aux]=findpeaks(IC(ini:fin),'SortStr','descend');
    if isempty(aux)
         [~,aux]=findpeaks(IC(ini-200:fin+200),'SortStr','descend');
    end
    locs_obj(k)=aux(1)+ini;
end

% figure;
% plot(IC)
% hold on
% plot(locs_obj,IC(locs_obj),'Marker','v', 'LineStyle', 'none' )
% for k=1:numel(labels_exe)
%     xline(events_exe(k,1)*fs,'LineWidth',1.5)
% end
% for k=1:numel(labels_ob)
%     xline(events_ob(k,1)*fs,'g','LineWidth',1.5)
% end
% for k=1:numel(incomplete_evs.go)
%     xline(incomplete_evs.object(k)*fs,'r','LineWidth',1.5)
% end
% title ('Object Internal Markers')
locs_obj=locs_obj/fs;


long=(events_exe(end,8)+4)*fso;                   % Longitud de toda la sesión.
%% Execution  Raster Plot
for kch=1:numel(obj_chs)
    kch
       ch_id=obj_chs(kch);
        spk_indx=round((spks_all(ch_id).index)*30);         %index*30000/1000, los indices esta en ms
        raster_vec=zeros(1,long);
        raster_vec(spk_indx)=1;                                             % raster plot de toda la sesión
        for k=1:numel(labels_exe)
            ini=round((locs_obj(k)-0.3)*fso);
            fin=ini + round(0.7*fso);
            int_raster_full(k,:)=raster_vec(ini:fin);
            
            ini=round((events_exe(k,1)-0.1)*fso);
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


mean_improve=round(100*mean(mean(int_FR_ix,2)-mean(ext_FR_ix,2)),2)
std_improve=round(100*mean(std((int_FR_ix-ext_FR_ix)')),2)

figure
FR_dif=mean(int_FR_ix,2)-mean(ext_FR_ix,2);
histogram(100*FR_dif,20)

mean(int_FR_ix,2)-mean(ext_FR_ix,2)

name2save='FR_diff_obj.mat';
save(name2save,'FR_dif','obj_chs','int_FR_ix','ext_FR_ix');

