
function [W,bandpass_filt]=lfp_ICA(data_folder,file2load, N_runs,maxsteps,stopE)

% Script to apply ICA.
%Every time we run ICA you don't get exactly the same W-matrix, there are very small variations, so an alternative is to run the algorithm several times and average the results.  
%N--> number of times the ICA is run
%file2load --> subsampled and merged data (PMv+PMd+MI)
%W_ini --> (optional) initialization matrix, used to obtain the same order of the components


%% Load Data
aux=dir(strcat(data_folder,'\**\',file2load));
full_file2load=strcat(aux.folder,'\',aux.name);
load(full_file2load);
disp(strcat('Performing ICA --> ',full_file2load))

%% Bandpass fIltering
fc1=0.1;             
fc2=4;                  
order=700;          %filter Order
bandpass_filt = designfilt('bandpassfir','FilterOrder',order,'CutoffFrequency1',fc1,'CutoffFrequency2',fc2,'SampleRate',Data_all.fs);
Data=(filtfilt(bandpass_filt,(Data_all.Data)'))';

%% Performing ICA just one time
if N_runs==1
    [weights,sphere,~,~,~,~,~]=runica(Data, 'maxsteps',maxsteps, 'stop',stopE);
    W=weights*sphere;                        % Unmixing matrix
end

%% Performing ICA several times
%Each time ICA is executed, the resulting matrix is not in the same order
%, therefore to order it we can obtain the correlation coefficient between each component and link the components with higher correlation coefficient
if N_runs>1
    for cont=1:N_runs
        [weights,sphere,~,~,~,~,~]=runica(Data, 'maxsteps',1000, 'stop',1e-8, 'reset_randomseed','on');
        W_all(:,:,cont)=weights*sphere;                                                                   % Unmixing matrix
    end
    %   Get correlation to sort each W in the same order
    Comps_1=W_all(:,:,1)*Data;
    for cont=1:(N_runs-1)
        Comps_2=W_all(:,:,cont+1)*Data;
        for cont1=1:size(Comps_1,1)
            for cont2=1:size(Comps_2,1)
                aux=corrcoef(Comps_1(cont1,:),Comps_2(cont2,:));
                R(cont1,cont2,cont)=aux(1,2);
            end
        end
        figure
        imagesc(R(:,:,cont))
        title(strcat('Corrrelation 1-',num2str(cont+1)));
    end

    %% Sorting W
    W_sort(:,:,1)=W_all(:,:,1);
    for cont=1:size(R,3)
        for cont2=1:size(W_all,1)
            [a,b]=max(abs(R(cont2,:,cont)));
            a2=R(cont2,b,cont);
            if a2>0
                W_sort(cont2,:,cont+1)=W_all(b,:,cont+1);
            else
                W_sort(cont2,:,cont+1)=-W_all(b,:,cont+1);
            end
        end
    end
    %% Section to check if the matrices were sorted correctly.
    % Comps_1=W_sort(:,:,1)*Data;
    % for cont3=1:(N_runs-1)
    %     Comps_2=W_sort(:,:,cont3+1)*Data;
    %     for cont1=1:size(Comps_1,1)
    %         for cont2=1:size(Comps_2,1)
    %             aux=corrcoef(Comps_1(cont1,:),Comps_2(cont2,:));
    %             R2(cont1,cont2,cont3)=aux(1,2);
    %         end
    %     end
    %     figure
    %     imagesc(R2(:,:,cont3))
    %     title(strcat('Corrrelation 1-',num2str(cont3+1)));
    % end

    W=mean(W_sort,3);
end
