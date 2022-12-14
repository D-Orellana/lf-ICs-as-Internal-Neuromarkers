

function  align_results=align_Obj_SPK(data_folder,file2load, w2load, obj_IC,chs2align)

aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)                                                    % Subsampled and merged data

aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                   % Load unmixing matrix
Data=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering
    
fs_raw=30000;
Data=(Data_all.Data)';
Data=(filtfilt(bandpass_filt,Data))';
Data_all.ICs=W*Data;

fs=Data_all.fs;
events_exe=Data_all.events_exe;
events_NM=Data_all.events_NM;
incomplete_evs=Data_all.incomplete_events;
labels_exe=Data_all.labels_exe;

%Localization of intenal markers
% GO
IC=Data_all.ICs(obj_IC,:);
[pksp,~] = findpeaks(IC,'MinPeakHeight',2.8*std(IC));
[pksn,~] = findpeaks(-IC,'MinPeakHeight',2.8*std(IC));
if mean(pksn)>mean(pksp) || isempty(pksp)
    IC=-IC;
end

for k=1:numel(labels_exe)
    ref=events_exe(k,1);
    ini=round((ref-0.1)*fs);              % 60ms before external marker
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
% for k=1:size(events_NM,1)
%     xline(events_NM(k,1)*fs,'g','LineWidth',1.5)
% end
% for k=1:numel(incomplete_evs.go)
%     xline(incomplete_evs.object(k)*fs,'r','LineWidth',1.5)
% end
% title ('Object Internal Markers')
locs_obj=locs_obj/fs;

long=(events_exe(end,8)+4)*fs_raw;                   % Longitud de toda la sesión.
%% Execution  Raster Plot
for kch=1:numel(chs2align)
        ch_id=chs2align(kch);
        spk_indx=round((spks_all(ch_id).index)*30);         %index*30000/1000, los indices esta en ms
        raster_vec=zeros(1,long);
        raster_vec(spk_indx)=1;                                             % raster plot de toda la sesión
        for k=1:numel(labels_exe)
            ini=round((locs_obj(k)-0.45)*fs_raw);
            fin=ini + round(1.7*fs_raw);
            int_raster_full(k,:)=raster_vec(ini:fin);
            
            ini=round((events_exe(k,1)-0.1)*fs_raw);
            fin=ini + round(1.7*fs_raw);
            ext_raster_full(k,:)=raster_vec(ini:fin);
        end
        
        win=0.1*30000;
        cont=0;
        for k=1:win/10:(numel(ext_raster_full(1,:))-win-1)
            cont=cont+1;
            ini=k;
            fin=k+win;
            ext_FR(cont)=(fs_raw/win)*sum(ext_raster_full(:,ini:fin),'all')/numel(labels_exe);
            int_FR(cont)=(fs_raw/win)*sum(int_raster_full(:,ini:fin),'all')/numel(labels_exe);
        end

        figure('Position',[180 80 730 800])
        e1=subplot('Position',[0.09 0.54 0.3 0.4]);
        e2=subplot('Position',[0.09 0.08 0.3 0.4]);
        e3=subplot('Position',[0.5 0.3 0.4 0.4]);
        
        axes(e1); hold on
        for k=1:size(events_exe,1)
        	xx(1,:)=(find(int_raster_full(k,:)==1))/30000;
            xx(2,:)=  xx(1,:);
            yy(1,:)=(k-0.4)*ones(1,numel(xx(1,:)));
            yy(2,:)=(k+0.4)*ones(1,numel(xx(1,:)));
            plot(xx,yy,'Color','k')
            clear xx yy    
        end
        xlim([0 1.1]);
%title(strcat('Aligned with ICs Ch= ',num2str(ch_id)),'Color','k');
        ylim([0 105])
        y=[103 97];
        x=[0.4 0.4];
        [xf,yf]=ds2nfu(x,y);
        annotation(gcf,'arrow', xf,yf,'Color','r')
        text (0.45,101,'Obj-IC')
        xticks =         [ 0.4   1];
        xticklabels = [  0     0.6 ];
        set(gca, 'XTick', xticks, 'XTickLabel', xticklabels);
        ylabel('trial number');
        xlabel('time (s)')
        
        axes(e2)
        hold on;
        for k=1:size(events_exe,1)
            xx(1,:)=(find(ext_raster_full(k,:)==1))/30000;
            xx(2,:)=  xx(1,:);
            yy(1,:)=(k-0.4)*ones(1,numel(xx(1,:)));
            yy(2,:)=(k+0.4)*ones(1,numel(xx(1,:)));
            plot(xx,yy,'Color','k')
            clear xx yy 
        end
        xlim([0 1.1]);
        %title(strcat('Aligned with External Markers Ch= ',num2str(ch_id)),'Color','k');
        ylim([0 105])
        y=[103 97];
        x=[0.18 0.18];
        [xf,yf]=ds2nfu(x,y);
        annotation(gcf,'arrow', xf,yf,'Color','r')
        text (0.23,101,'Obj\_Ext Cue')
        xticks =         [0.18   0.98];
        xticklabels = [ 0     0.8];   
        set(gca, 'XTick', xticks, 'XTickLabel', xticklabels);
        ylabel('trial number');
        xlabel('time (s)')        
        
        ext_mean=mean(ext_FR);
        int_mean=mean(int_FR);
        [ext_max,~]=max(abs(ext_FR-ext_mean));
        [int_max,~]=max(abs(int_FR-int_mean));

        ext_FR_ix(kch)=((ext_max+ext_mean)/ext_mean)-1;
        int_FR_ix(kch)=((int_max+int_mean)/int_mean)-1;
        FR_dif_ix(kch)=int_FR_ix(kch)-ext_FR_ix(kch);
    
        axes(e3)
        plot(ext_FR); hold on;plot(int_FR);
        legend('Ext  alignment','IC alignment')
        title(strcat('Object Alingment Improvement, N',num2str(ch_id),' -->',num2str(100*FR_dif_ix(kch))));
        ylabel('Firing Trial (Hz)')
        xlabel('time (s)')
end

align_results.FR_diff=FR_dif_ix;
align_results.int_FR_ix= int_FR_ix;
align_results. ext_FR_ix= ext_FR_ix;


