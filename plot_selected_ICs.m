
function plot_selected_ICs(data_folder,file2load, w2load, selected_ICs,x_ini,x_end)

% Plot selected ICs, does not include activation map plotting   
% file2load corresponds to the previously subsampled data.
% w2load corresponds to the unmixing matrix obtained from ICA
% selected_ICs corresponds to the set of selected ICs, maximum can be 196.
% x_ini= lower limit of the time axis
%x_end= upper limit of the time axis

aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)                                                    % Subsampled and merged data

aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                   % Load unmixing matrix
Data=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering

%% Apply unmixing matrix
ICA_comps=W*Data;
fs=Data_all.fs;
events_exe=Data_all.events_exe;
incomplete_evs=Data_all.incomplete_events;
 %% Plot Object Presentation component
 pp=0.5;                    %Percentaje of data to plot
 time=(1:pp*length(Data))/fs;         %time axis
  
figure('Position',[10 60 560 780]);
 ej1=subplot('Position',[0.12 0.83  0.75 0.12]);
 comp=selected_ICs(1);
 plot(time,-ICA_comps(comp,1:numel(time)),'Linewidth',1.3);
 findpeaks(-ICA_comps(comp,1:numel(time)),fs,'MinPeakHeight',std(ICA_comps(comp,1:numel(time)))*3,'MinPeakDistance',2)
 
 for cont=1:size(events_exe,1)
      xline(events_exe(cont,1),'Linewidth',1.2,'Color','green');            % object marker from executed movements
      text(events_exe(cont,1)+0.1,-5,'Object','Color','green');
 end
  inc_obj=incomplete_evs.object;
  for cont=1:numel(inc_obj)
      xline(inc_obj(cont),'Linewidth',1.2,'Color','red');        % object marker from observed movements
  end
yline(std(ICA_comps(comp,1:numel(time)))*3,'Linewidth',1.2,'Color','black','LineStyle','--');
text(0,6,'mean+3STD')
ej1.XAxis.Visible = 'off';
ej1.YAxis.Visible = 'off';
box off
grid off
xlim([x_ini x_end])

%% Plot Grip component
ej2=subplot('Position',[0.12 0.70  0.75 0.12]);
comp=selected_ICs(2);
plot(time,ICA_comps(comp,1:numel(time)),'Linewidth',1.3);
findpeaks(ICA_comps(comp,1:numel(time)),fs,'MinPeakHeight',std(ICA_comps(comp,1:numel(time)))*3,'MinPeakDistance',2)
 
 for cont=1:size(events_exe,1)
      xline(events_exe(cont,2),'Linewidth',1.2,'Color','red');            % object marker from executed movements
      text(events_exe(cont,2)+0.1,-5,'Grip Cue','Color','red')
 end
  inc_grip=incomplete_evs.grip;
  for cont=1:numel(inc_grip)
      xline(inc_grip(cont),'Linewidth',1.2,'Color','red');        % object marker from observed movements
  end
yline(std(ICA_comps(comp,1:numel(time)))*3,'Linewidth',1.2,'Color','black','LineStyle','--');
ej2.XAxis.Visible = 'off';
ej2.YAxis.Visible = 'off';
box off
grid off
xlim([x_ini x_end])

%% GO
ej3=subplot('Position',[0.12 0.57  0.75 0.12]);
comp=selected_ICs(3);
plot(time,-ICA_comps(comp,1:numel(time)),'Linewidth',1.3);
findpeaks(-ICA_comps(comp,1:numel(time)),fs,'MinPeakHeight',std(ICA_comps(comp,1:numel(time)))*3,'MinPeakDistance',2)
 
 for cont=1:size(events_exe,1)
      xline(events_exe(cont,3),'Linewidth',1.2,'Color','blue');            % object marker from executed movements
      text(events_exe(cont,3)+0.1,-5,'Go Cue','Color','blue')
 end
  inc_go=incomplete_evs.go;
  for cont=1:numel(inc_go)
      xline(inc_go(cont),'Linewidth',1.2,'Color','red');        % object marker from observed movements
  end
ej3.XAxis.Visible = 'off';
ej3.YAxis.Visible = 'off';
yline(std(ICA_comps(comp,1:numel(time)))*3,'Linewidth',1.2,'Color','black','LineStyle','--');
box off
grid off
xlim([x_ini x_end])

%% Start
comp=selected_ICs(4);
 ej4=subplot('Position',[0.12 0.44  0.75 0.12]);
 plot(time,ICA_comps(comp,1:numel(time)),'Linewidth',1.3);
 findpeaks(ICA_comps(comp,1:numel(time)),fs,'MinPeakHeight',std(ICA_comps(comp,1:numel(time)))*3,'MinPeakDistance',2)
 
 for cont=1:size(events_exe,1)
      xline(events_exe(cont,4),'Linewidth',1.2,'Color','magenta');            % object marker from executed movements
      text(events_exe(cont,4)+0.1,-5,'StartMov','Color','magenta')
 end
  inc_start=incomplete_evs.start;
  for cont=1:numel(inc_start)
      xline(inc_start(cont),'Linewidth',1.2,'Color','red');        % object marker from observed movements
  end
  ylim([-10 20])
  yline(std(ICA_comps(comp,1:numel(time)))*3,'Linewidth',1.2,'Color','black','LineStyle','--');
  ej4.XAxis.Visible = 'off';
  ej4.YAxis.Visible = 'off';
  box off
  grid off
xlim([x_ini x_end])
     
%% Contact & Begin
comp=selected_ICs(5);
 ej5=subplot('Position',[0.12 0.31  0.75 0.12]);
 plot(time,ICA_comps(comp,1:numel(time)),'Linewidth',1.3);
 findpeaks(ICA_comps(comp,1:numel(time)),fs,'MinPeakHeight',std(ICA_comps(comp,1:numel(time)))*3,'MinPeakDistance',2)
 
 for cont=1:size(events_exe,1)
      xline(events_exe(cont,5),'Linewidth',1.2,'Color',[0.4660 0.6740 0.1880]);            % object marker from executed movements
      text(events_exe(cont,5)+0.1,-5,'Contact','Color',[0.4660 0.6740 0.1880]);
 end
  inc_contact=incomplete_evs.contact;
  for cont=1:numel(inc_contact)
      xline(inc_contact(cont),'Linewidth',1.2,'Color','red');        % object marker from observed movements
  end
yline(std(ICA_comps(comp,1:numel(time)))*3,'Linewidth',1.2,'Color','black','LineStyle','--');
ej5.XAxis.Visible = 'off';
ej5.YAxis.Visible = 'off';
box off
grid off
xlim([x_ini x_end])

%% End Lift
comp=selected_ICs(6);
 ej6=subplot('Position',[0.12 0.18  0.75 0.12]);
 plot(time,-ICA_comps(comp,1:numel(time)),'Linewidth',1.3);
 findpeaks(-ICA_comps(comp,1:numel(time)),fs,'MinPeakHeight',std(-ICA_comps(comp,1:numel(time)))*3,'MinPeakDistance',2)
 
 for cont=1:size(events_exe,1)
      xline(events_exe(cont,7),'Linewidth',1.2,'Color',[0.8500 0.3250 0.0980]);            % object marker from executed movements
      text(events_exe(cont,7)+0.1,-5,'EndLift','Color',[0.8500 0.3250 0.0980])
 end
  inc_end=incomplete_evs.end;
  for cont=1:numel(inc_end)
      xline(inc_end(cont),'Linewidth',1.2,'Color','red');        % object marker from observed movements
  end
xlabel('time (s)')
yline(std(ICA_comps(comp,1:numel(time)))*3,'Linewidth',1.2,'Color','black','LineStyle','--');
xlim([x_ini x_end])
ej6.XAxis.Visible = 'off'; ej6.YAxis.Visible = 'off';
box off grid off

%% Reward
comp=selected_ICs(7);;
 ej7=subplot('Position',[0.12 0.05  0.75 0.12]);
 plot(time,-ICA_comps(comp,1:numel(time)),'Linewidth',1.3);
 findpeaks(-ICA_comps(comp,1:numel(time)),fs,'MinPeakHeight',std(-ICA_comps(comp,1:numel(time)))*3,'MinPeakDistance',2)
 
 for cont=1:size(events_exe,1)
      xline(events_exe(cont,8),'Linewidth',1.2,'Color',[0.9290, 0.6940, 0.1250]);            % object marker from executed movements
      text(events_exe(cont,8)+0.1,-5,'Reward','Color',[0.9290, 0.6940, 0.1250])
 end

xlabel('time (s)')
yline(std(ICA_comps(comp,1:numel(time)))*3,'Linewidth',1.2,'Color','black','LineStyle','--');
xlim([x_ini x_end])
ej7.YAxis.Visible = 'off';
box off
grid off

linkaxes([ej1 ej2 ej3 ej4 ej5 ej6 ej7], 'x'); 








