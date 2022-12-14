    clear all
    
data_folder=pwd;

    figure('Position',[100 40 1200 940]);
    e1=subplot('Position',[0.07 0.67 0.85 0.29]);
    e2=subplot('Position',[0.1 0.43 0.35 0.16]);
    e3=subplot('Position',[0.54 0.43 0.35 0.16]);
    e4=subplot('Position',[0.1 0.24 0.35 0.16]);
    e5=subplot('Position',[0.54 0.24 0.35 0.16]);
    e6=subplot('Position',[0.1 0.05 0.35 0.16]);    
    e7=subplot('Position',[0.54 0.05 0.35 0.16]);
    
    file2load='SPK_all_121004_250_rev1.mat';
    aux=dir(strcat(data_folder,'\**\',file2load));
    full_file2load=strcat(aux.folder,'\',aux.name);
    load(full_file2load)        
    
    w2load='W_ICA_SPK121004.mat';
    aux=dir(strcat(data_folder,'\**\',w2load));
    full_w2load=strcat(aux.folder,'\',aux.name);
    load(full_w2load);                                                   % Load unmixing matrix
    Data=(filtfilt(bandpass_filt,Data_all.Data'))';      % Bandpass filtering
    selec_comps=[13 38 17 3 21 14 4];
    
    fs=Data_all.fs;
    events_exe=Data_all.events_exe;
    time=(1:size(Data,2))/fs;
    ic=selec_comps(4);                                      % Selec component
    [~,b]=sort(abs(W(ic,:)),'descend');              % Get index of descent sorting
    W_selec=W(ic,b);                                         % Sort W descend
    Data_selec=Data(b,:);                                  % Sort Data descend              
    pattern=W_selec*Data_selec;
    
    axes(e1)
    plot(time,pattern,'k','LineWidth',2.5);hold on 
    k=15;
    sign_temp=W_selec(1:k)*Data_selec(1:k,:);
    plot(time,sign_temp,'Color',[1 0.6 0.4])
    k=30;
    sign_temp=W_selec(1:k)*Data_selec(1:k,:);
    plot(time,sign_temp,'g')
	k=45;
    sign_temp=W_selec(1:k)*Data_selec(1:k,:);
    plot(time,sign_temp,'Color',[0 0.4 1])
  	k=60;
    sign_temp=W_selec(1:k)*Data_selec(1:k,:);
    plot(time,sign_temp,'Color','r')
    
    xline(events_exe(k,4),'--b','LineWidth',1.5);
    
    for k=2:size(events_exe,1)
        xline(events_exe(k,4),'--b','HandleVisibility','off','LineWidth',1.5);
    end
    xlim([87 110])
    
    legend('192 chs','15 chs','30 chs','45 chs','60 chs','Ext Marker','Location','southeast')
    xlabel('time(s)')
    %title('Monkey A, Recording 4, Start Component ')
    ylabel('IC amplitude')

    %% Segunda parte
clear vars b Data Data_selec events_exe fs ic k pattern selec_comps sign_temp time W W_selec

load('IC_contrib_SPK.mat')
load('IC_contrib_RUS.mat')
ns={'Spk-R1','Spk-R2','Spk-R3','Spk-R4','Spk-R5','Rus-R1','Rus-R2','Rus-R3','Rus-R4','Rus-R5'};

%% Promediado
for k=1:5
    aux_spk(:,:,k)=dist_SPK(k).dist;
    aux_rus(:,:,k)=dist_RUS(k).dist;
end
mean_spk=mean(aux_spk,3);
avg_spk_prep=mean(mean_spk(1:2,:));
avg_spk_exe=mean(mean_spk(3:7,:));

mean_rus=mean(aux_rus,3);
avg_rus_prep=mean(mean_rus(1:2,:));
avg_rus_exe=mean(mean_rus(3:7,:));

axes(e2)
plot(avg_spk_prep);
hold on;
plot(avg_spk_exe);
ylim([0 1]);
legend('Planing','Execution')
%title('Similarity between final component and waveforms created by adding channels.')
ylabel('Correlation')

axes(e3)
plot(avg_rus_prep);
hold on;
plot(avg_rus_exe);
ylim([0 1]);
legend('Planing','Execution')
%title('Similarity between final component and waveforms created by adding channels.')
ylabel('Correlation')

%% Contribution from each area SPK

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


PMv=[97:192];

for s=1:5       %Mirar 5 sesiones
    orden=dist_SPK(s).orden;
    for ic=1:7
        for ch=1:192
            aux=orden(ic,ch);
            
            if any(MI(:) == aux)
                cont_MI(ic,ch,s)=1;
                cont_PMd(ic,ch,s)=0;
                cont_PMv(ic,ch,s)=0;
            end

            if any(PMd(:) == aux)
                cont_MI(ic,ch,s)=0;
                cont_PMd(ic,ch,s)=1;
                cont_PMv(ic,ch,s)=0;
            end
            
            if any(PMv(:) == aux)
                cont_MI(ic,ch,s)=0;
                cont_PMd(ic,ch,s)=0;
                cont_PMv(ic,ch,s)=1;
            end            
        end
    end
    
end

cont_MI=mean(cont_MI,3);
plan_contr_MI= mean(cont_MI(1:2,:),1);
exe_contr_MI= mean(cont_MI(3:7,:),1);

cont_PMv=mean(cont_PMv,3);
plan_contr_PMv= mean(cont_PMv(1:2,:),1);
exe_contr_PMv= mean(cont_PMv(3:7,:),1);

cont_PMd=mean(cont_PMd,3);
plan_contr_PMd= mean(cont_PMd(1:2,:),1);
exe_contr_PMd= mean(cont_PMd(3:7,:),1);

axes(e4)
plot(cumsum(plan_contr_MI)*100/48)
hold on
plot(cumsum(plan_contr_PMd)*100/48)
plot(cumsum(plan_contr_PMv)*100/96)
%title('Area contribution in planning stages')
ylabel('% Chs contribution')
legend ('MI','PMd','PMv','Location','southeast')
ylim([0 100])

axes(e6)
plot(cumsum(exe_contr_MI)*100/48)
hold on
plot(cumsum(exe_contr_PMd)*100/48)
plot(cumsum(exe_contr_PMv)*100/96)
%title('Area contribution in execution stages')
xlabel('Channels')   
ylabel('% Chs contribution')
legend ('MI','PMd','PMv','Location','southeast')
ylim([0 100])

%% Contribution from each area RUSTY

PMd=[6,8:32,46,50,52,54:64,89:96];
MI=[1:5,7,33:45,47,48,49,51,53,65:88];
PMv=[97:192];

for s=1:5       %Mirar 5 sesiones
    orden=dist_RUS(s).orden;
    for ic=1:7
        for ch=1:192
            aux=orden(ic,ch);
            
            if any(MI(:) == aux)
                cont_MI(ic,ch,s)=1;
                cont_PMd(ic,ch,s)=0;
                cont_PMv(ic,ch,s)=0;
            end

            if any(PMd(:) == aux)
                cont_MI(ic,ch,s)=0;
                cont_PMd(ic,ch,s)=1;
                cont_PMv(ic,ch,s)=0;
            end
            
            if any(PMv(:) == aux)
                cont_MI(ic,ch,s)=0;
                cont_PMd(ic,ch,s)=0;
                cont_PMv(ic,ch,s)=1;
            end            
        end
    end
    
end

cont_MI=mean(cont_MI,3);
plan_contr_MI= mean(cont_MI(1:2,:),1);
exe_contr_MI= mean(cont_MI(3:7,:),1);

cont_PMv=mean(cont_PMv,3);
plan_contr_PMv= mean(cont_PMv(1:2,:),1);
exe_contr_PMv= mean(cont_PMv(3:7,:),1);

cont_PMd=mean(cont_PMd,3);
plan_contr_PMd= mean(cont_PMd(1:2,:),1);
exe_contr_PMd= mean(cont_PMd(3:7,:),1);

axes(e5)
plot(cumsum(plan_contr_MI)*100/48)
hold on
plot(cumsum(plan_contr_PMd)*100/48)
plot(cumsum(plan_contr_PMv)*100/96)
%title('Area contribution in planning stages')
ylabel('% Chs contribution')
legend ('MI','PMd','PMv','Location','southeast')
ylim([0 100])

axes(e7)
plot(cumsum(exe_contr_MI)*100/48)
hold on
plot(cumsum(exe_contr_PMd)*100/48)
plot(cumsum(exe_contr_PMv)*100/96)
%title('Area contribution in execution stages')
xlabel('Channels')   
ylabel('% Chs contribution')
legend ('MI','PMd','PMv','Location','southeast')
ylim([0 100])
    
