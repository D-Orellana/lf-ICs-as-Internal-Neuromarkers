

function class_res=obj_classification(data_folder,trials2class,N)
    %event=1 --> Object Classification
    %event=2 --> Grip classificationwih TC object
    %event=3 --> Grip classificationwih KG object
    % N= number of runs por statistical validation

win=12;      %long ventana = N*1000/250  = tiempo en ms
p=0.7;          % data percentage for training
    
labels_exe=trials2class.labels_exe;
Trials_p1=trials2class.Trials_p1;
Trials_p2=trials2class.Trials_p2;
ix_c1=[find(labels_exe==11) find(labels_exe==12)];
ix_c2=[find(labels_exe==21) find(labels_exe==23)];
labels=labels_exe;
labels(ix_c1)=1;
labels(ix_c2)=2;
title_text=strcat('Object Classification', ', N=',num2str(N),', win=',num2str(win));

%% Classification first segment
cont=0;
    for kt=win+1:round(win/2):size(Trials_p1,2)         % time counter
        cont=cont+1;
            ini=kt-win;
            fin=kt-1;
            feat_aux=(squeeze(mean(Trials_p1(:,ini:fin,:),2)))';
        for kN=1:N
                aux=randperm(size(Trials_p1,3));
                ix_train=aux(1:round(p*numel(aux)));
                ix_test=aux(round(p*numel(aux))+1:end);

                train_set=feat_aux(ix_train,:);
                test_set=feat_aux(ix_test,:);

                train_labels=labels(ix_train);
                test_labels=labels(ix_test);
                LDA = fitcdiscr(train_set,train_labels,'DiscrimType', 'linear','Gamma', 0,'FillCoeffs', 'off','ClassNames', unique(train_labels),'discrimType','diaglinear');
                pred_temp(kN,:)=LDA.DeltaPredictor;
                acc_temp=100*(1-loss(LDA,test_set,test_labels'));
                 acc_obj_1p(cont,kN) =acc_temp;
                 
                 rand_labels=test_labels(randperm(length(test_labels)));
                 acc_temp=100*(1-loss(LDA,test_set,rand_labels'));
                 acc_ch(cont,kN) =acc_temp;
        end
        pred_importance_p1(cont,:)=mean( pred_temp);
    end

    %% Empirical chance
acc_ch = acc_ch(any(acc_ch,2),:);
emp_chance=mean(mean(acc_ch,1));
emp_chance_std=mean(std(acc_ch,1));

%% Second part
cont=0;
    for kt=win+1:round(win/2):size(Trials_p2,2)         % time counter
        cont=cont+1;
            ini=kt-win;
            fin=kt-1;
            feat_aux=(squeeze(mean(Trials_p2(:,ini:fin,:),2)))';
        for kN=1:N
                aux=randperm(size(Trials_p2,3));
                ix_train=aux(1:round(p*numel(aux)));
                ix_test=aux(round(p*numel(aux))+1:end);

                train_set=feat_aux(ix_train,:);
                test_set=feat_aux(ix_test,:);

                train_labels=labels(ix_train);
                test_labels=labels(ix_test);
                LDA = fitcdiscr(train_set,train_labels,'DiscrimType', 'linear','Gamma', 0,'FillCoeffs', 'off','ClassNames', unique(train_labels),'discrimType','diaglinear');
                pred_temp(kN,:)=LDA.DeltaPredictor;
                acc_temp=100*(1-loss(LDA,test_set,test_labels'));
                 acc_obj_2p(cont,kN) =acc_temp;
                 
                 rand_labels=test_labels(randperm(length(test_labels)));
                 acc_temp=100*(1-loss(LDA,test_set,rand_labels'));
                 acc_ch(cont,kN) =acc_temp;
        end
        pred_importance_p2(cont,:)=mean( pred_temp);
    end

%% PLOT
obj_1p = acc_obj_1p(any(acc_obj_1p,2),:);
obj_2p = acc_obj_2p(any(acc_obj_2p,2),:);

media1=(mean(obj_1p,2))';
media2=(mean(obj_2p,2))';
t1=linspace(-1,3,numel(media1));
t2=linspace(-1,3,numel(media2));

std_c1=(std(obj_1p,0,2))';
std_c2=(std(obj_2p,0,2))';

figure('Position',[100 500 700 400])
plot(t1,media1,'r'); hold on;
plot(t1,media1-std_c1,'Color',[0.65 0.81 0.94]);
plot(t1,media1+std_c1,'Color',[0.65 0.81 0.94]);

plot(t2+4.5,media2,'r');
plot(t2+4.5,media2-std_c2,'Color',[0.65 0.81 0.94]);
plot(t2+4.5,media2+std_c2,'Color',[0.65 0.81 0.94]);

yline(emp_chance+emp_chance_std,'--k','Linewidth',1.5)
yline(emp_chance-emp_chance_std,'--k','Linewidth',1.5)
xline(0,'Linewidth',1.2,'Color','k');

xline(1,'Linewidth',1.2,'Color','k');
xline(3,'Linewidth',1.2,'Color','k');
xline(4.5,'Linewidth',1.2,'Color','k');
xlabel('time(s)');  ylabel('Accuracy (%)');

ylim([0 100])
xticks([-1 0 1 2 3 3.5 4.5 5.5 6.5 7.5])
xticklabels({'-1','0','1','2','3','-1','0','1','2','3'})
title(title_text)


class_res.accuracy_p1=acc_obj_1p;
class_res.accuracy_p2=acc_obj_2p;
class_res.chance=acc_ch;
class_res.N=N;
class_res.win=win;
class_res.p=p;
class_res.pred_importance_p1=pred_importance_p1;
class_res.pred_importance_p2=pred_importance_p2;



