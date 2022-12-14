
clear all
data_folder=pwd;

file2load='SPK_121001_FR_diff_obj.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_obj=FR_dif;

file2load='SPK_121003_FR_diff_obj.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_obj=[FR_obj; FR_dif];

file2load='SPK_121004_FR_diff_obj.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_obj=[FR_obj; FR_dif];

file2load='SPK_121005_FR_diff_obj.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_obj=[FR_obj; FR_dif];

file2load='SPK_121107_FR_diff_obj.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_obj=[FR_obj; FR_dif];

file2load='SPK_121001_FR_diff_grip.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_grip=FR_dif;

file2load='SPK_121003_FR_diff_grip.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_grip=[FR_grip; FR_dif];

file2load='SPK_121004_FR_diff_grip.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_grip=[FR_grip; FR_dif];

file2load='SPK_121005_FR_diff_grip.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_grip=[FR_grip; FR_dif];

file2load='SPK_121107_FR_diff_grip.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_grip=[FR_grip; FR_dif];

file2load='SPK_121001_FR_diff_go.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_go=FR_dif;

file2load='SPK_121003_FR_diff_go.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_go=[FR_go; FR_dif];

file2load='SPK_121004_FR_diff_go.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_go=[FR_go; FR_dif];

file2load='SPK_121005_FR_diff_go.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_go=[FR_go; FR_dif];

file2load='SPK_121107_FR_diff_go.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_go=[FR_go; FR_dif];

file2load='SPK_121001_FR_diff_start.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_start=FR_dif;

file2load='SPK_121003_FR_diff_start.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_start=[FR_start; FR_dif];

file2load='SPK_121004_FR_diff_start.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_start=[FR_start; FR_dif];

file2load='SPK_121005_FR_diff_start.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_start=[FR_start; FR_dif];

file2load='SPK_121107_FR_diff_start.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_start=[FR_start; FR_dif];


figure('Position',[180 77 700 800])
    e1=subplot('Position',[0.1 0.58 0.8 0.37]);
    e2=subplot('Position',[0.1 0.09 0.8 0.37]);

axes(e1)
violin_v3(100*FR_obj,[1 1.1],'facecolor',[0/255 171/255 169/255;0 1 0;.3 .3 .3;0 0.3 0.1],'edgecolor','k','bw',2.2)
hold on
violin_v3(100*FR_grip,[2 2.1],'facecolor',[240/255 163/255 10/255;0 1 0;.3 .3 .3;0 0.3 0.1],'edgecolor','k','bw',2.2)
violin_v3(100*FR_go,[3 3.1],'facecolor',[100/255 118/255 135/255;0 1 0;.3 .3 .3;0 0.3 0.1],'edgecolor','k','bw',2.2)
violin_v3(100*FR_start,[4 4.1],'facecolor',[0/255 80/255 239/255;0 1 0;.3 .3 .3;0 0.3 0.1],'edgecolor','k','bw',2.2)
xlim([0 5])
ylim([-25 50])

xticks([1 2 3 4])
xticklabels({'Obj\_P','Grip\_C','Go\_C','Start\_M'})
ylabel('alignment improvement (%)')
grid on

clear vars FR_obj FR_grip FR_go FR_start  FR_dif 

%% Rusty
file2load='RUS_120618_FR_diff_obj.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_obj=FR_dif;

file2load='RUS_120619_FR_diff_obj.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_obj=[FR_obj; FR_dif];

file2load='RUS_120622_FR_diff_obj.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_obj=[FR_obj; FR_dif];

file2load='RUS_120627_FR_diff_obj.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_obj=[FR_obj; FR_dif];

file2load='RUS_120702_FR_diff_obj.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_obj=[FR_obj; FR_dif];

file2load='RUS_120618_FR_diff_grip.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_grip=FR_dif;

file2load='RUS_120619_FR_diff_grip.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_grip=[FR_grip; FR_dif];

file2load='RUS_120622_FR_diff_grip.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_grip=[FR_grip; FR_dif];

file2load='RUS_120627_FR_diff_grip.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_grip=[FR_grip; FR_dif];

file2load='RUS_120702_FR_diff_grip.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_grip=[FR_grip; FR_dif];

file2load='RUS_120618_FR_diff_go.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_go=FR_dif;

file2load='RUS_120619_FR_diff_go.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_go=[FR_go; FR_dif];

file2load='RUS_120622_FR_diff_go.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_go=[FR_go; FR_dif];

file2load='RUS_120627_FR_diff_go.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_go=[FR_go; FR_dif];

file2load='RUS_120702_FR_diff_go.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_go=[FR_go; FR_dif];

file2load='RUS_120618_FR_diff_start.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_start=FR_dif;

file2load='RUS_120619_FR_diff_start.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_start=[FR_start; FR_dif];

file2load='RUS_120622_FR_diff_start.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_start=[FR_start; FR_dif];

file2load='RUS_120627_FR_diff_start.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_start=[FR_start; FR_dif];

file2load='RUS_120702_FR_diff_start.mat';
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
FR_start=[FR_start; FR_dif];

axes(e2)
violin_v3(100*FR_obj,[1 1.1],'facecolor',[0/255 171/255 169/255;0 1 0;.3 .3 .3;0 0.3 0.1],'edgecolor','k','bw',2.2)
hold on
violin_v3(100*FR_grip,[2 2.1],'facecolor',[240/255 163/255 10/255;0 1 0;.3 .3 .3;0 0.3 0.1],'edgecolor','k','bw',2.2)
violin_v3(100*FR_go,[3 3.1],'facecolor',[100/255 118/255 135/255;0 1 0;.3 .3 .3;0 0.3 0.1],'edgecolor','k','bw',2.2)
violin_v3(100*FR_start,[4 4.1],'facecolor',[0/255 80/255 239/255;0 1 0;.3 .3 .3;0 0.3 0.1],'edgecolor','k','bw',2.2)
xlim([0 5])
ylim([-25 100])

xticks([1 2 3 4])
xticklabels({'Obj\_P','Grip\_C','Go\_C','Start\_M'})
ylabel('alignment improvement (%)')
grid on
