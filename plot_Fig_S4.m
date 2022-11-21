clear all
data_folder=pwd;
chs=[2 3 109];
figure('Position',[180 10 730 800])
e1=subplot('Position',[0.09 0.67 0.25 0.32]);
e2=subplot('Position',[0.39 0.67 0.25 0.32]);
e3=subplot('Position',[0.69 0.67 0.25 0.32]);

e4=subplot('Position',[0.09 0.3 0.25 0.32]);
e5=subplot('Position',[0.39 0.3 0.25 0.32]);
e6=subplot('Position',[0.69 0.3 0.25 0.32]);

e7=subplot('Position',[0.09 0.05 0.25 0.2]);
e8=subplot('Position',[0.39 0.05 0.25 0.2]);
e9=subplot('Position',[0.69 0.05 0.25 0.2]);

file2load='SPK_all_121001_250.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)        

w2load='W_ICA_SPK121001.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);  


Data=(Data_all.Data)';
Data=(filtfilt(bandpass_filt,Data))';
Data_all.ICs=W*Data;

fs=Data_all.fs;
events_exe=Data_all.events_exe;
events_ob=Data_all.events_ob;
incomplete_evs=Data_all.incomplete_events;
labels_exe=Data_all.labels_exe;
labels_ob=Data_all.labels_ob;


% Identify peaks
% GO
IC=Data_all.ICs(3,:);
for k=1:numel(labels_exe)
    ref=events_exe(k,4);
    ini=round((ref-0.1)*fs);              % 60ms before external marker
    fin=round((ref+0.7)*fs);               % 700ms after external marker
    [~,aux]=findpeaks(IC(ini:fin),'SortStr','descend');
    if isempty(aux)
         [~,aux]=findpeaks(IC(ini-200:fin+200),'SortStr','descend');
    end
    locs_start(k)=aux(1)+ini;
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
locs_start=locs_start/fs;

%% RASTER
Fs_origin=30000;
for kch=1:3
    ch_id=chs(kch);
        spk_indx=round((spks_all(ch_id).index)*30);  %index*30000/1000, los indices esta en ms
        long=(events_exe(end,8)+4)*Fs_origin;
        raster_vec=zeros(1,long);
        raster_vec(spk_indx)=1;
         
        for k=1:size(events_exe,1)
            ini=round((locs_start(k)-0.31)*Fs_origin);
            fin=ini + round(1*Fs_origin);
            raster_p3(k,:)=raster_vec(ini:fin);
          
            ini=round((events_exe(k,4)-0.3)*Fs_origin);
            fin=ini + round(1*Fs_origin);
            raster_p3e(k,:)=raster_vec(ini:fin);
        end
       
    aux=strcat('axes(e',num2str(kch),')');
    eval(aux);
    hold on;
for k=1:size(events_exe,1)
  
	xx(1,:)=(find(raster_p3(k,:)==1))/30000;
    xx(2,:)=  xx(1,:);
    yy(1,:)=(k-0.4)*ones(1,numel(xx(1,:)));
    yy(2,:)=(k+0.4)*ones(1,numel(xx(1,:)));
    plot(xx,yy,'Color','k')
    clear xx yy    
end
xlim([0 1]);
%title(strcat('Aligned with ICs Ch= ',num2str(ch_id)),'Color','k');

y=[98 92];
x=[0.31 0.31];
[xf,yf]=ds2nfu(x,y);
annotation(gcf,'arrow', xf,yf,'Color','k')
text (0.36,95,'IC - Start\_M')
%xline(1.85,'--r')

xticks =         [ 0.31   1.1 ];
xticklabels = [  0     0.7 ];
set(gca, 'XTick', xticks, 'XTickLabel', xticklabels);
%xlabel('time (s)');
%ylabel('trials');

    aux=strcat('axes(e',num2str(kch+3),')');
    eval(aux);
    
hold on;
for k=1:size(events_exe,1)
	xx(1,:)=(find(raster_p3e(k,:)==1))/30000;
    xx(2,:)=  xx(1,:);
    yy(1,:)=(k-0.4)*ones(1,numel(xx(1,:)));
    yy(2,:)=(k+0.4)*ones(1,numel(xx(1,:)));
    plot(xx,yy,'Color','k')
    clear xx yy 
end
xlim([0 1]);
%title(strcat('Aligned with External Markers Ch= ',num2str(ch_id)),'Color','k');

x=[0.3 0.3];
[xf,yf]=ds2nfu(x,y);
annotation(gcf,'arrow', xf,yf,'Color','k')
text (0.35,95,'Start\_M')
%xline(0.1,'--r')

xticks =         [0.3   1];
xticklabels = [ 0     0.7];   
set(gca, 'XTick', xticks, 'XTickLabel', xticklabels);
%xlabel('time (s)');
%ylabel('trials');

win=0.05*30000;
cont=0;
for k=1:win/30:(numel(raster_p3(1,:))-win-1);
    cont=cont+1;
    ini=k;
    fin=k+win;
    fr3(cont)=(Fs_origin/win)*sum(raster_p3(:,ini:fin),'all')/numel(labels_exe);
    fr3e(cont)=(Fs_origin/win)*sum(raster_p3e(:,ini:fin),'all')/numel(labels_exe);
end
mx=max([fr3 fr3e])+30;
mi=min([fr3 fr3e])-5;

t1=linspace(0,1,numel(fr3));

    aux=strcat('axes(e',num2str(kch+6),')');
    eval(aux);

hold on;
plot(t1,fr3,'--k','LineWidth',1.5);
plot(t1,fr3e,'Color',[150/255 150/255 150/255],'LineWidth',1.5);
xlabel('time(s)');
%ylabel('Firing Rate (Hz)');
xticks =         [0.3   1];
xticklabels = [ 0     0.7];  
set(gca, 'XTick', xticks, 'XTickLabel', xticklabels);
ylim([mi mx]);
xlim([0 1]);
end

axes(e2)
set(gca,'ytick',[])
axes(e3)
set(gca,'ytick',[])

axes(e5)
set(gca,'ytick',[])
axes(e6)

set(gca,'ytick',[])
axes(e8)
set(gca,'ytick',[])

axes(e9)
set(gca,'ytick',[])
legend('IC-Start\_M ','Start\_M','location','northeast')

