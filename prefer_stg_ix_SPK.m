
function preference_idx=ICs_sorting_SPK(data_folder,file2load, w2load,go_IC)

aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)                                                    % Subsampled and merged data

aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                   % Load unmixing matrix

Data=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering

Data_all.ICs=W*Data;
fs=Data_all.fs;
events_exe=Data_all.events_exe;
events_NM=Data_all.events_NM;
incomplete_evs=Data_all.incomplete_events;
labels_exe=Data_all.labels_exe;

th_obj=0.7;
th_grip=0.7;
th_exe=0.7;

% Identify peaks
locs_obj=events_exe(:,1);
locs_grip=events_exe(:,2);
 
IC=Data_all.ICs(go_IC,:);
[pksp,~] = findpeaks(IC,'MinPeakHeight',2.8*std(IC));
[pksn,~] = findpeaks(-IC,'MinPeakHeight',2.8*std(IC));
if mean(pksn)>mean(pksp) || isempty(pksp)
    IC=-IC;
end
for k=1:numel(labels_exe)
    ref=events_exe(k,3);
    ini=round((ref-0.1)*fs);              % 60ms before external marker
    fin=round((ref+0.7)*fs);               % 700ms after external marker
    [~,aux]=findpeaks(IC(ini:fin),'SortStr','descend');
    if isempty(aux)
         [~,aux]=findpeaks(IC(ini-200:fin+200),'SortStr','descend');
    end
    locs_go(k)=aux(1)+ini;
end
locs_go=locs_go/fs;


%% RASTER
Fs_origin=30000;
kob=0;
kgrip=0;
kexe=0;
for ch_id=1:192
        spk_indx=round((spks_all(ch_id).index)*30);  %index*30000/1000, los indices esta en ms
        long=(events_exe(end,8)+4)*Fs_origin;
        raster_vec=zeros(1,long);
        raster_vec(spk_indx)=1;
         
        for k=1:size(events_exe,1)
            ini=round((locs_obj(k)-0.0)*Fs_origin);
            fin=ini + round(1*Fs_origin);
            raster_p1(k,:)=raster_vec(ini:fin);
            
            ini=round((locs_grip(k)-0.0)*Fs_origin);
            fin=ini + round(2*Fs_origin);
            raster_p2(k,:)=raster_vec(ini:fin);
            
            ini=round((locs_go(k)-0.3)*Fs_origin);
            fin=ini + round(1.7*Fs_origin);
            raster_p3(k,:)=raster_vec(ini:fin);
         end

    inter=zeros(size(raster_p1,1),3000);
   
    win=0.1*30000;
    cont=0;
    for k=1:win/10:(numel(raster_p1(1,:))-win-1);
        cont=cont+1;
        ini=k;
        fin=k+win;
        fr1(cont)=(Fs_origin/win)*sum(raster_p1(:,ini:fin),'all')/numel(labels_exe);
    end
    
    cont=0;
    for k=1:win/10:(numel(raster_p2(1,:))-win-1);
        cont=cont+1;
        ini=k;
        fin=k+win;
        fr2(cont)=(Fs_origin/win)*sum(raster_p2(:,ini:fin),'all')/numel(labels_exe);
    end
    
    cont=0;
    for k=1:win/10:(numel(raster_p3(1,:))-win-1);
        cont=cont+1;
        ini=k;
        fin=k+win;
        fr3(cont)=(Fs_origin/win)*sum(raster_p3(:,ini:fin),'all')/numel(labels_exe);
    end

    m_ob=mean(fr1);
    m_grip=mean(fr2);
    m_exe=mean(fr3);
    [mx_obj,lo]=max(abs(fr1-m_ob));
    [mx_grip,lgr]=max(abs(fr2(1:150)-m_grip));
    [mx_go,lgo]=max(abs(fr3-m_exe));
    
    tp_ob_ix=((mx_obj+m_ob)/m_ob)-1;
    tp_grip_ix=((mx_grip+m_grip)/m_grip)-1;
    tp_exe_ix=((mx_go+m_exe)/m_exe)-1;
    
      
   if mean([fr1 fr2 fr3])>15
         if tp_ob_ix>th_obj
             kob=kob+1;
             ch_ob(kob)=ch_id;
         end
         if tp_grip_ix>th_grip
             kgrip=kgrip+1;
             ch_grip(kgrip)=ch_id;
         end
         if tp_exe_ix>th_exe
             kexe=kexe+1;
             ch_exe(kexe)=ch_id;
         end     
    end
end

preference_idx.object=ch_ob;
preference_idx.grip=ch_grip;
preference_idx.execution=ch_exe;
preference_idx.treshold=[th_obj th_grip th_exe];

%name2save='prefered_chs_SPK_121001.mat';
%save(name2save,'prefered_chs');
