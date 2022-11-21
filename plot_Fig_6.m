
clear all
data_folder=pwd;
figure('Position',[100 100 1700 650])
ax1=subplot('Position',[0.1 0.15  0.35 0.8]);
ax2=subplot('Position',[0.55 0.15  0.35 0.8]);

aux=dir(strcat(data_folder,'\**\','W_ICA_SPK121001.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[5 101 20 3 13 16 4]; 
W_spk(:,:,1)=W(comps,:);

aux=dir(strcat(data_folder,'\**\','W_ICA_SPK121003.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[13 36 18 2 19 25 5];
W_spk(:,:,2)=W(comps,:);

aux=dir(strcat(data_folder,'\**\','W_ICA_SPK121004.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[13 38 17 3 21 14 4];
W_spk(:,:,3)=W(comps,:);

aux=dir(strcat(data_folder,'\**\','W_ICA_SPK121005.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[27 32 23 5 22 31 17];
W_spk(:,:,4)=W(comps,:);

aux=dir(strcat(data_folder,'\**\','W_ICA_SPK121107.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[7 26 17 24 21 59 32] ;
W_spk(:,:,5)=W(comps,:);

l1=0;
 for stg1=1:7
        for r1=1:5
            l1=l1+1;
            l2=0;
            for stg2=1:7
                for r2=1:5
                    l2=l2+1;
                    if (r1==r2) && (stg1==stg2)
                        Crr(l1,l2)=1;%NaN;
                    else
                        ic1=(W_spk(stg1,:,r1));
                        ic1n=(ic1-min(ic1))/(max(ic1)-min(ic1));
                        ic2=(W_spk(stg2,:,r2));
                        ic2n=(ic2-min(ic2))/(max(ic2)-min(ic2));
                        temp=corrcoef(ic1n,ic2n);
                        Crr(l1,l2)=abs(temp(1,2));
                    end
            end
        end
    end
end

%figure('Name','1','Position',[1000 200 800 650]);
axes(ax1)
imagesc(Crr);
colorbar
colormap(winter)
 xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35]);
 xticklabels({'S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5'})
 xtickangle(90)
 yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35]);
 yticklabels({'S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5'})
 tit=strcat('Monkey S');
 title(tit)

 %% Cuadricula
 yline(5.5,'--w');       xline(5.5,'--w');
yline(10.5,'--w');      xline(10.5,'--w');
yline(15.5,'--w');      xline(15.5,'--w');
yline(20.5,'--w');      xline(20.5,'--w');
yline(25.5,'--w');      xline(25.5,'--w');
yline(30.5,'--w');      xline(30.5,'--w');

%% Lineas al costado
x1=0.075;
x2=0.085;
y1=0.837;
y2=0.95;
annotation('line',[x2 x1],[y2 y2]);
annotation('line',[x2 x1],[y1 y1]);
annotation('line',[x1 x1],[y1 y2]);

for k=1:6
    y1=y1-0.115;
    y2=y2-0.115;
    annotation('line',[x2 x1],[y2 y2]);
    annotation('line',[x2 x1],[y1 y1]);
    annotation('line',[x1 x1],[y1 y2]);
end

%% Nombres lateral
text(-6       ,2.4,'Obj\_P','Color','green','FontWeight','bold','FontSize',10)
text(-6       ,7.4,'Grip\_C','Color','red','FontWeight','bold','FontSize',10)
text(-6  ,12.4,'Go\_C','Color','blue','FontWeight','bold','FontSize',10)
text(-6     ,17.4,'Start\_M','Color','magenta','FontWeight','bold','FontSize',10)
text(-6     ,22.4,'Begin\_L','Color',[0.4660 0.6740 0.1880],'FontWeight','bold','FontSize',10)
text(-6     ,27.4,'End\_L','Color',[0.8500 0.3250 0.0980],'FontWeight','bold','FontSize',10)
text(-6    ,32.4,'Rwd','Color',[0.9290, 0.6940, 0.1250],'FontWeight','bold','FontSize',10)
%% Lineas abajo
x1=0.1;
x2=0.14;
y1=0.09;
y2=0.11;
annotation('line',[x1 x1],[y1 y2]);
annotation('line',[x2 x2],[y1 y2]);
annotation('line',[x1 x2],[y1 y1]);

for k=1:6
    x1=x1+0.0455;
    x2=x2+0.0455;
    annotation('line',[x1 x1],[y1 y2]);
    annotation('line',[x2 x2],[y1 y2]);
    annotation('line',[x1 x2],[y1 y1]);
end

%% Nombres abajo
text(1.5,   38.8,'Obj\_P','Color','green','FontWeight','bold','FontSize',11)
text(6.5,   38.8,'Grip\_C','Color','red','FontWeight','bold','FontSize',11)
text(11.5, 38.8,'Go\_C','Color','blue','FontWeight','bold','FontSize',11)
text(16,    38.8,'Start\_M','Color','magenta','FontWeight','bold','FontSize',11)
text(21.2,   38.8,'Begin\_L','Color',[0.4660 0.6740 0.1880],'FontWeight','bold','FontSize',11)
text(26.5,   38.8,'End\_L','Color',[0.8500 0.3250 0.0980],'FontWeight','bold','FontSize',11)
text(32,   38.8,'Rwd','Color',[0.9290, 0.6940, 0.1250],'FontWeight','bold','FontSize',11)

%% RUSTY

aux=dir(strcat(data_folder,'\**\','W_ICA_RUS120618.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[7 11 2 4 5 16 21];
W_rus(:,:,1)=W(comps,:);

aux=dir(strcat(data_folder,'\**\','W_ICA_RUS120619.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[12 6 5 3 8 11 44];
W_rus(:,:,2)=W(comps,:);

aux=dir(strcat(data_folder,'\**\','W_ICA_RUS120622.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[7 12 6 10 11 23 26];
W_rus(:,:,3)=W(comps,:);

aux=dir(strcat(data_folder,'\**\','W_ICA_RUS120627.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[20 9 6 8 10 17 50];
W_rus(:,:,4)=W(comps,:);

aux=dir(strcat(data_folder,'\**\','W_ICA_RUS120702.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 

comps=[16 8 14 11 13 27 38]; 
W_rus(:,:,5)=W(comps,:);


l1=0;
 for stg1=1:7
        for r1=1:5
            l1=l1+1;
            l2=0;
            for stg2=1:7
                for r2=1:5
                    l2=l2+1;
                    if (r1==r2) && (stg1==stg2)
                        Crr(l1,l2)=1;%NaN;
                    else
                        ic1=(W_rus(stg1,:,r1));
                        ic1n=(ic1-min(ic1))/(max(ic1)-min(ic1));
                        ic2=(W_rus(stg2,:,r2));
                        ic2n=(ic2-min(ic2))/(max(ic2)-min(ic2));
                        temp=corrcoef(ic1n,ic2n);
                        Crr(l1,l2)=abs(temp(1,2));
                    end
            end
        end
    end
end

axes(ax2)
imagesc(Crr);
colorbar
colormap(winter)
 xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35]);
 xticklabels({'S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5'})
 xtickangle(90)
 yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35]);
 yticklabels({'S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5','S1','S2','S3','S4','S5'})
 tit=strcat('Monkey R');
 title(tit)

 %% Cuadricula
 yline(5.5,'--w');       xline(5.5,'--w');
yline(10.5,'--w');      xline(10.5,'--w');
yline(15.5,'--w');      xline(15.5,'--w');
yline(20.5,'--w');      xline(20.5,'--w');
yline(25.5,'--w');      xline(25.5,'--w');
yline(30.5,'--w');      xline(30.5,'--w');

%% Lineas al costado
x1=0.525;
x2=0.535;
y1=0.837;
y2=0.95;
annotation('line',[x2 x1],[y2 y2]);
annotation('line',[x2 x1],[y1 y1]);
annotation('line',[x1 x1],[y1 y2]);

for k=1:6
    y1=y1-0.115;
    y2=y2-0.115;
    annotation('line',[x2 x1],[y2 y2]);
    annotation('line',[x2 x1],[y1 y1]);
    annotation('line',[x1 x1],[y1 y2]);
end


%% Nombres lateral
text(-6       ,2.4,'Obj\_P','Color','green','FontWeight','bold','FontSize',10)
text(-6       ,7.4,'Grip\_C','Color','red','FontWeight','bold','FontSize',10)
text(-6  ,12.4,'Go\_C','Color','blue','FontWeight','bold','FontSize',10)
text(-6     ,17.4,'Start\_M','Color','magenta','FontWeight','bold','FontSize',10)
text(-6     ,22.4,'Begin\_L','Color',[0.4660 0.6740 0.1880],'FontWeight','bold','FontSize',10)
text(-6     ,27.4,'End\_L','Color',[0.8500 0.3250 0.0980],'FontWeight','bold','FontSize',10)
text(-6    ,32.4,'Rwd','Color',[0.9290, 0.6940, 0.1250],'FontWeight','bold','FontSize',10)
%% Lineas abajo
x1=0.55;
x2=0.59;
y1=0.09;
y2=0.11;
annotation('line',[x1 x1],[y1 y2]);
annotation('line',[x2 x2],[y1 y2]);
annotation('line',[x1 x2],[y1 y1]);

for k=1:6
    x1=x1+0.0455;
    x2=x2+0.0455;
    annotation('line',[x1 x1],[y1 y2]);
    annotation('line',[x2 x2],[y1 y2]);
    annotation('line',[x1 x2],[y1 y1]);
end

%% Nombres abajo
text(1.5,   38.8,'Obj\_P','Color','green','FontWeight','bold','FontSize',11)
text(6.5,   38.8,'Grip\_C','Color','red','FontWeight','bold','FontSize',11)
text(11.5, 38.8,'Go\_C','Color','blue','FontWeight','bold','FontSize',11)
text(16,    38.8,'Start\_M','Color','magenta','FontWeight','bold','FontSize',11)
text(21.2,   38.8,'Begin\_L','Color',[0.4660 0.6740 0.1880],'FontWeight','bold','FontSize',11)
text(26.5,   38.8,'End\_L','Color',[0.8500 0.3250 0.0980],'FontWeight','bold','FontSize',11)
text(32,   38.8,'Rwd','Color',[0.9290, 0.6940, 0.1250],'FontWeight','bold','FontSize',11)



