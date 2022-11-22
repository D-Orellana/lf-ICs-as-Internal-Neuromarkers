

function [stg_detect_res]=stage_detection(data_folder,file2load, w2load, selected_ICs,fp)
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load)                                                    % Subsampled and merged data

aux=dir(strcat(data_folder,'\**\',w2load));
full_w2load=strcat(aux.folder,'\',aux.name);
load(full_w2load);                                                   % Load unmixing matrix

Data=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering
ICs=W*Data;

events_exe=Data_all.events_exe;
labels_exe=Data_all.labels_exe;
incomplete_events=Data_all.incomplete_events;
events_ob=Data_all.events_ob;
fs=Data_all.fs;

%% Delete Not Used Segments
% Create markers vector 
    %11= start successful trial, 
    %21= start incomplete trial
    %31= start observed trial
    %41= start NoGO trial
marks=zeros(1,size(ICs,2));
for k=1:size(events_exe,1)
    mk=round(events_exe(k,1)*fs);
    marks(mk)=11;
	mk=round(events_exe(k,2)*fs);
    marks(mk)=12;
    mk=round(events_exe(k,3)*fs);
    marks(mk)=13;
    mk=round(events_exe(k,4)*fs);
    marks(mk)=14;
    mk=round(events_exe(k,5)*fs);
    marks(mk)=15;
    mk=round(events_exe(k,6)*fs);
    marks(mk)=16;
    mk=round(events_exe(k,7)*fs);
    marks(mk)=17;
    mk=round(events_exe(k,8)*fs);
    marks(mk)=18;
end

for k=1:numel(incomplete_events.object)
    mk=round(incomplete_events.object(k)*fs);
    if mk <=size(ICs,2)
        marks(mk)=21;
    end
end
    
for k=1:size(events_ob,1)
    mk=round(events_ob(k,1)*fs);
    if mk <= size(ICs,2)
        marks(mk)=31;
    end
end

ini=1;
fin=round((events_exe(1,1)-1)*fs);
marks(ini:fin)=[];
ICs(:,ini:fin)=[];

good_evs=[find(marks==11)];
bad_evs=[find(marks==21) find(marks==31)];
antes=0.3;

while ~isempty(bad_evs)
    ini=bad_evs(1)-antes*fs;
	aux=find(good_evs>ini,1);
    if  isempty(aux)
        fin=numel(marks);
    else
        fin=good_evs(aux(1))-antes*fs;
    end
    marks(ini:fin)=[];
    ICs(:,ini:fin)=[];
    good_evs=[find(marks==11)];
    bad_evs=[find(marks==21) find(marks==31)];
    numel(bad_evs);
end
% bad segment in spk 121005
if file2load=='SPK_all_121005_250.mat'
    ini=73820;
    fin=125977;
    marks(ini:fin)=[];
    ICs(:,ini:fin)=[];
end

if file2load=='RUS_all_120619_250.mat'
    marks(82100:114200)=[];
    ICs(:,82100:114200)=[];
    marks(161700:200160)=[];
    ICs(:,161700:200160)=[];
end

if file2load=='RUS_all_120622_250.mat'
    marks(83070:112800)=[];
    ICs(:,83070:112800)=[];
    marks(161900:181000)=[];
    ICs(:,161900:181000)=[];
    marks(244200:256900)=[];
    ICs(:,244200:256900)=[];
end

if file2load=='RUS_all_120627_250.mat'
    marks(72320:114000)=[];
    ICs(:,72320:114000)=[];
    marks(154300:182700)=[];
    ICs(:,154300:182700)=[];
end

if file2load=='RUS_all_120702_250.mat'
     marks(74520:99390)=[];
     ICs(:,74520:99390)=[];
     marks(149900:168050)=[];
     ICs(:,149900:168050)=[];
end


events_new(:,1)=find(marks==11);
events_new(:,2)=find(marks==12);
events_new(:,3)=find(marks==13);
events_new(:,4)=find(marks==14);
events_new(:,5)=find(marks==15);
events_new(:,6)=find(marks==16);
events_new(:,7)=find(marks==17);
events_new(:,8)=find(marks==18);

%% Detect Object Stage
IC=ICs(selected_ICs(1),:);
[pksp,~] = findpeaks(IC,'MinPeakHeight',2.8*std(IC));
[pksn,~] = findpeaks(-IC,'MinPeakHeight',2.8*std(IC));
if mean(pksn)>mean(pksp) || isempty(pksp)
    IC=-IC;
end

t_bef=0.1;
if isempty(strfind(file2load,'SPK'))
    t_aft=0.9;
else
    t_aft=0.7;
end

if fp==1
    figure
    findpeaks(IC,'MinPeakHeight',3.73*std(IC))
    hold on
    for k=1:numel(labels_exe)
        xline(events_new(k,1)-round(t_bef*fs),'LineWidth',1.5)
        xline(events_new(k,1)+round(t_aft*fs),'LineWidth',1.5,'Color','g');
    end
    yline(3.73*std(IC),'LineWidth',1.5);
    title('Object Stage')
end

% find valid microsegments
for k=1:numel(labels_exe)
    ini=events_new(k,1)-round(t_bef*fs);
    fin=events_new(k,1)+round(t_aft*fs);
    aux_seg(k,:)=ini:fin;
    ini=fin+1;
    if k==numel(labels_exe)
        fin=numel(IC);
    else
        fin=events_new(k+1,1)-round(t_bef*fs)-1;
    end
    aux_seg2(k).seg=ini:fin;
end

contTH=0;
for k=0.5:0.01:6
        contTH=contTH+1;
        [~,all_P]=findpeaks(IC,'MinPeakHeight',k*std(IC));
        contTP=0;
        contFN=0;
        contTN=0;
        contFP=0;
    for k2=1:numel(labels_exe)
            [a,~]=intersect(all_P,aux_seg(k2,:));
            if isempty(a)
                contFN=contFN+1;
            else
                contTP=contTP+1;
            end
            [a,~]=intersect(all_P,aux_seg2(k2).seg);
            if isempty(a)
                contTN=contTN+1;
            else
                contFP=contFP+1;
            end
    end
    TP(contTH)=contTP;
    FN(contTH)=contFN;
    FP(contTH)=contFP;
    TN(contTH)=contTN;
    
    Prec(contTH)=TP(contTH)/(TP(contTH)+FP(contTH));
    Rec(contTH)=TP(contTH)/(TP(contTH)+FN(contTH));
    TPR1(contTH)=TP(contTH)/numel(labels_exe);
     FPR1(contTH)=FP(contTH)/(numel(labels_exe));
    Gmean(contTH)=(TPR1(contTH)*(1-FPR1(contTH)))^(1/2);
end
th_vec=0.5:0.01:6;
[~,opt_pt]=max(Gmean);
Prec_opt(1,1)=Prec(opt_pt);
Rec_opt(1,1)=Rec(opt_pt);
Th_opt(1,1)=th_vec(opt_pt);

%% Detect Grip Stage
clear vars aux_seg TP FN FP TN Pre Rec valid_seg Gmean seg2
IC=ICs( selected_ICs(2),:);
[pksp,~] = findpeaks(IC,'MinPeakHeight',2.8*std(IC));
[pksn,~] = findpeaks(-IC,'MinPeakHeight',2.8*std(IC));
if mean(pksn)>mean(pksp) || isempty(pksp)
    IC=-IC;
end

if isempty(strfind(file2load,'SPK'))
    t_bef=0.2;
else
    t_bef=0.1;
end
t_aft=1.7;

if fp==1
    figure
    findpeaks(IC,'MinPeakHeight',3.29*std(IC))
    hold on
    for k=1:numel(labels_exe)
        xline(events_new(k,2)-round(t_bef*fs),'LineWidth',1.5)
        xline(events_new(k,2)+round(t_aft*fs),'LineWidth',1.5,'Color','g');
    end
    yline(3.29*std(IC),'LineWidth',1.5);
    title('Grip Stage')
end

% find valid microsegments
for k=1:numel(labels_exe)
    ini=events_new(k,2)-round(t_bef*fs);
    fin=events_new(k,2)+round(t_aft*fs);
    aux_seg(k,:)=ini:fin;
    ini=fin+1;
    if k==numel(labels_exe)
        fin=numel(IC);
    else
        fin=events_new(k+1,2)-round(t_bef*fs)-1;
    end
    aux_seg2(k).seg=ini:fin;
end

contTH=0;
for k=0.5:0.01:6
        contTH=contTH+1;
        [~,all_P]=findpeaks(IC,'MinPeakHeight',k*std(IC));
        contTP=0;
        contFN=0;
        contTN=0;
        contFP=0;
    for k2=1:numel(labels_exe)
            [a,~]=intersect(all_P,aux_seg(k2,:));
            if isempty(a)
                contFN=contFN+1;
            else
                contTP=contTP+1;
            end
            [a,~]=intersect(all_P,aux_seg2(k2).seg);
            if isempty(a)
                contTN=contTN+1;
            else
                contFP=contFP+1;
            end
    end
    TP(contTH)=contTP;
    FN(contTH)=contFN;
    FP(contTH)=contFP;
    TN(contTH)=contTN;
    
    Prec(contTH)=TP(contTH)/(TP(contTH)+FP(contTH));
    Rec(contTH)=TP(contTH)/(TP(contTH)+FN(contTH));
    TPR2(contTH)=TP(contTH)/numel(labels_exe);
     FPR2(contTH)=FP(contTH)/(numel(labels_exe));
    Gmean(contTH)=(TPR2(contTH)*(1-FPR2(contTH)))^(1/2);
end
[~,opt_pt]=max(Gmean);
Prec_opt(1,2)=Prec(opt_pt);
Rec_opt(1,2)=Rec(opt_pt);
Th_opt(1,2)=th_vec(opt_pt);

%% Detect GO Stage
clear vars aux_seg TP FN FP TN Pre Rec valid_seg Gmean seg2
IC=ICs( selected_ICs(3),:);
[pksp,~] = findpeaks(IC,'MinPeakHeight',2.8*std(IC));
[pksn,~] = findpeaks(-IC,'MinPeakHeight',2.8*std(IC));
if mean(pksn)>mean(pksp) || isempty(pksp)
    IC=-IC;
end

t_bef=0.1;

if isempty(strfind(file2load,'SPK'))
    t_aft=0.95;
else
    t_aft=0.5;
end

if fp==1
    figure
    findpeaks(IC,'MinPeakHeight',3.61*std(IC))
    hold on
    for k=1:numel(labels_exe)
        xline(events_new(k,3)-round(t_bef*fs),'LineWidth',1.5)
        xline(events_new(k,3)+round(t_aft*fs),'LineWidth',1.5,'Color','g');
    end
    yline(3.61*std(IC),'LineWidth',1.5);
    title('GO Stage')
end

% find valid microsegments
for k=1:numel(labels_exe)
    ini=events_new(k,3)-round(t_bef*fs);
    fin=events_new(k,3)+round(t_aft*fs);
    aux_seg(k,:)=ini:fin;
    ini=fin+1;
    if k==numel(labels_exe)
        fin=numel(IC);
    else
        fin=events_new(k+1,3)-round(t_bef*fs)-1;
    end
    aux_seg2(k).seg=ini:fin;
end

contTH=0;
for k=0.5:0.01:6
        contTH=contTH+1;
        [~,all_P]=findpeaks(IC,'MinPeakHeight',k*std(IC));
        contTP=0;
        contFN=0;
        contTN=0;
        contFP=0;
    for k2=1:numel(labels_exe)
            [a,~]=intersect(all_P,aux_seg(k2,:));
            if isempty(a)
                contFN=contFN+1;
            else
                contTP=contTP+1;
            end
            [a,~]=intersect(all_P,aux_seg2(k2).seg);
            if isempty(a)
                contTN=contTN+1;
            else
                contFP=contFP+1;
            end
    end
    TP(contTH)=contTP;
    FN(contTH)=contFN;
    FP(contTH)=contFP;
    TN(contTH)=contTN;
    
    Prec(contTH)=TP(contTH)/(TP(contTH)+FP(contTH));
    Rec(contTH)=TP(contTH)/(TP(contTH)+FN(contTH));
    TPR3(contTH)=TP(contTH)/numel(labels_exe);
     FPR3(contTH)=FP(contTH)/(numel(labels_exe));
    Gmean(contTH)=(TPR3(contTH)*(1-FPR3(contTH)))^(1/2);
end
[~,opt_pt]=max(Gmean);
Prec_opt(1,3)=Prec(opt_pt);
Rec_opt(1,3)=Rec(opt_pt);
Th_opt(1,3)=th_vec(opt_pt);

%% Detect START Stage
clear vars aux_seg TP FN FP TN Pre Rec valid_seg Gmean
IC=ICs( selected_ICs(4),:);
[pksp,~] = findpeaks(IC,'MinPeakHeight',2.8*std(IC));
[pksn,~] = findpeaks(-IC,'MinPeakHeight',2.8*std(IC));
if mean(pksn)>mean(pksp) || isempty(pksp)
    IC=-IC;
end

t_bef=0.15;
t_aft=0.4;
if fp==1
    figure
    findpeaks(IC,'MinPeakHeight',2.49*std(IC))
    hold on
    for k=1:numel(labels_exe)
        xline(events_new(k,4)-round(t_bef*fs),'LineWidth',1.5)
        xline(events_new(k,4)+round(t_aft*fs),'LineWidth',1.5,'Color','g');
    end
    yline(2.49*std(IC),'LineWidth',1.5);
    title('Start Stage')
end

% find valid microsegments
for k=1:numel(labels_exe)
    ini=events_new(k,4)-round(t_bef*fs);
    fin=events_new(k,4)+round(t_aft*fs);
    aux_seg(k,:)=ini:fin;
    ini=fin+1;
    if k==numel(labels_exe)
        fin=numel(IC);
    else
        fin=events_new(k+1,4)-round(t_bef*fs)-1;
    end
    aux_seg2(k).seg=ini:fin;
end

contTH=0;
for k=0.5:0.01:6
        contTH=contTH+1;
        [~,all_P]=findpeaks(IC,'MinPeakHeight',k*std(IC));
        contTP=0;
        contFN=0;
        contTN=0;
        contFP=0;
    for k2=1:numel(labels_exe)
            [a,~]=intersect(all_P,aux_seg(k2,:));
            if isempty(a)
                contFN=contFN+1;
            else
                contTP=contTP+1;
            end
            [a,~]=intersect(all_P,aux_seg2(k2).seg);
            if isempty(a)
                contTN=contTN+1;
            else
                contFP=contFP+1;
            end
    end
    TP(contTH)=contTP;
    FN(contTH)=contFN;
    FP(contTH)=contFP;
    TN(contTH)=contTN;
    
    Prec(contTH)=TP(contTH)/(TP(contTH)+FP(contTH));
    Rec(contTH)=TP(contTH)/(TP(contTH)+FN(contTH));
    TPR4(contTH)=TP(contTH)/numel(labels_exe);
     FPR4(contTH)=FP(contTH)/(numel(labels_exe));
    Gmean(contTH)=(TPR4(contTH)*(1-FPR4(contTH)))^(1/2);
end
[~,opt_pt]=max(Gmean);
Prec_opt(1,4)=Prec(opt_pt);
Rec_opt(1,4)=Rec(opt_pt);
Th_opt(1,4)=th_vec(opt_pt);

%% Detect BEGIN LIFT Stage
clear vars aux_seg TP FN FP TN Pre Rec valid_seg Gmean
IC=ICs( selected_ICs(5),:);
[pksp,~] = findpeaks(IC,'MinPeakHeight',2.8*std(IC));
[pksn,~] = findpeaks(-IC,'MinPeakHeight',2.8*std(IC));
if mean(pksn)>mean(pksp) || isempty(pksp)
    IC=-IC;
end
t_bef=0.15;
t_aft=0.4;
if fp==1
    figure
    findpeaks(IC,'MinPeakHeight',4.04*std(IC))
    hold on
    for k=1:numel(labels_exe)
        xline(events_new(k,6)-round(t_bef*fs),'LineWidth',1.5)
        xline(events_new(k,6)+round(t_aft*fs),'LineWidth',1.5,'Color','g');
    end
    yline(4.04*std(IC),'LineWidth',1.5);
title('Begin Lift Stage')
end

% find valid microsegments
for k=1:numel(labels_exe)
    ini=events_new(k,6)-round(t_bef*fs);
    fin=events_new(k,6)+round(t_aft*fs);
    aux_seg(k,:)=ini:fin;
    ini=fin+1;
    if k==numel(labels_exe)
        fin=numel(IC);
    else
        fin=events_new(k+1,6)-round(t_bef*fs)-1;
    end
    aux_seg2(k).seg=ini:fin;
end

contTH=0;
for k=0.5:0.01:6
        contTH=contTH+1;
        [~,all_P]=findpeaks(IC,'MinPeakHeight',k*std(IC));
        contTP=0;
        contFN=0;
        contTN=0;
        contFP=0;
    for k2=1:numel(labels_exe)
            [a,~]=intersect(all_P,aux_seg(k2,:));
            if isempty(a)
                contFN=contFN+1;
            else
                contTP=contTP+1;
            end
            [a,~]=intersect(all_P,aux_seg2(k2).seg);
            if isempty(a)
                contTN=contTN+1;
            else
                contFP=contFP+1;
            end
    end
    TP(contTH)=contTP;
    FN(contTH)=contFN;
    FP(contTH)=contFP;
    TN(contTH)=contTN;
    
    Prec(contTH)=TP(contTH)/(TP(contTH)+FP(contTH));
    Rec(contTH)=TP(contTH)/(TP(contTH)+FN(contTH));
    TPR5(contTH)=TP(contTH)/numel(labels_exe);
     FPR5(contTH)=FP(contTH)/(numel(labels_exe));
    Gmean(contTH)=(TPR5(contTH)*(1-FPR5(contTH)))^(1/2);
end
[~,opt_pt]=max(Gmean);
Prec_opt(1,5)=Prec(opt_pt);
Rec_opt(1,5)=Rec(opt_pt);
Th_opt(1,5)=th_vec(opt_pt);

%% Detect END LIFT Stage
clear vars aux_seg TP FN FP TN Pre Rec valid_seg Gmean
IC=ICs(selected_ICs(6),:);
[pksp,~] = findpeaks(IC,'MinPeakHeight',2.8*std(IC));
[pksn,~] = findpeaks(-IC,'MinPeakHeight',2.8*std(IC));
if mean(pksn)>mean(pksp) || isempty(pksp)
    IC=-IC;
end
t_bef=0.15;
t_aft=0.4;
if fp==1
    figure
    findpeaks(IC,'MinPeakHeight',3.05*std(IC))
    hold on
    for k=1:numel(labels_exe)
        xline(events_new(k,7)-round(t_bef*fs),'LineWidth',1.5)
        xline(events_new(k,7)+round(t_aft*fs),'LineWidth',1.5,'Color','g');
    end
    yline(3.05*std(IC),'LineWidth',1.5);
    title('End Lift Stage')
end

% find valid microsegments
for k=1:numel(labels_exe)
    ini=events_new(k,7)-round(t_bef*fs);
    fin=events_new(k,7)+round(t_aft*fs);
    aux_seg(k,:)=ini:fin;
    ini=fin+1;
    if k==numel(labels_exe)
        fin=numel(IC);
    else
        fin=events_new(k+1,7)-round(t_bef*fs)-1;
    end
    aux_seg2(k).seg=ini:fin;
end

contTH=0;
for k=0.5:0.01:6
        contTH=contTH+1;
        [~,all_P]=findpeaks(IC,'MinPeakHeight',k*std(IC));
        contTP=0;
        contFN=0;
        contTN=0;
        contFP=0;
    for k2=1:numel(labels_exe)
            [a,~]=intersect(all_P,aux_seg(k2,:));
            if isempty(a)
                contFN=contFN+1;
            else
                contTP=contTP+1;
            end
            [a,~]=intersect(all_P,aux_seg2(k2).seg);
            if isempty(a)
                contTN=contTN+1;
            else
                contFP=contFP+1;
            end
    end
    TP(contTH)=contTP;
    FN(contTH)=contFN;
    FP(contTH)=contFP;
    TN(contTH)=contTN;
    
    Prec(contTH)=TP(contTH)/(TP(contTH)+FP(contTH));
    Rec(contTH)=TP(contTH)/(TP(contTH)+FN(contTH));
    TPR6(contTH)=TP(contTH)/numel(labels_exe);
     FPR6(contTH)=FP(contTH)/(numel(labels_exe));
    Gmean(contTH)=(TPR6(contTH)*(1-FPR6(contTH)))^(1/2);
end
[~,opt_pt]=max(Gmean);
Prec_opt(1,6)=Prec(opt_pt);
Rec_opt(1,6)=Rec(opt_pt);
Th_opt(1,6)=th_vec(opt_pt);

%% Detect REWARD Stage
clear vars aux_seg TP FN FP TN Pre Rec valid_seg Gmean
IC=ICs(selected_ICs(7),:);
[pksp,~] = findpeaks(IC,'MinPeakHeight',2.8*std(IC));
[pksn,~] = findpeaks(-IC,'MinPeakHeight',2.8*std(IC));
if mean(pksn)>mean(pksp) || isempty(pksp)
    IC=-IC;
end
t_bef=0.15;
t_aft=0.7;
if fp==1
    figure
    findpeaks(IC,'MinPeakHeight',2.81*std(IC))
    hold on
    for k=1:numel(labels_exe)
        xline(events_new(k,8)-round(t_bef*fs),'LineWidth',1.5)
        xline(events_new(k,8)+round(t_aft*fs),'LineWidth',1.5,'Color','g');
    end
    yline(2.81*std(IC),'LineWidth',1.5);
    title('Reward Stage')
end

% find valid microsegments
for k=1:numel(labels_exe)
    ini=events_new(k,8)-round(t_bef*fs);
    fin=events_new(k,8)+round(t_aft*fs);
    aux_seg(k,:)=ini:fin;
    ini=fin+1;
    if k==numel(labels_exe)
        fin=numel(IC);
    else
        fin=events_new(k+1,8)-round(t_bef*fs)-1;
    end
    aux_seg2(k).seg=ini:fin;
end

contTH=0;
for k=0.5:0.01:6
        contTH=contTH+1;
        [~,all_P]=findpeaks(IC,'MinPeakHeight',k*std(IC));
        contTP=0;
        contFN=0;
        contTN=0;
        contFP=0;
    for k2=1:numel(labels_exe)
            [a,~]=intersect(all_P,aux_seg(k2,:));
            if isempty(a)
                contFN=contFN+1;
            else
                contTP=contTP+1;
            end
            [a,~]=intersect(all_P,aux_seg2(k2).seg);
            if isempty(a)
                contTN=contTN+1;
            else
                contFP=contFP+1;
            end
    end
    TP(contTH)=contTP;
    FN(contTH)=contFN;
    FP(contTH)=contFP;
    TN(contTH)=contTN;
    
    Prec(contTH)=TP(contTH)/(TP(contTH)+FP(contTH));
    Rec(contTH)=TP(contTH)/(TP(contTH)+FN(contTH));
    TPR7(contTH)=TP(contTH)/numel(labels_exe);
     FPR7(contTH)=FP(contTH)/(numel(labels_exe));
    Gmean(contTH)=(TPR7(contTH)*(1-FPR7(contTH)))^(1/2);
end
[~,opt_pt]=max(Gmean);
Prec_opt(1,7)=Prec(opt_pt)
Rec_opt(1,7)=Rec(opt_pt)
Th_opt(1,7)=th_vec(opt_pt)


figure
plot(FPR1,TPR1,'LineWidth',1.5);
hold on
plot(FPR2,TPR2,'LineWidth',1.5);
plot(FPR3,TPR3,'LineWidth',1.5);
plot(FPR4,TPR4,'LineWidth',1.5);
plot(FPR5,TPR5,'LineWidth',1.5);
plot(FPR6,TPR6,'LineWidth',1.5);
plot(FPR7,TPR7,'LineWidth',1.5);
xlabel('False Positive Rate')
ylabel('True Positive Rate')
title('ROC  Stage Detection - SPK Session 1' )

legend('Object','Grip','Go','Start','Begin Lift','End Lift','Reward','Location','southeast');

FPR=[FPR1;FPR2;FPR3;FPR4;FPR5;FPR6;FPR7];
TPR=[TPR1;TPR2;TPR3;TPR4;TPR5;TPR6;TPR7];
stg_detect_res.FPR=FPR;
stg_detect_res.TPR=TPR;
stg_detect_res.Prec_opt=Prec_opt;
stg_detect_res.Rec_opt=Rec_opt;
stg_detect_res.Th_opt=Th_opt;






