
clear all

data_folder=pwd;
figure('Position',[10 150 1000 680])
e3=subplot('Position',[0.06 0.71 0.25 0.22]);
e2=subplot('Position',[0.06 0.39 0.25 0.22]);
e1=subplot('Position',[0.06 0.07 0.25 0.22]);

e4=subplot('Position',[0.37 0.71 0.25 0.22]);
e5=subplot('Position',[0.37 0.39 0.25 0.22]);
e6=subplot('Position',[0.37 0.07 0.25 0.22]);

e7=subplot('Position',[0.69 0.6 0.25 0.28]);
e8=subplot('Position',[0.69 0.15 0.25 0.28]);


%% SPK object
aux=dir(strcat(data_folder,'\**\','class_obj_spk121001.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
obj_spk_s1=load(full_w2load); 

aux=dir(strcat(data_folder,'\**\','class_obj_spk121003.mat'));
full_file2load=strcat(aux.folder,'\',aux.name);
obj_spk_s2=load(full_file2load);

aux=dir(strcat(data_folder,'\**\','class_obj_spk121004.mat'));
full_file2load=strcat(aux.folder,'\',aux.name);
obj_spk_s3=load(full_file2load);

aux=dir(strcat(data_folder,'\**\','class_obj_spk121005.mat'));
full_file2load=strcat(aux.folder,'\',aux.name);
obj_spk_s4=load(full_file2load);

aux=dir(strcat(data_folder,'\**\','class_obj_spk121107.mat'));
full_file2load=strcat(aux.folder,'\',aux.name);
obj_spk_s5=load(full_file2load);

obj_1p_s1=obj_spk_s1.obj_classification.accuracy_p1;
obj_1p_s2=obj_spk_s2.obj_classification.accuracy_p1;
obj_1p_s3=obj_spk_s3.obj_classification.accuracy_p1;
obj_1p_s4=obj_spk_s4.obj_classification.accuracy_p1;
obj_1p_s5=obj_spk_s5.obj_classification.accuracy_p1;

obj_2p_s1=obj_spk_s1.obj_classification.accuracy_p2;
obj_2p_s2=obj_spk_s2.obj_classification.accuracy_p2;
obj_2p_s3=obj_spk_s3.obj_classification.accuracy_p2;
obj_2p_s4=obj_spk_s4.obj_classification.accuracy_p2;
obj_2p_s5=obj_spk_s5.obj_classification.accuracy_p2;

obj_1p_all=[obj_1p_s1 obj_1p_s2 obj_1p_s3 obj_1p_s4 obj_1p_s5];
obj_1p_mean=mean(obj_1p_all,2)';
obj_1p_std=std(obj_1p_all');

obj_2p_all=[obj_2p_s1 obj_2p_s2 obj_2p_s3 obj_2p_s4 obj_2p_s5];
obj_2p_mean=mean(obj_2p_all,2)';
obj_2p_std=std(obj_2p_all');

obj_ch_s1=obj_spk_s1.obj_classification.chance;
obj_ch_s2=obj_spk_s2.obj_classification.chance;
obj_ch_s3=obj_spk_s3.obj_classification.chance;
obj_ch_s4=obj_spk_s4.obj_classification.chance;
obj_ch_s5=obj_spk_s5.obj_classification.chance;

obj_ch_all=[obj_ch_s1 obj_ch_s2 obj_ch_s3 obj_ch_s4 obj_ch_s5];
obj_ch_mean=mean(mean(obj_ch_all,2));
obj_ch_std=mean(std(obj_ch_all'));

t1=linspace(-1,3,numel(obj_1p_mean));
t2=linspace(-1,3,numel(obj_2p_mean));

axes(e3)
plot(t1,obj_1p_mean,'r','LineWidth',1.6); hold on;
plot(t1,obj_1p_mean-obj_1p_std,'Color',[175/256 54/256 60/256]);
plot(t1,obj_1p_mean+obj_1p_std,'Color',[175/256 54/256 60/256]);

plot(t2+5,obj_2p_mean,'r','LineWidth',1.6);
plot(t2+5,obj_2p_mean-obj_2p_std,'Color',[175/256 54/256 60/256]);
plot(t2+5,obj_2p_mean+obj_2p_std,'Color',[175/256 54/256 60/256]);

x = [-1  8];
y1 = [obj_ch_mean+obj_ch_std obj_ch_mean+obj_ch_std];
y2 = [obj_ch_mean-obj_ch_std obj_ch_mean-obj_ch_std];
y = [y1; (y2-y1)]'; 
ho1 = area(x, y);
set(ho1(2), 'FaceColor', [122/255,122/255,121/255])
set(ho1(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ho1, 'LineStyle', 'none')
set(ho1, 'FaceAlpha', 0.2)
yline(obj_ch_mean,'Color','k')

xline(0,'Linewidth',1.2,'Color','k');
xline(1,'Linewidth',1.2,'Color','k');
xline(3,'Linewidth',1.2,'Color','k');
xline(5,'Linewidth',1.2,'Color','k');
ylabel('% correct');
ylim([20 100])
xlim([-1 8])
xticks([-1 0 1 2 3 4 5 6 7 8])
xticklabels({'-1','0','1','2','3','-1','0','1','2','3'})

[~,b]=max(mean(obj_2p_s1,2));
pred_2p_s1=obj_spk_s1.obj_classification.pred_importance_p2(b,:);
pred_2p_s1=pred_2p_s1/max(pred_2p_s1);
[~,b]=max(mean(obj_2p_s2,2));
pred_2p_s2=obj_spk_s2.obj_classification.pred_importance_p2(b,:);
pred_2p_s2=pred_2p_s2/max(pred_2p_s2);
[~,b]=max(mean(obj_2p_s3,2));
pred_2p_s3=obj_spk_s3.obj_classification.pred_importance_p2(b,:);
pred_2p_s3=pred_2p_s3/max(pred_2p_s3);
[~,b]=max(mean(obj_2p_s4,2));
pred_2p_s4=obj_spk_s4.obj_classification.pred_importance_p2(b,:);
pred_2p_s4=pred_2p_s4/max(pred_2p_s4);
[~,b]=max(mean(obj_2p_s5,2));
pred_2p_s5=obj_spk_s5.obj_classification.pred_importance_p2(b,:);
pred_2p_s5=pred_2p_s5/max(pred_2p_s5);
pred_importance_obj_spk=[pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5];


clear vars obj_spk_s1 obj_spk_s2 obj_spk_s3 obj_spk_s4 obj_spk_s5
clear vars obj_1p_s1 obj_1p_s2 obj_1p_s3 obj_1p_s4 obj_1p_s5
clear vars obj_2p_s1 obj_2p_s2 obj_2p_s3 obj_2p_s4 obj_2p_s5
clear vars obj_ch_s1 obj_ch_s2 obj_ch_s3 obj_ch_s4 obj_ch_s5
clear vars obj_1p_all obj_2p_all obj_ch_all
clear vars obj_1p_mean obj_2p_mean obj_1p_std obj_2p_std
clear vars obj_ch_mean obj_ch_std
clear vars pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5

%% SPK Grip TC
aux=dir(strcat(data_folder,'\**\','class_TC_grip_spk121001.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
TC_spk_s1=load(full_w2load); 

aux=dir(strcat(data_folder,'\**\','class_TC_grip_spk121003.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
TC_spk_s2=load(full_w2load); 

aux=dir(strcat(data_folder,'\**\','class_TC_grip_spk121004.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
TC_spk_s3=load(full_w2load); 

aux=dir(strcat(data_folder,'\**\','class_TC_grip_spk121005.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
TC_spk_s4=load(full_w2load); 

aux=dir(strcat(data_folder,'\**\','class_TC_grip_spk121107.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
TC_spk_s5=load(full_w2load); 

tc_1p_s1=TC_spk_s1.grip_classification.accuracy_p1;
tc_1p_s2=TC_spk_s2.grip_classification.accuracy_p1;
tc_1p_s3=TC_spk_s3.grip_classification.accuracy_p1;
tc_1p_s4=TC_spk_s4.grip_classification.accuracy_p1;
tc_1p_s5=TC_spk_s5.grip_classification.accuracy_p1;

tc_2p_s1=TC_spk_s1.grip_classification.accuracy_p2;
tc_2p_s2=TC_spk_s2.grip_classification.accuracy_p2;
tc_2p_s3=TC_spk_s3.grip_classification.accuracy_p2;
tc_2p_s4=TC_spk_s4.grip_classification.accuracy_p2;
tc_2p_s5=TC_spk_s5.grip_classification.accuracy_p2;

tc_ch_s1=TC_spk_s1.grip_classification.chance;
tc_ch_s2=TC_spk_s2.grip_classification.chance;
tc_ch_s3=TC_spk_s3.grip_classification.chance;
tc_ch_s4=TC_spk_s4.grip_classification.chance;
tc_ch_s5=TC_spk_s5.grip_classification.chance;

tc_1p_all=[tc_1p_s1 tc_1p_s2 tc_1p_s3 tc_1p_s4 tc_1p_s5];
tc_1p_mean=mean(tc_1p_all,2)';
tc_1p_std=std(tc_1p_all');

tc_2p_all=[tc_2p_s1 tc_2p_s2 tc_2p_s3 tc_2p_s4 tc_2p_s5];
tc_2p_mean=mean(tc_2p_all,2)';
tc_2p_std=std(tc_2p_all');

tc_ch_all=[tc_ch_s1 tc_ch_s2 tc_ch_s3 tc_ch_s4 tc_ch_s5];
tc_ch_mean=mean(mean(tc_ch_all,2));
tc_ch_std=mean(std(tc_ch_all'));

axes(e2)
plot(t1,tc_1p_mean,'b','LineWidth',1.6); hold on;
plot(t1,tc_1p_mean-tc_1p_std,'Color',[0 0.6 0.8]);
plot(t1,tc_1p_mean+tc_1p_std,'Color',[0 0.6 0.8]);

plot(t2+5,tc_2p_mean,'b','LineWidth',1.6);
plot(t2+5,tc_2p_mean-tc_2p_std,'Color',[0 0.6 0.8]);
plot(t2+5,tc_2p_mean+tc_2p_std,'Color',[0 0.6 0.8]);

x = [-1  8];
y1 = [tc_ch_mean+tc_ch_std tc_ch_mean+tc_ch_std];
y2 = [tc_ch_mean-tc_ch_std tc_ch_mean-tc_ch_std];
y = [y1; (y2-y1)]'; 
ho1 = area(x, y);
set(ho1(2), 'FaceColor', [122/255,122/255,121/255])
set(ho1(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ho1, 'LineStyle', 'none')
set(ho1, 'FaceAlpha', 0.2)
yline(tc_ch_mean,'Color','k')

xline(0,'Linewidth',1.2,'Color','k');
xline(1,'Linewidth',1.2,'Color','k');
xline(3,'Linewidth',1.2,'Color','k');
xline(5,'Linewidth',1.2,'Color','k');
ylabel('% correct');
ylim([20 100])
xlim([-1 8])
xticks([-1 0 1 2 3 4 5 6 7 8])
xticklabels({'-1','0','1','2','3','-1','0','1','2','3'})

[~,b]=max(mean(tc_2p_s1,2));
pred_2p_s1=TC_spk_s1.grip_classification.pred_importance_p2(b,:);
pred_2p_s1=pred_2p_s1/max(pred_2p_s1);
[~,b]=max(mean(tc_2p_s2,2));
pred_2p_s2=TC_spk_s2.grip_classification.pred_importance_p2(b,:);
pred_2p_s2=pred_2p_s2/max(pred_2p_s2);
[~,b]=max(mean(tc_2p_s3,2));
pred_2p_s3=TC_spk_s3.grip_classification.pred_importance_p2(b,:);
pred_2p_s3=pred_2p_s3/max(pred_2p_s3);
[~,b]=max(mean(tc_2p_s4,2));
pred_2p_s4=TC_spk_s4.grip_classification.pred_importance_p2(b,:);
pred_2p_s4=pred_2p_s4/max(pred_2p_s4);
[~,b]=max(mean(tc_2p_s5,2));
pred_2p_s5=TC_spk_s5.grip_classification.pred_importance_p2(b,:);
pred_2p_s5=pred_2p_s5/max(pred_2p_s5);
pred_importance_tc_spk=[pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5];

clear vars TC_spk_s1 TC_spk_s2 TC_spk_s3 TC_spk_s4 TC_spk_s5
clear vars tc_1p_s1 tc_1p_s2 tc_1p_s3 tc_1p_s4 tc_1p_s5
clear vars tc_2p_s1 tc_2p_s2 tc_2p_s3 tc_2p_s4 tc_2p_s5
clear vars tc_ch_s1 tc_ch_s2 tc_ch_s3 tc_ch_s4 tc_ch_s5
clear vars tc_1p_all tc_2p_all tc_ch_all
clear vars tc_1p_mean tc_2p_mean tc_1p_std tc_2p_std
clear vars tc_ch_mean tc_ch_std
clear vars pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5

%% SPK Grip KG
aux=dir(strcat(data_folder,'\**\','class_KG_grip_spk121001.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
KG_spk_s1=load(full_w2load); 

aux=dir(strcat(data_folder,'\**\','class_KG_grip_spk121003.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
KG_spk_s2=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_KG_grip_spk121004.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
KG_spk_s3=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_KG_grip_spk121005.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
KG_spk_s4=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_KG_grip_spk121107.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
KG_spk_s5=load(full_w2load);

kg_1p_s1=KG_spk_s1.grip_classification.accuracy_p1;
kg_1p_s2=KG_spk_s2.grip_classification.accuracy_p1;
kg_1p_s3=KG_spk_s3.grip_classification.accuracy_p1;
kg_1p_s4=KG_spk_s4.grip_classification.accuracy_p1;
kg_1p_s5=KG_spk_s5.grip_classification.accuracy_p1;

kg_2p_s1=KG_spk_s1.grip_classification.accuracy_p2;
kg_2p_s2=KG_spk_s2.grip_classification.accuracy_p2;
kg_2p_s3=KG_spk_s3.grip_classification.accuracy_p2;
kg_2p_s4=KG_spk_s4.grip_classification.accuracy_p2;
kg_2p_s5=KG_spk_s5.grip_classification.accuracy_p2;

kg_ch_s1=KG_spk_s1.grip_classification.chance;
kg_ch_s2=KG_spk_s2.grip_classification.chance;
kg_ch_s3=KG_spk_s3.grip_classification.chance;
kg_ch_s4=KG_spk_s4.grip_classification.chance;
kg_ch_s5=KG_spk_s5.grip_classification.chance;

kg_1p_all=[kg_1p_s1 kg_1p_s2 kg_1p_s3 kg_1p_s4 kg_1p_s5];
kg_1p_mean=mean(kg_1p_all,2)';
kg_1p_std=std(kg_1p_all');

kg_2p_all=[kg_2p_s1 kg_2p_s2 kg_2p_s3 kg_2p_s4 kg_2p_s5];
kg_2p_mean=mean(kg_2p_all,2)';
kg_2p_std=std(kg_2p_all');

kg_ch_all=[kg_ch_s1 kg_ch_s2 kg_ch_s3 kg_ch_s4 kg_ch_s5];
kg_ch_mean=mean(mean(kg_ch_all,2));
kg_ch_std=mean(std(kg_ch_all'));

axes(e1)
plot(t1,kg_1p_mean,'g','LineWidth',1.6); hold on;
plot(t1,kg_1p_mean-kg_1p_std,'Color',[0 0.8 0]);
plot(t1,kg_1p_mean+kg_1p_std,'Color',[0 0.8 0]);

plot(t2+5,kg_2p_mean,'g','LineWidth',1.6);
plot(t2+5,kg_2p_mean-kg_2p_std,'Color',[0 0.8 0]);
plot(t2+5,kg_2p_mean+kg_2p_std,'Color',[0 0.8 0]);

x = [-1  8];
y1 = [kg_ch_mean+kg_ch_std kg_ch_mean+kg_ch_std];
y2 = [kg_ch_mean-kg_ch_std kg_ch_mean-kg_ch_std];
y = [y1; (y2-y1)]'; 
ho1 = area(x, y);
set(ho1(2), 'FaceColor', [122/255,122/255,121/255])
set(ho1(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ho1, 'LineStyle', 'none')
set(ho1, 'FaceAlpha', 0.2)
yline(kg_ch_mean,'Color','k')

xline(0,'Linewidth',1.2,'Color','k');
xline(1,'Linewidth',1.2,'Color','k');
xline(3,'Linewidth',1.2,'Color','k');
xline(5,'Linewidth',1.2,'Color','k');
ylabel('% correct');
ylim([20 100])
xlim([-1 8])
xticks([-1 0 1 2 3 4 5 6 7 8])
xticklabels({'-1','0','1','2','3','-1','0','1','2','3'})
xlabel('time (s)')

[~,b]=max(mean(kg_2p_s1,2));
pred_2p_s1=KG_spk_s1.grip_classification.pred_importance_p2(b,:);
pred_2p_s1=pred_2p_s1/max(pred_2p_s1);
[~,b]=max(mean(kg_2p_s2,2));
pred_2p_s2=KG_spk_s2.grip_classification.pred_importance_p2(b,:);
pred_2p_s2=pred_2p_s2/max(pred_2p_s2);
[~,b]=max(mean(kg_2p_s3,2));
pred_2p_s3=KG_spk_s3.grip_classification.pred_importance_p2(b,:);
pred_2p_s3=pred_2p_s3/max(pred_2p_s3);
[~,b]=max(mean(kg_2p_s4,2));
pred_2p_s4=KG_spk_s4.grip_classification.pred_importance_p2(b,:);
pred_2p_s4=pred_2p_s4/max(pred_2p_s4);
[~,b]=max(mean(kg_2p_s5,2));
pred_2p_s5=KG_spk_s5.grip_classification.pred_importance_p2(b,:);
pred_2p_s5=pred_2p_s5/max(pred_2p_s5);
pred_importance_kg_spk=[pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5];

clear vars KG_spk_s1 KG_spk_s2 KG_spk_s3 KG_spk_s4 KG_spk_s5
clear vars kg_1p_s1 kg_1p_s2 kg_1p_s3 kg_1p_s4 kg_1p_s5
clear vars kg_2p_s1 kg_2p_s2 kg_2p_s3 kg_2p_s4 kg_2p_s5
clear vars kg_ch_s1 kg_ch_s2 kg_ch_s3 kg_ch_s4 kg_ch_s5
clear vars kg_1p_all kg_2p_all kg_ch_all
clear vars kg_1p_mean kg_2p_mean kg_1p_std kg_2p_std
clear vars kg_ch_mean kg_ch_std
clear vars pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5 pred_importance

pred_imp_spk=[pred_importance_obj_spk pred_importance_tc_spk pred_importance_kg_spk];

axes(e7)
histogram(pred_imp_spk,50)
xlabel('Predictor Importance')
title('Monkey S, Predictor Importance')

%% RUS object
aux=dir(strcat(data_folder,'\**\','class_obj_rus120618.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
obj_rus_s1=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_obj_rus120619.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
obj_rus_s2=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_obj_rus120622.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
obj_rus_s3=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_obj_rus120627.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
obj_rus_s4=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_obj_rus120702.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
obj_rus_s5=load(full_w2load);

obj_1p_s1=obj_rus_s1.obj_classification.accuracy_p1;
obj_1p_s2=obj_rus_s2.obj_classification.accuracy_p1;
obj_1p_s3=obj_rus_s3.obj_classification.accuracy_p1;
obj_1p_s4=obj_rus_s4.obj_classification.accuracy_p1;
obj_1p_s5=obj_rus_s5.obj_classification.accuracy_p1;

obj_2p_s1=obj_rus_s1.obj_classification.accuracy_p2;
obj_2p_s2=obj_rus_s2.obj_classification.accuracy_p2;
obj_2p_s3=obj_rus_s3.obj_classification.accuracy_p2;
obj_2p_s4=obj_rus_s4.obj_classification.accuracy_p2;
obj_2p_s5=obj_rus_s5.obj_classification.accuracy_p2;

obj_1p_all=[obj_1p_s1 obj_1p_s2 obj_1p_s3 obj_1p_s4 obj_1p_s5];
obj_1p_mean=mean(obj_1p_all,2)';
obj_1p_std=std(obj_1p_all');

obj_2p_all=[obj_2p_s1 obj_2p_s2 obj_2p_s3 obj_2p_s4 obj_2p_s5];
obj_2p_mean=mean(obj_2p_all,2)';
obj_2p_std=std(obj_2p_all');

obj_ch_s1=obj_rus_s1.obj_classification.chance;
obj_ch_s2=obj_rus_s2.obj_classification.chance;
obj_ch_s3=obj_rus_s3.obj_classification.chance;
obj_ch_s4=obj_rus_s4.obj_classification.chance;
obj_ch_s5=obj_rus_s5.obj_classification.chance;

obj_ch_all=[obj_ch_s1 obj_ch_s2 obj_ch_s3 obj_ch_s4 obj_ch_s5];
obj_ch_mean=mean(mean(obj_ch_all,2));
obj_ch_std=mean(std(obj_ch_all'));

t1=linspace(-1,3,numel(obj_1p_mean));
t2=linspace(-1,3,numel(obj_2p_mean));

axes(e4)
plot(t1,obj_1p_mean,'r','LineWidth',1.6); hold on;
plot(t1,obj_1p_mean-obj_1p_std,'Color',[175/256 54/256 60/256]);
plot(t1,obj_1p_mean+obj_1p_std,'Color',[175/256 54/256 60/256]);

plot(t2+5,obj_2p_mean,'r','LineWidth',1.6);
plot(t2+5,obj_2p_mean-obj_2p_std,'Color',[175/256 54/256 60/256]);
plot(t2+5,obj_2p_mean+obj_2p_std,'Color',[175/256 54/256 60/256]);

x = [-1  8];
y1 = [obj_ch_mean+obj_ch_std obj_ch_mean+obj_ch_std];
y2 = [obj_ch_mean-obj_ch_std obj_ch_mean-obj_ch_std];
y = [y1; (y2-y1)]'; 
ho1 = area(x, y);
set(ho1(2), 'FaceColor', [122/255,122/255,121/255])
set(ho1(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ho1, 'LineStyle', 'none')
set(ho1, 'FaceAlpha', 0.2)
yline(obj_ch_mean,'Color','k')

xline(0,'Linewidth',1.2,'Color','k');
xline(1,'Linewidth',1.2,'Color','k');
xline(3,'Linewidth',1.2,'Color','k');
xline(5,'Linewidth',1.2,'Color','k');
ylabel('% correct');
ylim([20 100])
xlim([-1 8])
xticks([-1 0 1 2 3 4 5 6 7 8])
xticklabels({'-1','0','1','2','3','-1','0','1','2','3'})

[~,b]=max(mean(obj_2p_s1,2));
pred_2p_s1=obj_rus_s1.obj_classification.pred_importance_p2(b,:);
pred_2p_s1=pred_2p_s1/max(pred_2p_s1);
[~,b]=max(mean(obj_2p_s2,2));
pred_2p_s2=obj_rus_s2.obj_classification.pred_importance_p2(b,:);
pred_2p_s2=pred_2p_s2/max(pred_2p_s2);
[~,b]=max(mean(obj_2p_s3,2));
pred_2p_s3=obj_rus_s3.obj_classification.pred_importance_p2(b,:);
pred_2p_s3=pred_2p_s3/max(pred_2p_s3);
[~,b]=max(mean(obj_2p_s4,2));
pred_2p_s4=obj_rus_s4.obj_classification.pred_importance_p2(b,:);
pred_2p_s4=pred_2p_s4/max(pred_2p_s4);
[~,b]=max(mean(obj_2p_s5,2));
pred_2p_s5=obj_rus_s5.obj_classification.pred_importance_p2(b,:);
pred_2p_s5=pred_2p_s5/max(pred_2p_s5);
pred_importance_obj_rus=[pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5];

clear vars obj_rus_s1 obj_rus_s2 obj_rus_s3 obj_rus_s4 obj_rus_s5
clear vars obj_1p_s1 obj_1p_s2 obj_1p_s3 obj_1p_s4 obj_1p_s5
clear vars obj_2p_s1 obj_2p_s2 obj_2p_s3 obj_2p_s4 obj_2p_s5
clear vars obj_ch_s1 obj_ch_s2 obj_ch_s3 obj_ch_s4 obj_ch_s5
clear vars obj_1p_all obj_2p_all obj_ch_all
clear vars obj_1p_mean obj_2p_mean obj_1p_std obj_2p_std
clear vars obj_ch_mean obj_ch_std
clear vars pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5 pred_importance

%% RUS GRIP TC
aux=dir(strcat(data_folder,'\**\','class_TC_grip_rus120618.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
TC_rus_s1=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_TC_grip_rus120619.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
TC_rus_s2=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_TC_grip_rus120622.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
TC_rus_s3=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_TC_grip_rus120627.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
TC_rus_s4=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_TC_grip_rus120702.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
TC_rus_s5=load(full_w2load);

tc_1p_s1=TC_rus_s1.grip_classification.accuracy_p1;
tc_1p_s2=TC_rus_s2.grip_classification.accuracy_p1;
tc_1p_s3=TC_rus_s3.grip_classification.accuracy_p1;
tc_1p_s4=TC_rus_s4.grip_classification.accuracy_p1;
tc_1p_s5=TC_rus_s5.grip_classification.accuracy_p1;

tc_2p_s1=TC_rus_s1.grip_classification.accuracy_p2;
tc_2p_s2=TC_rus_s2.grip_classification.accuracy_p2;
tc_2p_s3=TC_rus_s3.grip_classification.accuracy_p2;
tc_2p_s4=TC_rus_s4.grip_classification.accuracy_p2;
tc_2p_s5=TC_rus_s5.grip_classification.accuracy_p2;

tc_ch_s1=TC_rus_s1.grip_classification.chance;
tc_ch_s2=TC_rus_s2.grip_classification.chance;
tc_ch_s3=TC_rus_s3.grip_classification.chance;
tc_ch_s4=TC_rus_s4.grip_classification.chance;
tc_ch_s5=TC_rus_s5.grip_classification.chance;

tc_1p_all=[tc_1p_s1 tc_1p_s2 tc_1p_s3 tc_1p_s4 tc_1p_s5];
tc_1p_mean=mean(tc_1p_all,2)';
tc_1p_std=std(tc_1p_all');

tc_2p_all=[tc_2p_s1 tc_2p_s2 tc_2p_s3 tc_2p_s4 tc_2p_s5];
tc_2p_mean=mean(tc_2p_all,2)';
tc_2p_std=std(tc_2p_all');

tc_ch_all=[tc_ch_s1 tc_ch_s2 tc_ch_s3 tc_ch_s4 tc_ch_s5];
tc_ch_mean=mean(mean(tc_ch_all,2));
tc_ch_std=mean(std(tc_ch_all'));

axes(e5)
plot(t1,tc_1p_mean,'b','LineWidth',1.6); hold on;
plot(t1,tc_1p_mean-tc_1p_std,'Color',[0 0.6 0.8]);
plot(t1,tc_1p_mean+tc_1p_std,'Color',[0 0.6 0.8]);

plot(t2+5,tc_2p_mean,'b','LineWidth',1.6);
plot(t2+5,tc_2p_mean-tc_2p_std,'Color',[0 0.6 0.8]);
plot(t2+5,tc_2p_mean+tc_2p_std,'Color',[0 0.6 0.8]);

x = [-1  8];
y1 = [tc_ch_mean+tc_ch_std tc_ch_mean+tc_ch_std];
y2 = [tc_ch_mean-tc_ch_std tc_ch_mean-tc_ch_std];
y = [y1; (y2-y1)]'; 
ho1 = area(x, y);
set(ho1(2), 'FaceColor', [122/255,122/255,121/255])
set(ho1(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ho1, 'LineStyle', 'none')
set(ho1, 'FaceAlpha', 0.2)
yline(tc_ch_mean,'Color','k')

xline(0,'Linewidth',1.2,'Color','k');
xline(1,'Linewidth',1.2,'Color','k');
xline(3,'Linewidth',1.2,'Color','k');
xline(5,'Linewidth',1.2,'Color','k');
ylabel('% correct');
ylim([20 100])
xlim([-1 8])
xticks([-1 0 1 2 3 4 5 6 7 8])
xticklabels({'-1','0','1','2','3','-1','0','1','2','3'})

[~,b]=max(mean(tc_2p_s1,2));
pred_2p_s1=TC_rus_s1.grip_classification.pred_importance_p2(b,:);
pred_2p_s1=pred_2p_s1/max(pred_2p_s1);
[~,b]=max(mean(tc_2p_s2,2));
pred_2p_s2=TC_rus_s2.grip_classification.pred_importance_p2(b,:);
pred_2p_s2=pred_2p_s2/max(pred_2p_s2);
[~,b]=max(mean(tc_2p_s3,2));
pred_2p_s3=TC_rus_s3.grip_classification.pred_importance_p2(b,:);
pred_2p_s3=pred_2p_s3/max(pred_2p_s3);
[~,b]=max(mean(tc_2p_s4,2));
pred_2p_s4=TC_rus_s4.grip_classification.pred_importance_p2(b,:);
pred_2p_s4=pred_2p_s4/max(pred_2p_s4);
[~,b]=max(mean(tc_2p_s5,2));
pred_2p_s5=TC_rus_s5.grip_classification.pred_importance_p2(b,:);
pred_2p_s5=pred_2p_s5/max(pred_2p_s5);
pred_importance_tc_rus=[pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5];

clear vars TC_rus_s1 TC_rus_s2 TC_rus_s3 TC_rus_s4 TC_rus_s5
clear vars tc_1p_s1 tc_1p_s2 tc_1p_s3 tc_1p_s4 tc_1p_s5
clear vars tc_2p_s1 tc_2p_s2 tc_2p_s3 tc_2p_s4 tc_2p_s5
clear vars tc_ch_s1 tc_ch_s2 tc_ch_s3 tc_ch_s4 tc_ch_s5
clear vars tc_1p_all tc_2p_all tc_ch_all
clear vars tc_1p_mean tc_2p_mean tc_1p_std tc_2p_std
clear vars tc_ch_mean tc_ch_std
clear vars pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5 pred_importance

%% RUS Grip KG
aux=dir(strcat(data_folder,'\**\','class_KG_grip_rus120618.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
KG_rus_s1=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_KG_grip_rus120619.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
KG_rus_s2=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_KG_grip_rus120622.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
KG_rus_s3=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_KG_grip_rus120627.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
KG_rus_s4=load(full_w2load);

aux=dir(strcat(data_folder,'\**\','class_KG_grip_rus120702.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
KG_rus_s5=load(full_w2load);

kg_1p_s1=KG_rus_s1.grip_classification.accuracy_p1;
kg_1p_s2=KG_rus_s2.grip_classification.accuracy_p1;
kg_1p_s3=KG_rus_s3.grip_classification.accuracy_p1;
kg_1p_s4=KG_rus_s4.grip_classification.accuracy_p1;
kg_1p_s5=KG_rus_s5.grip_classification.accuracy_p1;

kg_2p_s1=KG_rus_s1.grip_classification.accuracy_p2;
kg_2p_s2=KG_rus_s2.grip_classification.accuracy_p2;
kg_2p_s3=KG_rus_s3.grip_classification.accuracy_p2;
kg_2p_s4=KG_rus_s4.grip_classification.accuracy_p2;
kg_2p_s5=KG_rus_s5.grip_classification.accuracy_p2;

kg_ch_s1=KG_rus_s1.grip_classification.chance;
kg_ch_s2=KG_rus_s2.grip_classification.chance;
kg_ch_s3=KG_rus_s3.grip_classification.chance;
kg_ch_s4=KG_rus_s4.grip_classification.chance;
kg_ch_s5=KG_rus_s5.grip_classification.chance;

kg_1p_all=[kg_1p_s1 kg_1p_s2 kg_1p_s3 kg_1p_s4 kg_1p_s5];
kg_1p_mean=mean(kg_1p_all,2)';
kg_1p_std=std(kg_1p_all');

kg_2p_all=[kg_2p_s1 kg_2p_s2 kg_2p_s3 kg_2p_s4 kg_2p_s5];
kg_2p_mean=mean(kg_2p_all,2)';
kg_2p_std=std(kg_2p_all');

kg_ch_all=[kg_ch_s1 kg_ch_s2 kg_ch_s3 kg_ch_s4 kg_ch_s5];
kg_ch_mean=mean(mean(kg_ch_all,2));
kg_ch_std=mean(std(kg_ch_all'));

axes(e6)
plot(t1,kg_1p_mean,'g','LineWidth',1.6); hold on;
plot(t1,kg_1p_mean-kg_1p_std,'Color',[0 0.8 0]);
plot(t1,kg_1p_mean+kg_1p_std,'Color',[0 0.8 0]);

plot(t2+5,kg_2p_mean,'g','LineWidth',1.6);
plot(t2+5,kg_2p_mean-kg_2p_std,'Color',[0 0.8 0]);
plot(t2+5,kg_2p_mean+kg_2p_std,'Color',[0 0.8 0]);

x = [-1  8];
y1 = [kg_ch_mean+kg_ch_std kg_ch_mean+kg_ch_std];
y2 = [kg_ch_mean-kg_ch_std kg_ch_mean-kg_ch_std];
y = [y1; (y2-y1)]'; 
ho1 = area(x, y);
set(ho1(2), 'FaceColor', [122/255,122/255,121/255])
set(ho1(1), 'FaceColor', 'none') % this makes the bottom area invisible
set(ho1, 'LineStyle', 'none')
set(ho1, 'FaceAlpha', 0.2)
yline(kg_ch_mean,'Color','k')

xline(0,'Linewidth',1.2,'Color','k');
xline(1,'Linewidth',1.2,'Color','k');
xline(3,'Linewidth',1.2,'Color','k');
xline(5,'Linewidth',1.2,'Color','k');
ylabel('% correct');
ylim([20 100])
xlim([-1 8])
xticks([-1 0 1 2 3 4 5 6 7 8])
xticklabels({'-1','0','1','2','3','-1','0','1','2','3'})
xlabel('time (s)')

[~,b]=max(mean(kg_2p_s1,2));
pred_2p_s1=KG_rus_s1.grip_classification.pred_importance_p2(b,:);
pred_2p_s1=pred_2p_s1/max(pred_2p_s1);
[~,b]=max(mean(kg_2p_s2,2));
pred_2p_s2=KG_rus_s2.grip_classification.pred_importance_p2(b,:);
pred_2p_s2=pred_2p_s2/max(pred_2p_s2);
[~,b]=max(mean(kg_2p_s3,2));
pred_2p_s3=KG_rus_s3.grip_classification.pred_importance_p2(b,:);
pred_2p_s3=pred_2p_s3/max(pred_2p_s3);
[~,b]=max(mean(kg_2p_s4,2));
pred_2p_s4=KG_rus_s4.grip_classification.pred_importance_p2(b,:);
pred_2p_s4=pred_2p_s4/max(pred_2p_s4);
[~,b]=max(mean(kg_2p_s5,2));
pred_2p_s5=KG_rus_s5.grip_classification.pred_importance_p2(b,:);
pred_2p_s5=pred_2p_s5/max(pred_2p_s5);
pred_importance_kg_rus=[pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5];

pred_imp_rus=[pred_importance_obj_rus pred_importance_tc_rus pred_importance_kg_rus];
axes(e8)
histogram(pred_imp_rus,50)
xlabel('Predictor Importance')
title('Monkey R, Predictor Importance')


clear vars KG_rus_s1 KG_rus_s2 KG_rus_s3 KG_rus_s4 KG_rus_s5
clear vars kg_1p_s1 kg_1p_s2 kg_1p_s3 kg_1p_s4 kg_1p_s5
clear vars kg_2p_s1 kg_2p_s2 kg_2p_s3 kg_2p_s4 kg_2p_s5
clear vars kg_ch_s1 kg_ch_s2 kg_ch_s3 kg_ch_s4 kg_ch_s5
clear vars kg_1p_all kg_2p_all kg_ch_all
clear vars kg_1p_mean kg_2p_mean kg_1p_std kg_2p_std
clear vars kg_ch_mean kg_ch_std
clear vars pred_2p_s1 pred_2p_s2 pred_2p_s3 pred_2p_s4 pred_2p_s5 pred_importance
