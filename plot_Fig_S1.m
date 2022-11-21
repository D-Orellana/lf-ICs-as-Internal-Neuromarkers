
clear all
data_folder=pwd;

figure('Position',[400 40 800 940]);
e1=subplot('Position',[0.1 0.7 0.38 0.27]);
e2=subplot('Position',[0.1 0.38 0.38 0.27]);
e3=subplot('Position',[0.1 0.06 0.38 0.27]);
e4=subplot('Position',[0.55 0.7 0.38 0.27]);
e5=subplot('Position',[0.55 0.38 0.38 0.27]);
e6=subplot('Position',[0.55 0.06 0.38 0.27]);

file2load='stg_detect_res_SPK121001.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)     
axes(e1)
plot(FPR',TPR','LineWidth',1.5);
title('ROC  Stage Detection - SPK Session 1' )
legend('Object','Grip','Go','Start','Begin Lift','End Lift','Reward','Location','southeast');

file2load='stg_detect_res_SPK121004.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)     
axes(e2)
plot(FPR',TPR','LineWidth',1.5);
title('ROC  Stage Detection - SPK Session 3' )
legend('Object','Grip','Go','Start','Begin Lift','End Lift','Reward','Location','southeast');

file2load='stg_detect_res_SPK121107.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)     
axes(e3)
plot(FPR',TPR','LineWidth',1.5);
title('ROC  Stage Detection - SPK Session 5' )
legend('Object','Grip','Go','Start','Begin Lift','End Lift','Reward','Location','southeast');

file2load='stg_detect_res_RUS120618.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)     
axes(e4)
plot(FPR',TPR','LineWidth',1.5);
title('ROC  Stage Detection - RUS Session 1' )
legend('Object','Grip','Go','Start','Begin Lift','End Lift','Reward','Location','southeast');

file2load='stg_detect_res_RUS120622.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)     
axes(e5)
plot(FPR',TPR','LineWidth',1.5);
title('ROC  Stage Detection - RUS Session 3' )
legend('Object','Grip','Go','Start','Begin Lift','End Lift','Reward','Location','southeast');

file2load='stg_detect_res_RUS120702.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)     
axes(e6)
plot(FPR',TPR','LineWidth',1.5);
title('ROC  Stage Detection - RUS Session 5' )
legend('Object','Grip','Go','Start','Begin Lift','End Lift','Reward','Location','southeast');
