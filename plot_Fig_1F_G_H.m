clear all
data_folder=pwd;

xini=10;
xfin=50;

%% Loading Data
file2load='SPK_all_121001_250_rev1.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);   

fs=Data_all.fs;
events_exe=Data_all.events_exe;

w2load='W_ICA_SPK121001.mat';
aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                       % Load unmixing matrix
Data=Data_all.Data;
Data_filt=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering
    
load('coords_SPK.mat')
coords=[coord_MI_PMd ; coord_PMv];

ICA_comps=W*Data_filt;

%% Ceate figure
figure('Position',[100 100 1100 600])
ax1=subplot('Position',[0.47 0.69 0.20 0.24]);
ax2=subplot('Position',[0.78 0.69 0.20 0.24]);

ax3=subplot('Position',[0.04 0.03 0.20 0.11]);
ax5=subplot('Position',[0.26 0.03 0.20 0.11]);
ax7=subplot('Position',[0.54 0.03 0.20 0.11]);

ax4=subplot('Position',[0.04 0.18 0.22 0.34]);
ax6=subplot('Position',[0.26 0.18 0.22 0.34]);
ax8=subplot('Position',[0.54 0.18 0.22 0.34]);

%% Plot Raw
t=(1:size(Data,2))*(1/fs);
axes(ax1); hold on;
plot(t,Data(1,:));
plot(t,Data(2,:)-450);
plot(t,Data(3,:)-900);
plot(t,Data(4,:)-1800);
text(4,0,'Ch 1');
text(4,-450,'Ch 2')
text(4,-900,'Ch 3')
text(2,-1800,'Ch 192')
ax1.XAxis.Visible = 'off';
ax1.YAxis.Visible = 'off';
box off
axis off
xlabel('time(s)')
xlim([xini xfin])


%% Plot Filtered Data
axes(ax2); hold on;
plot(t,Data_filt(1,:));
plot(t,Data_filt(2,:)-450);
plot(t,Data_filt(3,:)-900);
plot(t,Data_filt(4,:)-1800);
ax2.XAxis.Visible = 'off';
ax2.YAxis.Visible = 'off';
text(4,0,'Ch 1');
text(4,-450,'Ch 2')
text(4,-900,'Ch 3')
text(2,-1800,'Ch 192')
box off
axis off
xlim([xini xfin])

%% Plot Components in Time
axes(ax3)
plot(t,-ICA_comps(5,:));
%ax3.XAxis.Visible = 'on';
ax3.YAxis.Visible = 'off';  box off;
ylim([-7 18])
xlim([xini xfin])
axis off

axes(ax5)
plot(t,ICA_comps(101,:));
%ax5.XAxis.Visible = 'on';
ax5.YAxis.Visible = 'off';  box off;
ylim([-7 18])
xlim([xini xfin])
axis off

axes(ax7)
plot(t,ICA_comps(192,:));
%ax7.XAxis.Visible = 'on';
ax7.YAxis.Visible = 'off';  box off;
ylim([-7 18])
xlim([xini xfin])
axis off

%% Plot Maps
axes(ax4)
aux_comp=abs(W(5,:));
aux_comp_norm=(aux_comp-min(aux_comp))/(max(aux_comp)-min(aux_comp));
scatter(coords(:,1),coords(:,2),30,aux_comp_norm,'filled')
set(gca,'View', [0,-90]);
text (300,600,'IC-1','Color','k','Fontsize',13,'FontWeight','bold');
text (-20,1050,'PMv')
text (720,780,'MI')
text (440,150,'PMd')
axis off

axes(ax6)
aux_comp=abs(W(101,:));
aux_comp_norm=(aux_comp-min(aux_comp))/(max(aux_comp)-min(aux_comp));
scatter(coords(:,1),coords(:,2),30,aux_comp_norm,'filled')
set(gca,'View', [0,-90]);
text (300,600,'IC-2','Color','k','Fontsize',13,'FontWeight','bold');
text (-20,1050,'PMv')
text (720,780,'MI')
text (440,150,'PMd')
axis off

axes(ax8)
aux_comp=abs(W(192,:));
aux_comp_norm=(aux_comp-min(aux_comp))/(max(aux_comp)-min(aux_comp));
scatter(coords(:,1),coords(:,2),30,aux_comp_norm,'filled')
set(gca,'View', [0,-90]);
text (300,600,'IC-192','Color','k','Fontsize',13,'FontWeight','bold');
text (-20,1050,'PMv')
text (720,780,'MI')
text (440,150,'PMd')
axis off

  for cont=1:7
      axes(ax1)
      xline(events_exe(cont,1),'--k','Linewidth',1.2);
      axes(ax2)
      xline(events_exe(cont,1),'--k','Linewidth',1.2);
      axes(ax3)
      xline(events_exe(cont,1),'--k','Linewidth',1.2);
      axes(ax5)
      xline(events_exe(cont,1),'--k','Linewidth',1.2);
      axes(ax7)
      xline(events_exe(cont,1),'--k','Linewidth',1.2);
  end
       

