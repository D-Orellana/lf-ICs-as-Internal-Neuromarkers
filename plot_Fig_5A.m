
clear all
data_folder=pwd;
p=99;
CIFcn = @(x,p)prctile(x,abs([0,100]-(100-p)/2));

figure('Position',[100 100 1200 700])
ax1=subplot('Position',[0.05 0.17  0.24 0.32]);
ax2=subplot('Position',[0.05 0.55  0.24 0.32]);
ax3=subplot('Position',[0.31 0.28  0.34 0.5]);
ax4=subplot('Position',[0.66 0.17  0.24 0.32]);

load('coords_SPK.mat');
coords=[coord_MI_PMd ; coord_PMv];

aux=dir(strcat(data_folder,'\**\','W_ICA_SPK121001.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 

comps=[5 101 20 3 13 16 4]; 
W_1=W(comps,:);

s1=5;

PMd=[6 56 13 91 21 14 64 24,...
            9 55 19 92 62 16 61 26,...
           17 89 54 10 60 20 63 28,...
           15 90 52 12 59 27 96 30,...
           50 8 58 23 94 29 18 32,...
           46 11 57 25 93 31 22 95];

MI=[5 48 42 44 51 53 87 88,...
    40 43 47 49 86 85 4 7,...
    45 82 84 83 3 34 36 38,...
    81 2 1 33 35 37 39 41,...
    66 68 70 72 74 76 78 80,...
    65 67 69 71 73 75 77 79];

W_PMv=mean(abs(W_1(s1,97:192)));
W_PMd=mean(abs(W_1(s1,PMd)));
W_MI=mean(abs(W_1(s1,MI)));

for k=1:100000
    v=randperm(192);
    W_s=W_1(:,v);
    W_PMv_mc(k)=mean(abs(W_s(s1,97:192)));
    W_PMd_mc(k)=mean(abs(W_s(s1,PMd)));
    W_MI_mc(k)=mean(abs(W_s(s1,MI)));
end

    CI = CIFcn(W_PMv_mc,p);
    li_PMv=CI(1);
    lu_PMv=CI(2);

    CI = CIFcn(W_PMd_mc,p);
    li_PMd=CI(1);
    lu_PMd=CI(2);
    
	CI = CIFcn(W_MI_mc,p);
	li_MI=CI(1);
    lu_MI=CI(2);

%% Plot PMv
N=80;
axes(ax1)
CT=cbrewer('seq', 'OrRd', N);
[counts, bins]=hist(W_PMv_mc,N);
hold on;
xlim([0.0055 0.015])
ylim([0 4500 ])
xticks([])
yticks([])
axis off
for k=1:N
    c=k;
    bar(bins(k),counts(k),0.0068/50,'FaceColor',CT(c,:),'EdgeColor',[214/255 126/255 44/255])
end
%set(gca,'view',[0 -90])
xline(W_PMv,'color','g','LineWidth',3);
xline(li_PMv,'--b','Linewidth',2,'HandleVisibility','off');
xline(lu_PMv,'--b','Linewidth',2);
text (li_PMv,-5,'')
%% Plot PMd
axes(ax2)
CT=cbrewer('seq', 'OrRd', N);
[counts, bins]=hist(W_PMd_mc,N);
hold on;
xlim([0.0029 0.0188])
ylim([0 4500 ])
xticks([])
yticks([])
axis off

for k=1:N
    c=k;
    bar(bins(k),counts(k),0.0068/28,'FaceColor',CT(c,:),'EdgeColor',[214/255 126/255 44/255])
end
%set(gca,'view',[0 -90])
xline(W_PMd,'color','g','LineWidth',3);
xline(li_PMd,'--b','Linewidth',2,'HandleVisibility','off');
xline(lu_PMd,'--b','Linewidth',2);

%% Plot MI
axes(ax4)
%CT=cbrewer('div', 'RdGy', 110);
CT=cbrewer('seq', 'OrRd', N);
[counts, bins]=hist(W_MI_mc,N);
hold on;
xlim([0.0032 0.021 ])
ylim([0 4500 ])
xticks([])
yticks([])
axis off
for k=1:N
    c=k;
    bar(bins(k),counts(k),0.0068/28,'FaceColor',CT(c,:),'EdgeColor',[214/255 126/255 44/255])
end
%set(gca,'view',[0 -90])
xline(W_MI,'color','g','LineWidth',3);
xline(li_MI,'--b','Linewidth',2,'HandleVisibility','off');
xline(lu_MI,'--b','Linewidth',2);

%% PLot Map
axes(ax3)
aux_comp=abs(W_1(s1,:));
aux_comp_norm=(aux_comp-min(aux_comp))/(max(aux_comp)-min(aux_comp));
scatter(coords(:,1),coords(:,2),70,aux_comp_norm,'filled')
set(gca,'View', [0,-90]);
%text (300,600,'IC-1','Color','red','Fontsize',13,'FontWeight','bold');
text (30,1050,'PMv')
text (750,780,'MI')
text (530,150,'PMd')
axis off
