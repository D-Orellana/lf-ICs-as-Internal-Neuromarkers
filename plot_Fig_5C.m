

clear all
data_folder=pwd;
p=99;
CIFcn = @(x,p)prctile(x,abs([0,100]-(100-p)/2));

load('coords_SPK.mat');
coords=[coord_MI_PMd ; coord_PMv];
clear vars  coord_MI_PMd coord_PMv fc1 fc2 W_sort

load('coords_RUS.mat');
coords=[coord_MI_PMd ; coord_PMv];
clear vars  coord_MI_PMd coord_PMv fc1 fc2 W_sort

aux=dir(strcat(data_folder,'\**\','W_ICA_RUS120618.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[7 11 2 4 5 16 21];
W_all(:,:,1)=W(comps,:);
clear vars  fc1 fc2 W_sort W

aux=dir(strcat(data_folder,'\**\','W_ICA_RUS120619.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[12 6 5 3 8 11 44];
W_all(:,:,2)=W(comps,:);
clear vars  fc1 fc2 W_sort W

aux=dir(strcat(data_folder,'\**\','W_ICA_RUS120622.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[7 12 6 10 11 23 26];
W_all(:,:,3)=W(comps,:);
clear vars  fc1 fc2 W_sort W

aux=dir(strcat(data_folder,'\**\','W_ICA_RUS120627.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[20 14 6 8 10 17 50];
W_all(:,:,4)=W(comps,:);
clear vars  fc1 fc2 W_sort W

aux=dir(strcat(data_folder,'\**\','W_ICA_RUS120702.mat'));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load); 
comps=[16 8 14 11 13 27 38]; 
W_all(:,:,5)=W(comps,:);
clear vars  fc1 fc2 W_sort W


PMd=[6,8:32,46,50,52,54:64,89:96];
MI=[1:5,7,33:45,47,48,49,51,53,65:88];

%% OBJECT
W_obj=squeeze(W_all(1,:,:));
W_obj=zscore(W_obj);

% Obtener la media real en cada region
W_PMv_real_obj=mean(abs(W_obj(97:192,:)));
W_PMd_real_obj=mean(abs(W_obj(PMd,:)));
W_MI_real_obj=mean(abs(W_obj(MI,:)));

%Obtener distribuciones
for k2=1:5
    for k=1:100000
        v=randperm(192);
        W_ran=W_obj(v,k2);                % W randomized  
        W_PMv_dist_obj(k2,k)=mean(abs(W_ran(97:192,1)));
        W_PMd_dist_obj(k2,k)=mean(abs(W_ran(PMd,1)));
        W_MI_dist_obj(k2,k)=mean(abs(W_ran(MI,1)));
    end
end

% Obtener limites de confianza
for k=1:5
    CI = CIFcn(W_PMv_dist_obj(k,:)',p);
    li_PMv_obj(k)=CI(1);
    lu_PMv_obj(k)=CI(2);

    CI = CIFcn(W_PMd_dist_obj(k,:)',p);
    li_PMd_obj(k)=CI(1);
    lu_PMd_obj(k)=CI(2);
    
	CI = CIFcn(W_MI_dist_obj(k,:)',p);
	li_MI_obj(k)=CI(1);
    lu_MI_obj(k)=CI(2);
end
li_PMv_obj
lu_PMv_obj
W_PMv_real_obj

li_PMv_avg=mean(li_PMv_obj);
lu_PMv_avg=mean(lu_PMv_obj);

% Obtener distancias en PMv
dsup_PMv_obj=[];
dinf_PMv_obj=[];
dmed_PMv_obj=[];
for k=1:5
    if W_PMv_real_obj(k)>lu_PMv_obj(k)
        dsup_PMv_obj=[dsup_PMv_obj W_PMv_real_obj(k)-lu_PMv_obj(k)];
    end
	if W_PMv_real_obj(k)<li_PMv_obj(k)
        dinf_PMv_obj=[dinf_PMv_obj li_PMv_obj(k)-W_PMv_real_obj(k)];
    end
    if W_PMv_real_obj(k)>li_PMv_obj(k) && W_PMv_real_obj(k)<lu_PMv_obj(k)
        dmed_PMv_obj=[dmed_PMv_obj W_PMv_real_obj(k)-li_PMv_obj(k)];
    end
end
dsup_PMv_obj
dinf_PMv_obj
dmed_PMv_obj

% Obtener distancias en PMd
li_PMd_obj
lu_PMd_obj
W_PMd_real_obj
dsup_PMd_obj=[];
dinf_PMd_obj=[];
dmed_PMd_obj=[];
for k=1:5
    if W_PMd_real_obj(k)>lu_PMd_obj(k)
        dsup_PMd_obj=[dsup_PMd_obj W_PMd_real_obj(k)-lu_PMd_obj(k)];
    end
	if W_PMd_real_obj(k)<li_PMd_obj(k)
        dinf_PMd_obj=[dinf_PMd_obj li_PMd_obj(k)-W_PMd_real_obj(k)];
    end
    if W_PMd_real_obj(k)>li_PMd_obj(k) && W_PMd_real_obj(k)<lu_PMd_obj(k)
        dmed_PMd_obj=[dmed_PMd_obj W_PMd_real_obj(k)-li_PMd_obj(k)];
    end
end
dsup_PMd_obj
dinf_PMd_obj
dmed_PMd_obj

% Obtener distancias en MI
li_MI_obj
lu_MI_obj
W_MI_real_obj
dsup_MI_obj=[];
dinf_MI_obj=[];
dmed_MI_obj=[];
for k=1:5
    if W_MI_real_obj(k)>lu_MI_obj(k)
        dsup_MI_obj=[dsup_MI_obj W_MI_real_obj(k)-lu_MI_obj(k)];
    end
	if W_MI_real_obj(k)<li_MI_obj(k)
        dinf_MI_obj=[dinf_MI_obj li_MI_obj(k)-W_MI_real_obj(k)];
    end
    if W_MI_real_obj(k)>li_MI_obj(k) && W_MI_real_obj(k)<lu_MI_obj(k)
        dmed_MI_obj=[dmed_MI_obj W_MI_real_obj(k)-li_MI_obj(k)];
    end
end
dsup_MI_obj
dinf_MI_obj
dmed_MI_obj

%% GRIP
W_grip=squeeze(W_all(2,:,:));
W_grip=zscore(W_grip);

% Obtener la media real en cada region
W_PMv_real_grip=mean(abs(W_grip(97:192,:)));
W_PMd_real_grip=mean(abs(W_grip(PMd,:)));
W_MI_real_grip=mean(abs(W_grip(MI,:)));

%Obtener distribuciones
for k2=1:5
    for k=1:100000
        v=randperm(192);
        W_ran=W_grip(v,k2);                % W randomized  
        W_PMv_dist_grip(k2,k)=mean(abs(W_ran(97:192,1)));
        W_PMd_dist_grip(k2,k)=mean(abs(W_ran(PMd,1)));
        W_MI_dist_grip(k2,k)=mean(abs(W_ran(MI,1)));
    end
end

% Obtener limites de confianza
for k=1:5
    CI = CIFcn(W_PMv_dist_grip(k,:)',p);
    li_PMv_grip(k)=CI(1);
    lu_PMv_grip(k)=CI(2);

    CI = CIFcn(W_PMd_dist_grip(k,:)',p);
    li_PMd_grip(k)=CI(1);
    lu_PMd_grip(k)=CI(2);
    
	CI = CIFcn(W_MI_dist_grip(k,:)',p);
	li_MI_grip(k)=CI(1);
    lu_MI_grip(k)=CI(2);
end
li_PMv_grip
lu_PMv_grip
W_PMv_real_grip

li_PMv_avg=mean(li_PMv_grip);
lu_PMv_avg=mean(lu_PMv_grip);

% Obtener distancias en PMv
dsup_PMv_grip=[];
dinf_PMv_grip=[];
dmed_PMv_grip=[];
for k=1:5
    if W_PMv_real_grip(k)>lu_PMv_grip(k)
        dsup_PMv_grip=[dsup_PMv_grip W_PMv_real_grip(k)-lu_PMv_grip(k)];
    end
	if W_PMv_real_grip(k)<li_PMv_grip(k)
        dinf_PMv_grip=[dinf_PMv_grip li_PMv_grip(k)-W_PMv_real_grip(k)];
    end
    if W_PMv_real_grip(k)>li_PMv_grip(k) && W_PMv_real_grip(k)<lu_PMv_grip(k)
        dmed_PMv_grip=[dmed_PMv_grip W_PMv_real_grip(k)-li_PMv_grip(k)];
    end
end
dsup_PMv_grip
dinf_PMv_grip
dmed_PMv_grip

% Obtener distancias en PMd
li_PMd_grip
lu_PMd_grip
W_PMd_real_grip
dsup_PMd_grip=[];
dinf_PMd_grip=[];
dmed_PMd_grip=[];
for k=1:5
    if W_PMd_real_grip(k)>lu_PMd_grip(k)
        dsup_PMd_grip=[dsup_PMd_grip W_PMd_real_grip(k)-lu_PMd_grip(k)];
    end
	if W_PMd_real_grip(k)<li_PMd_grip(k)
        dinf_PMd_grip=[dinf_PMd_grip li_PMd_grip(k)-W_PMd_real_grip(k)];
    end
    if W_PMd_real_grip(k)>li_PMd_grip(k) && W_PMd_real_grip(k)<lu_PMd_grip(k)
        dmed_PMd_grip=[dmed_PMd_grip W_PMd_real_grip(k)-li_PMd_grip(k)];
    end
end
dsup_PMd_grip
dinf_PMd_grip
dmed_PMd_grip

% Obtener distancias en MI
li_MI_grip
lu_MI_grip
W_MI_real_grip
dsup_MI_grip=[];
dinf_MI_grip=[];
dmed_MI_grip=[];
for k=1:5
    if W_MI_real_grip(k)>lu_MI_grip(k)
        dsup_MI_grip=[dsup_MI_grip W_MI_real_grip(k)-lu_MI_grip(k)];
    end
	if W_MI_real_grip(k)<li_MI_grip(k)
        dinf_MI_grip=[dinf_MI_grip li_MI_grip(k)-W_MI_real_grip(k)];
    end
    if W_MI_real_grip(k)>li_MI_grip(k) && W_MI_real_grip(k)<lu_MI_grip(k)
        dmed_MI_grip=[dmed_MI_grip W_MI_real_grip(k)-li_MI_grip(k)];
    end
end
dsup_MI_grip
dinf_MI_grip
dmed_MI_grip

%% GO
W_go=squeeze(W_all(3,:,:));
W_go=zscore(W_go);

% Obtener la media real en cada region
W_PMv_real_go=mean(abs(W_go(97:192,:)));
W_PMd_real_go=mean(abs(W_go(PMd,:)));
W_MI_real_go=mean(abs(W_go(MI,:)));

%Obtener distribuciones
for k2=1:5
    for k=1:100000
        v=randperm(192);
        W_ran=W_go(v,k2);                % W randomized  
        W_PMv_dist_go(k2,k)=mean(abs(W_ran(97:192,1)));
        W_PMd_dist_go(k2,k)=mean(abs(W_ran(PMd,1)));
        W_MI_dist_go(k2,k)=mean(abs(W_ran(MI,1)));
    end
end

% Obtener limites de confianza
for k=1:5
    CI = CIFcn(W_PMv_dist_go(k,:)',p);
    li_PMv_go(k)=CI(1);
    lu_PMv_go(k)=CI(2);

    CI = CIFcn(W_PMd_dist_go(k,:)',p);
    li_PMd_go(k)=CI(1);
    lu_PMd_go(k)=CI(2);
    
	CI = CIFcn(W_MI_dist_go(k,:)',p);
	li_MI_go(k)=CI(1);
    lu_MI_go(k)=CI(2);
end
li_PMv_go
lu_PMv_go
W_PMv_real_go

li_PMv_avg=mean(li_PMv_go);
lu_PMv_avg=mean(lu_PMv_go);

% Obtener distancias en PMv
dsup_PMv_go=[];
dinf_PMv_go=[];
dmed_PMv_go=[];
for k=1:5
    if W_PMv_real_go(k)>lu_PMv_go(k)
        dsup_PMv_go=[dsup_PMv_go W_PMv_real_go(k)-lu_PMv_go(k)];
    end
	if W_PMv_real_go(k)<li_PMv_go(k)
        dinf_PMv_go=[dinf_PMv_go li_PMv_go(k)-W_PMv_real_go(k)];
    end
    if W_PMv_real_go(k)>li_PMv_go(k) && W_PMv_real_go(k)<lu_PMv_go(k)
        dmed_PMv_go=[dmed_PMv_go W_PMv_real_go(k)-li_PMv_go(k)];
    end
end
dsup_PMv_go;
dinf_PMv_go;
dmed_PMv_go;

% Obtener distancias en PMd
li_PMd_go;
lu_PMd_go;
W_PMd_real_go;
dsup_PMd_go=[];
dinf_PMd_go=[];
dmed_PMd_go=[];
for k=1:5
    if W_PMd_real_go(k)>lu_PMd_go(k)
        dsup_PMd_go=[dsup_PMd_go W_PMd_real_go(k)-lu_PMd_go(k)];
    end
	if W_PMd_real_go(k)<li_PMd_go(k)
        dinf_PMd_go=[dinf_PMd_go li_PMd_go(k)-W_PMd_real_go(k)];
    end
    if W_PMd_real_go(k)>li_PMd_go(k) && W_PMd_real_go(k)<lu_PMd_go(k)
        dmed_PMd_go=[dmed_PMd_go W_PMd_real_go(k)-li_PMd_go(k)];
    end
end
dsup_PMd_go
dinf_PMd_go
dmed_PMd_go

% Obtener distancias en MI
li_MI_go
lu_MI_go
W_MI_real_go
dsup_MI_go=[];
dinf_MI_go=[];
dmed_MI_go=[];
for k=1:5
    if W_MI_real_go(k)>lu_MI_go(k)
        dsup_MI_go=[dsup_MI_go W_MI_real_go(k)-lu_MI_go(k)];
    end
	if W_MI_real_go(k)<li_MI_go(k)
        dinf_MI_go=[dinf_MI_go li_MI_go(k)-W_MI_real_go(k)];
    end
    if W_MI_real_go(k)>li_MI_go(k) && W_MI_real_go(k)<lu_MI_go(k)
        dmed_MI_go=[dmed_MI_go W_MI_real_go(k)-li_MI_go(k)];
    end
end
dsup_MI_go
dinf_MI_go
dmed_MI_go

%% START
W_start=squeeze(W_all(4,:,:));
W_start=zscore(W_start);

% Obtener la media real en cada region
W_PMv_real_start=mean(abs(W_start(97:192,:)));
W_PMd_real_start=mean(abs(W_start(PMd,:)));
W_MI_real_start=mean(abs(W_start(MI,:)));

%Obtener distribuciones
for k2=1:5
    for k=1:100000
        v=randperm(192);
        W_ran=W_start(v,k2);                % W randomized  
        W_PMv_dist_start(k2,k)=mean(abs(W_ran(97:192,1)));
        W_PMd_dist_start(k2,k)=mean(abs(W_ran(PMd,1)));
        W_MI_dist_start(k2,k)=mean(abs(W_ran(MI,1)));
    end
end

% Obtener limites de confianza
for k=1:5
    CI = CIFcn(W_PMv_dist_start(k,:)',p);
    li_PMv_start(k)=CI(1);
    lu_PMv_start(k)=CI(2);

    CI = CIFcn(W_PMd_dist_start(k,:)',p);
    li_PMd_start(k)=CI(1);
    lu_PMd_start(k)=CI(2);
    
	CI = CIFcn(W_MI_dist_start(k,:)',p);
	li_MI_start(k)=CI(1);
    lu_MI_start(k)=CI(2);
end
li_PMv_start
lu_PMv_start
W_PMv_real_start

li_PMv_avg=mean(li_PMv_start);
lu_PMv_avg=mean(lu_PMv_start);

% Obtener distancias en PMv
dsup_PMv_start=[];
dinf_PMv_start=[];
dmed_PMv_start=[];
for k=1:5
    if W_PMv_real_start(k)>lu_PMv_start(k)
        dsup_PMv_start=[dsup_PMv_start W_PMv_real_start(k)-lu_PMv_start(k)];
    end
	if W_PMv_real_start(k)<li_PMv_start(k)
        dinf_PMv_start=[dinf_PMv_start li_PMv_start(k)-W_PMv_real_start(k)];
    end
    if W_PMv_real_start(k)>li_PMv_start(k) && W_PMv_real_start(k)<lu_PMv_start(k)
        dmed_PMv_start=[dmed_PMv_start W_PMv_real_start(k)-li_PMv_start(k)];
    end
end
dsup_PMv_start
dinf_PMv_start
dmed_PMv_start

% Obtener distancias en PMd
li_PMd_start
lu_PMd_start
W_PMd_real_start
dsup_PMd_start=[];
dinf_PMd_start=[];
dmed_PMd_start=[];
for k=1:5
    if W_PMd_real_start(k)>lu_PMd_start(k)
        dsup_PMd_start=[dsup_PMd_start W_PMd_real_start(k)-lu_PMd_start(k)];
    end
	if W_PMd_real_start(k)<li_PMd_start(k)
        dinf_PMd_start=[dinf_PMd_start li_PMd_start(k)-W_PMd_real_start(k)];
    end
    if W_PMd_real_start(k)>li_PMd_start(k) && W_PMd_real_start(k)<lu_PMd_start(k)
        dmed_PMd_start=[dmed_PMd_start W_PMd_real_start(k)-li_PMd_start(k)];
    end
end
dsup_PMd_start
dinf_PMd_start
dmed_PMd_start

% Obtener distancias en MI
li_MI_start
lu_MI_start
W_MI_real_start
dsup_MI_start=[];
dinf_MI_start=[];
dmed_MI_start=[];
for k=1:5
    if W_MI_real_start(k)>lu_MI_start(k)
        dsup_MI_start=[dsup_MI_start W_MI_real_start(k)-lu_MI_start(k)];
    end
	if W_MI_real_start(k)<li_MI_start(k)
        dinf_MI_start=[dinf_MI_start li_MI_start(k)-W_MI_real_start(k)];
    end
    if W_MI_real_start(k)>li_MI_start(k) && W_MI_real_start(k)<lu_MI_start(k)
        dmed_MI_start=[dmed_MI_start W_MI_real_start(k)-li_MI_start(k)];
    end
end
dsup_MI_start
dinf_MI_start
dmed_MI_start

%% BEGIN
W_beg=squeeze(W_all(5,:,:));
W_beg=zscore(W_beg);

% Obtener la media real en cada region
W_PMv_real_beg=mean(abs(W_beg(97:192,:)));
W_PMd_real_beg=mean(abs(W_beg(PMd,:)));
W_MI_real_beg=mean(abs(W_beg(MI,:)));

%Obtener distribuciones
for k2=1:5
    for k=1:100000
        v=randperm(192);
        W_ran=W_beg(v,k2);                % W randomized  
        W_PMv_dist_beg(k2,k)=mean(abs(W_ran(97:192,1)));
        W_PMd_dist_beg(k2,k)=mean(abs(W_ran(PMd,1)));
        W_MI_dist_beg(k2,k)=mean(abs(W_ran(MI,1)));
    end
end

% Obtener limites de confianza
for k=1:5
    CI = CIFcn(W_PMv_dist_beg(k,:)',p);
    li_PMv_beg(k)=CI(1);
    lu_PMv_beg(k)=CI(2);

    CI = CIFcn(W_PMd_dist_beg(k,:)',p);
    li_PMd_beg(k)=CI(1);
    lu_PMd_beg(k)=CI(2);
    
	CI = CIFcn(W_MI_dist_beg(k,:)',p);
	li_MI_beg(k)=CI(1);
    lu_MI_beg(k)=CI(2);
end
li_PMv_beg
lu_PMv_beg
W_PMv_real_beg

li_PMv_avg=mean(li_PMv_beg);
lu_PMv_avg=mean(lu_PMv_beg);

% Obtener distancias en PMv
dsup_PMv_beg=[];
dinf_PMv_beg=[];
dmed_PMv_beg=[];
for k=1:5
    if W_PMv_real_beg(k)>lu_PMv_beg(k)
        dsup_PMv_beg=[dsup_PMv_beg W_PMv_real_beg(k)-lu_PMv_beg(k)];
    end
	if W_PMv_real_beg(k)<li_PMv_beg(k)
        dinf_PMv_beg=[dinf_PMv_beg li_PMv_beg(k)-W_PMv_real_beg(k)];
    end
    if W_PMv_real_beg(k)>li_PMv_beg(k) && W_PMv_real_beg(k)<lu_PMv_beg(k)
        dmed_PMv_beg=[dmed_PMv_beg W_PMv_real_beg(k)-li_PMv_beg(k)];
    end
end
dsup_PMv_beg
dinf_PMv_beg
dmed_PMv_beg

% Obtener distancias en PMd
li_PMd_beg
lu_PMd_beg
W_PMd_real_beg
dsup_PMd_beg=[];
dinf_PMd_beg=[];
dmed_PMd_beg=[];
for k=1:5
    if W_PMd_real_beg(k)>lu_PMd_beg(k)
        dsup_PMd_beg=[dsup_PMd_beg W_PMd_real_beg(k)-lu_PMd_beg(k)];
    end
	if W_PMd_real_beg(k)<li_PMd_beg(k)
        dinf_PMd_beg=[dinf_PMd_beg li_PMd_beg(k)-W_PMd_real_beg(k)];
    end
    if W_PMd_real_beg(k)>li_PMd_beg(k) && W_PMd_real_beg(k)<lu_PMd_beg(k)
        dmed_PMd_beg=[dmed_PMd_beg W_PMd_real_beg(k)-li_PMd_beg(k)];
    end
end
dsup_PMd_beg
dinf_PMd_beg
dmed_PMd_beg

% Obtener distancias en MI
li_MI_beg
lu_MI_beg
W_MI_real_beg
dsup_MI_beg=[];
dinf_MI_beg=[];
dmed_MI_beg=[];
for k=1:5
    if W_MI_real_beg(k)>lu_MI_beg(k)
        dsup_MI_beg=[dsup_MI_beg W_MI_real_beg(k)-lu_MI_beg(k)];
    end
	if W_MI_real_beg(k)<li_MI_beg(k)
        dinf_MI_beg=[dinf_MI_beg li_MI_beg(k)-W_MI_real_beg(k)];
    end
    if W_MI_real_beg(k)>li_MI_beg(k) && W_MI_real_beg(k)<lu_MI_beg(k)
        dmed_MI_beg=[dmed_MI_beg W_MI_real_beg(k)-li_MI_beg(k)];
    end
end
dsup_MI_beg
dinf_MI_beg
dmed_MI_beg

%% END
W_end=squeeze(W_all(6,:,:));
W_end=zscore(W_end);

% Obtener la media real en cada region
W_PMv_real_end=mean(abs(W_end(97:192,:)));
W_PMd_real_end=mean(abs(W_end(PMd,:)));
W_MI_real_end=mean(abs(W_end(MI,:)));

%Obtener distribuciones
for k2=1:5
    for k=1:100000
        v=randperm(192);
        W_ran=W_end(v,k2);                % W randomized  
        W_PMv_dist_end(k2,k)=mean(abs(W_ran(97:192,1)));
        W_PMd_dist_end(k2,k)=mean(abs(W_ran(PMd,1)));
        W_MI_dist_end(k2,k)=mean(abs(W_ran(MI,1)));
    end
end

% Obtener limites de confianza
for k=1:5
    CI = CIFcn(W_PMv_dist_end(k,:)',p);
    li_PMv_end(k)=CI(1);
    lu_PMv_end(k)=CI(2);

    CI = CIFcn(W_PMd_dist_end(k,:)',p);
    li_PMd_end(k)=CI(1);
    lu_PMd_end(k)=CI(2);
    
	CI = CIFcn(W_MI_dist_end(k,:)',p);
	li_MI_end(k)=CI(1);
    lu_MI_end(k)=CI(2);
end
li_PMv_end
lu_PMv_end
W_PMv_real_end

li_PMv_avg=mean(li_PMv_end);
lu_PMv_avg=mean(lu_PMv_end);

% Obtener distancias en PMv
dsup_PMv_end=[];
dinf_PMv_end=[];
dmed_PMv_end=[];
for k=1:5
    if W_PMv_real_end(k)>lu_PMv_end(k)
        dsup_PMv_end=[dsup_PMv_end W_PMv_real_end(k)-lu_PMv_end(k)];
    end
	if W_PMv_real_end(k)<li_PMv_end(k)
        dinf_PMv_end=[dinf_PMv_end li_PMv_end(k)-W_PMv_real_end(k)];
    end
    if W_PMv_real_end(k)>li_PMv_end(k) && W_PMv_real_end(k)<lu_PMv_end(k)
        dmed_PMv_end=[dmed_PMv_end W_PMv_real_end(k)-li_PMv_end(k)];
    end
end
dsup_PMv_end
dinf_PMv_end
dmed_PMv_end

% Obtener distancias en PMd
li_PMd_end
lu_PMd_end
W_PMd_real_end
dsup_PMd_end=[];
dinf_PMd_end=[];
dmed_PMd_end=[];
for k=1:5
    if W_PMd_real_end(k)>lu_PMd_end(k)
        dsup_PMd_end=[dsup_PMd_end W_PMd_real_end(k)-lu_PMd_end(k)];
    end
	if W_PMd_real_end(k)<li_PMd_end(k)
        dinf_PMd_end=[dinf_PMd_end li_PMd_end(k)-W_PMd_real_end(k)];
    end
    if W_PMd_real_end(k)>li_PMd_end(k) && W_PMd_real_end(k)<lu_PMd_end(k)
        dmed_PMd_end=[dmed_PMd_end W_PMd_real_end(k)-li_PMd_end(k)];
    end
end
dsup_PMd_end
dinf_PMd_end
dmed_PMd_end

% Obtener distancias en MI
li_MI_end
lu_MI_end
W_MI_real_end
dsup_MI_end=[];
dinf_MI_end=[];
dmed_MI_end=[];
for k=1:5
    if W_MI_real_end(k)>lu_MI_end(k)
        dsup_MI_end=[dsup_MI_end W_MI_real_end(k)-lu_MI_end(k)];
    end
	if W_MI_real_end(k)<li_MI_end(k)
        dinf_MI_end=[dinf_MI_end li_MI_end(k)-W_MI_real_end(k)];
    end
    if W_MI_real_end(k)>li_MI_end(k) && W_MI_real_end(k)<lu_MI_end(k)
        dmed_MI_end=[dmed_MI_end W_MI_real_end(k)-li_MI_end(k)];
    end
end
dsup_MI_end
dinf_MI_end
dmed_MI_end

%% RWD
W_rwd=squeeze(W_all(7,:,:));
W_rwd=zscore(W_rwd);

% Obtener la media real en cada region
W_PMv_real_rwd=mean(abs(W_rwd(97:192,:)));
W_PMd_real_rwd=mean(abs(W_rwd(PMd,:)));
W_MI_real_rwd=mean(abs(W_rwd(MI,:)));

%Obtener distribuciones
for k2=1:5
    for k=1:100000
        v=randperm(192);
        W_ran=W_rwd(v,k2);                % W randomized  
        W_PMv_dist_rwd(k2,k)=mean(abs(W_ran(97:192,1)));
        W_PMd_dist_rwd(k2,k)=mean(abs(W_ran(PMd,1)));
        W_MI_dist_rwd(k2,k)=mean(abs(W_ran(MI,1)));
    end
end

% Obtener limites de confianza
for k=1:5
    CI = CIFcn(W_PMv_dist_rwd(k,:)',p);
    li_PMv_rwd(k)=CI(1);
    lu_PMv_rwd(k)=CI(2);

    CI = CIFcn(W_PMd_dist_rwd(k,:)',p);
    li_PMd_rwd(k)=CI(1);
    lu_PMd_rwd(k)=CI(2);
    
	CI = CIFcn(W_MI_dist_rwd(k,:)',p);
	li_MI_rwd(k)=CI(1);
    lu_MI_rwd(k)=CI(2);
end
li_PMv_rwd
lu_PMv_rwd
W_PMv_real_rwd

li_PMv_avg=mean(li_PMv_rwd);
lu_PMv_avg=mean(lu_PMv_rwd);

% Obtener distancias en PMv
dsup_PMv_rwd=[];
dinf_PMv_rwd=[];
dmed_PMv_rwd=[];
for k=1:5
    if W_PMv_real_rwd(k)>lu_PMv_rwd(k)
        dsup_PMv_rwd=[dsup_PMv_rwd W_PMv_real_rwd(k)-lu_PMv_rwd(k)];
    end
	if W_PMv_real_rwd(k)<li_PMv_rwd(k)
        dinf_PMv_rwd=[dinf_PMv_rwd li_PMv_rwd(k)-W_PMv_real_rwd(k)];
    end
    if W_PMv_real_rwd(k)>li_PMv_rwd(k) && W_PMv_real_rwd(k)<lu_PMv_rwd(k)
        dmed_PMv_rwd=[dmed_PMv_rwd W_PMv_real_rwd(k)-li_PMv_rwd(k)];
    end
end
dsup_PMv_rwd
dinf_PMv_rwd
dmed_PMv_rwd

% Obtener distancias en PMd
li_PMd_rwd
lu_PMd_rwd
W_PMd_real_rwd
dsup_PMd_rwd=[];
dinf_PMd_rwd=[];
dmed_PMd_rwd=[];
for k=1:5
    if W_PMd_real_rwd(k)>lu_PMd_rwd(k)
        dsup_PMd_rwd=[dsup_PMd_rwd W_PMd_real_rwd(k)-lu_PMd_rwd(k)];
    end
	if W_PMd_real_rwd(k)<li_PMd_rwd(k)
        dinf_PMd_rwd=[dinf_PMd_rwd li_PMd_rwd(k)-W_PMd_real_rwd(k)];
    end
    if W_PMd_real_rwd(k)>li_PMd_rwd(k) && W_PMd_real_rwd(k)<lu_PMd_rwd(k)
        dmed_PMd_rwd=[dmed_PMd_rwd W_PMd_real_rwd(k)-li_PMd_rwd(k)];
    end
end
dsup_PMd_rwd
dinf_PMd_rwd
dmed_PMd_rwd

% Obtener distancias en MI
li_MI_rwd
lu_MI_rwd
W_MI_real_rwd
dsup_MI_rwd=[];
dinf_MI_rwd=[];
dmed_MI_rwd=[];
for k=1:5
    if W_MI_real_rwd(k)>lu_MI_rwd(k)
        dsup_MI_rwd=[dsup_MI_rwd W_MI_real_rwd(k)-lu_MI_rwd(k)];
    end
	if W_MI_real_rwd(k)<li_MI_rwd(k)
        dinf_MI_rwd=[dinf_MI_rwd li_MI_rwd(k)-W_MI_real_rwd(k)];
    end
    if W_MI_real_rwd(k)>li_MI_rwd(k) && W_MI_real_rwd(k)<lu_MI_rwd(k)
        dmed_MI_rwd=[dmed_MI_rwd W_MI_real_rwd(k)-li_MI_rwd(k)];
    end
end
dsup_MI_rwd
dinf_MI_rwd
dmed_MI_rwd


%% Grafica PMv
N=80;
CT=cbrewer('seq', 'OrRd', N);
%CT=cbrewer('seq', 'Blues', N);
li_PMv_avg=mean(mean([li_PMv_obj; li_PMv_grip; li_PMv_go; li_PMv_start; li_PMv_beg; li_PMv_end; li_PMv_rwd]));
lu_PMv_avg=mean(mean([lu_PMv_obj; lu_PMv_grip; lu_PMv_go; lu_PMv_start; lu_PMv_beg; lu_PMv_end; lu_PMv_rwd]));

mean_PMv=(li_PMv_avg+lu_PMv_avg)/2;
std_PMv=(lu_PMv_avg-mean_PMv)/2.6;
aux =std_PMv*randn(100000,1)+mean_PMv;

figure('Name','1','Position',[1200 40 400 950]);
e3=subplot('Position',[0.1 0.71 0.8 0.28]);
e2=subplot('Position',[0.1 0.42 0.8 0.28]);
e1=subplot('Position',[0.1 0.13 0.8 0.28]);


axes(e1)
[counts, bins]=hist(aux,N);
hold on;
for k=1:N
    c=k;
    bar(bins(k),counts(k),0.7/50,'FaceColor',CT(c,:),'EdgeColor',CT(c,:))
end

xline(li_PMv_avg,'--b','HandleVisibility','off','Linewidth',1.5);
xline(lu_PMv_avg,'--b','Linewidth',1.5);
hold on

for k=1:numel(dsup_PMv_obj)
        plot(dsup_PMv_obj(k)+lu_PMv_avg,5000,'LineWidth',2,'color','g','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','g');
end
for k=1:numel(dinf_PMv_obj)
        plot(li_PMv_avg-dinf_PMv_obj(k),5000,'LineWidth',2,'color','g','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','g');
end
for k=1:numel(dmed_PMv_obj)
        plot(li_PMv_avg+dmed_PMv_obj(k),5000,'LineWidth',2,'color','g','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','g');
end

for k=1:numel(dsup_PMv_grip)
        plot(dsup_PMv_grip(k)+lu_PMv_avg,5700,'LineWidth',2,'color','b','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','b');
end
for k=1:numel(dinf_PMv_grip)
        plot(li_PMv_avg-dinf_PMv_grip(k),5700,'LineWidth',2,'color','b','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','b');
end
for k=1:numel(dmed_PMv_grip)
        plot(li_PMv_avg+dmed_PMv_grip(k),5700,'LineWidth',2,'color','b','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','b');
end

for k=1:numel(dsup_PMv_go)
        plot(dsup_PMv_go(k)+lu_PMv_avg,6400,'LineWidth',2,'color','k','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','k');
end
for k=1:numel(dinf_PMv_go)
        plot(li_PMv_avg-dinf_PMv_go(k),6400,'LineWidth',2,'color','k','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','k');
end
for k=1:numel(dmed_PMv_go)
        plot(li_PMv_avg+dmed_PMv_go(k),6400,'LineWidth',2,'color','k','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','k');
end

for k=1:numel(dsup_PMv_start)
        plot(dsup_PMv_start(k)+lu_PMv_avg,7100,'LineWidth',2,'color','m','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','m');
end
for k=1:numel(dinf_PMv_start)
        plot(li_PMv_avg-dinf_PMv_start(k),7100,'LineWidth',2,'color','m','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','m');
end
for k=1:numel(dmed_PMv_start)
        plot(li_PMv_avg+dmed_PMv_start(k),7100,'LineWidth',2,'color','m','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','m');
end

for k=1:numel(dsup_PMv_beg)
        plot(dsup_PMv_beg(k)+lu_PMv_avg,7800,'LineWidth',2,'color','c','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','c');
end
for k=1:numel(dinf_PMv_beg)
        plot(li_PMv_avg-dinf_PMv_beg(k),7800,'LineWidth',2,'color','c','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','c');
end
for k=1:numel(dmed_PMv_beg)
        plot(li_PMv_avg+dmed_PMv_beg(k),7800,'LineWidth',2,'color','c','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','c');
end

for k=1:numel(dsup_PMv_end)
        plot(dsup_PMv_end(k)+lu_PMv_avg,8500,'LineWidth',2,'color',[1 0.4 0],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[1 0.4 0]);
end
for k=1:numel(dinf_PMv_end)
        plot(li_PMv_avg-dinf_PMv_end(k),8500,'LineWidth',2,'color',[1 0.4 0],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[1 0.4 0]);
end
for k=1:numel(dmed_PMv_end)
        plot(li_PMv_avg+dmed_PMv_end(k),8500,'LineWidth',2,'color',[1 0.4 0],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[1 0.4 0]);
end

for k=1:numel(dsup_PMv_rwd)
        plot(dsup_PMv_rwd(k)+lu_PMv_avg,9200,'LineWidth',2,'color',[0.2 0.4 0.6],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[0.2 0.4 0.6]);
end
for k=1:numel(dinf_PMv_rwd)
        plot(li_PMv_avg-dinf_PMv_rwd(k),9200,'LineWidth',2,'color',[0.2 0.4 0.6],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[0.2 0.4 0.6]);
end
for k=1:numel(dmed_PMv_rwd)
        plot(li_PMv_avg+dmed_PMv_rwd(k),9200,'LineWidth',2,'color',[0.2 0.4 0.6],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[0.2 0.4 0.6]);
end
%e1.YAxis.Visible = 'off';   
xlim([0.31 0.92])
xticks([li_PMv_avg lu_PMv_avg ])
xticklabels({'-99%','+99%'})
yticklabels({})
box on
ylim([0 10000])
set(gca,'view',[90 -90])

%% Grafica PMd
li_PMd_avg=mean(mean([li_PMd_obj; li_PMd_grip; li_PMd_go; li_PMd_start; li_PMd_beg; li_PMd_end; li_PMd_rwd]));
lu_PMd_avg=mean(mean([lu_PMd_obj; lu_PMd_grip; lu_PMd_go; lu_PMd_start; lu_PMd_beg; lu_PMd_end; lu_PMd_rwd]));

mean_PMd=(li_PMd_avg+lu_PMd_avg)/2;
std_PMd=(lu_PMd_avg-mean_PMd)/2.6;
aux =std_PMd*randn(100000,1)+mean_PMd;

axes(e2)
[counts, bins]=hist(aux,N);
hold on;
for k=1:N
    c=k;
    bar(bins(k),counts(k),0.7/50,'FaceColor',CT(c,:),'EdgeColor',[214/255 126/255 44/255])
end

xline(li_PMd_avg,'--b','HandleVisibility','off','Linewidth',1.5);
xline(lu_PMd_avg,'--b','Linewidth',1.5);
hold on

for k=1:numel(dsup_PMd_obj)
        plot(dsup_PMd_obj(k)+lu_PMd_avg,5000,'LineWidth',2,'color','g','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','g');
end
for k=1:numel(dinf_PMd_obj)
        plot(li_PMd_avg-dinf_PMd_obj(k),5000,'LineWidth',2,'color','g','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','g');
end
for k=1:numel(dmed_PMd_obj)
        plot(li_PMd_avg+dmed_PMd_obj(k),5000,'LineWidth',2,'color','g','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','g');
end

for k=1:numel(dsup_PMd_grip)
        plot(dsup_PMd_grip(k)+lu_PMd_avg,5700,'LineWidth',2,'color','b','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','b');
end
for k=1:numel(dinf_PMd_grip)
        plot(li_PMd_avg-dinf_PMd_grip(k),5700,'LineWidth',2,'color','b','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','b');
end
for k=1:numel(dmed_PMd_grip)
        plot(li_PMd_avg+dmed_PMd_grip(k),5700,'LineWidth',2,'color','b','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','b');
end

for k=1:numel(dsup_PMd_go)
        plot(dsup_PMd_go(k)+lu_PMd_avg,6400,'LineWidth',2,'color','k','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','k');
end
for k=1:numel(dinf_PMd_go)
        plot(li_PMd_avg-dinf_PMd_go(k),6400,'LineWidth',2,'color','k','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','k');
end
for k=1:numel(dmed_PMd_go)
        plot(li_PMd_avg+dmed_PMd_go(k),6400,'LineWidth',2,'color','k','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','k');
end

for k=1:numel(dsup_PMd_start)
        plot(dsup_PMd_start(k)+lu_PMd_avg,7100,'LineWidth',2,'color','m','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','m');
end
for k=1:numel(dinf_PMd_start)
        plot(li_PMd_avg-dinf_PMd_start(k),7100,'LineWidth',2,'color','m','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','m');
end
for k=1:numel(dmed_PMd_start)
        plot(li_PMd_avg+dmed_PMd_start(k),7100,'LineWidth',2,'color','m','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','m');
end

for k=1:numel(dsup_PMd_beg)
        plot(dsup_PMd_beg(k)+lu_PMd_avg,7800,'LineWidth',2,'color','c','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','c');
end
for k=1:numel(dinf_PMd_beg)
        plot(li_PMd_avg-dinf_PMd_beg(k),7800,'LineWidth',2,'color','c','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','c');
end
for k=1:numel(dmed_PMd_beg)
        plot(li_PMd_avg+dmed_PMd_beg(k),7800,'LineWidth',2,'color','c','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','c');
end

for k=1:numel(dsup_PMd_end)
        plot(dsup_PMd_end(k)+lu_PMd_avg,8500,'LineWidth',2,'color',[1 0.4 0],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[1 0.4 0]);
end
for k=1:numel(dinf_PMd_end)
        plot(li_PMd_avg-dinf_PMd_end(k),8500,'LineWidth',2,'color',[1 0.4 0],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[1 0.4 0]);
end
for k=1:numel(dmed_PMd_end)
        plot(li_PMd_avg+dmed_PMd_end(k),8500,'LineWidth',2,'color',[1 0.4 0],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[1 0.4 0]);
end

for k=1:numel(dsup_PMd_rwd)
        plot(dsup_PMd_rwd(k)+lu_PMd_avg,9200,'LineWidth',2,'color',[0.2 0.4 0.6],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[0.2 0.4 0.6]);
end
for k=1:numel(dinf_PMd_rwd)
        plot(li_PMd_avg-dinf_PMd_rwd(k),9200,'LineWidth',2,'color',[0.2 0.4 0.6],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[0.2 0.4 0.6]);
end
for k=1:numel(dmed_PMd_rwd)
        plot(li_PMd_avg+dmed_PMd_rwd(k),9200,'LineWidth',2,'color',[0.2 0.4 0.6],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[0.2 0.4 0.6]);
end

%e2.YAxis.Visible = 'off';   
yticklabels({})
box on
xlim([0.15 1.15])
ylim([0 10000])
xticks([li_PMd_avg lu_PMd_avg ])
xticklabels({'-99%','+99%'})
set(gca,'view',[90 -90])

%% Grafica MI
li_MI_avg=mean(mean([li_MI_obj; li_MI_grip; li_MI_go; li_MI_start; li_MI_beg; li_MI_end; li_MI_rwd]));
lu_MI_avg=mean(mean([lu_MI_obj; lu_MI_grip; lu_MI_go; lu_MI_start; lu_MI_beg; lu_MI_end; lu_MI_rwd]));

mean_MI=(li_MI_avg+lu_MI_avg)/2;
std_MI=(lu_MI_avg-mean_MI)/2.6;
aux =std_MI*randn(100000,1)+mean_MI;

axes(e3)
[counts, bins]=hist(aux,N);
hold on;
for k=1:N
    c=k;
    bar(bins(k),counts(k),0.7/50,'FaceColor',CT(c,:),'EdgeColor',[214/255 126/255 44/255])
end
xline(li_MI_avg,'--b','HandleVisibility','off','Linewidth',1.5);
xline(lu_MI_avg,'--b','Linewidth',1.5);
hold on

for k=1:numel(dsup_MI_obj)
        plot(dsup_MI_obj(k)+lu_MI_avg,5000,'LineWidth',2,'color','g','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','g');
end
for k=1:numel(dinf_MI_obj)
        plot(li_MI_avg-dinf_MI_obj(k),5000,'LineWidth',2,'color','g','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','g');
end
for k=1:numel(dmed_MI_obj)
        plot(li_MI_avg+dmed_MI_obj(k),5000,'LineWidth',2,'color','g','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','g');
end

for k=1:numel(dsup_MI_grip)
        plot(dsup_MI_grip(k)+lu_MI_avg,5700,'LineWidth',2,'color','b','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','b');
end
for k=1:numel(dinf_MI_grip)
        plot(li_MI_avg-dinf_MI_grip(k),5700,'LineWidth',2,'color','b','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','b');
end
for k=1:numel(dmed_MI_grip)
        plot(li_MI_avg+dmed_MI_grip(k),5700,'LineWidth',2,'color','b','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','b');
end

for k=1:numel(dsup_MI_go)
        plot(dsup_MI_go(k)+lu_MI_avg,6400,'LineWidth',2,'color','k','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','k');
end
for k=1:numel(dinf_MI_go)
        plot(li_MI_avg-dinf_MI_go(k),6400,'LineWidth',2,'color','k','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','k');
end
for k=1:numel(dmed_MI_go)
        plot(li_MI_avg+dmed_MI_go(k),6400,'LineWidth',2,'color','k','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','k');
end

for k=1:numel(dsup_MI_start)
        plot(dsup_MI_start(k)+lu_MI_avg,7100,'LineWidth',2,'color','m','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','m');
end
for k=1:numel(dinf_MI_start)
        plot(li_MI_avg-dinf_MI_start(k),7100,'LineWidth',2,'color','m','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','m');
end
for k=1:numel(dmed_MI_start)
        plot(li_MI_avg+dmed_MI_start(k),7100,'LineWidth',2,'color','m','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','m');
end

for k=1:numel(dsup_MI_beg)
        plot(dsup_MI_beg(k)+lu_MI_avg,7800,'LineWidth',2,'color','c','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','c');
end
for k=1:numel(dinf_MI_beg)
        plot(li_MI_avg-dinf_MI_beg(k),7800,'LineWidth',2,'color','c','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','c');
end
for k=1:numel(dmed_MI_beg)
        plot(li_MI_avg+dmed_MI_beg(k),7800,'LineWidth',2,'color','c','Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor','c');
end

for k=1:numel(dsup_MI_end)
        plot(dsup_MI_end(k)+lu_MI_avg,8500,'LineWidth',2,'color',[1 0.4 0],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[1 0.4 0]);
end
for k=1:numel(dinf_MI_end)
        plot(li_MI_avg-dinf_MI_end(k),8500,'LineWidth',2,'color',[1 0.4 0],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[1 0.4 0]);
end
for k=1:numel(dmed_MI_end)
        plot(li_MI_avg+dmed_MI_end(k),8500,'LineWidth',2,'color',[1 0.4 0],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[1 0.4 0]);
end

for k=1:numel(dsup_MI_rwd)
        plot(dsup_MI_rwd(k)+lu_MI_avg,9200,'LineWidth',2,'color',[0.2 0.4 0.6],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[0.2 0.4 0.6]);
end
for k=1:numel(dinf_MI_rwd)
        plot(li_MI_avg-dinf_MI_rwd(k),9200,'LineWidth',2,'color',[0.2 0.4 0.6],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[0.2 0.4 0.6]);
end
for k=1:numel(dmed_MI_rwd)
        plot(li_MI_avg+dmed_MI_rwd(k),9200,'LineWidth',2,'color',[0.2 0.4 0.6],'Linewidth',1.5,'Marker','*','MarkerSize',7,'MarkerFaceColor',[0.2 0.4 0.6]);
end

%e3.YAxis.Visible = 'off';
yticklabels({})
box on
xlim([0.2 1.45])
ylim([0 10000])
xticks([li_MI_avg lu_MI_avg ])
xticklabels({'-99%','+99%'})
 set(gca,'view',[90 -90])

% text(0,-5000,'Obj Present','color','g','FontSize',10)
% text(0.2,1500,'Grip Cue','color','b','FontSize',10)
% text(0.2,1800,'Go Cue','color','k','FontSize',10)
% text(0.2,2100,'Start Mov','color','m','FontSize',10)
% text(0.2,2400,'Begin Lift','color','c','FontSize',10)
% text(0.2,2700,'End Lift','color',[1 0.4 0],'FontSize',10)
% text(0.2,3000,'Reward','color',[0.2 0.4 0.6],'FontSize',10)
