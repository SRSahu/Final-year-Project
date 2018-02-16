
%% == ploting the performance for ecah image == %%
% rsz_psd = result_psd(:,5);
% for i = 1:300:length(result_psd)
%     figure
% plot(rsz_psd(i:i+300-1));
% title(['img_num' num2str(result_psd(i,1))]);
% end
% srcFiles = dir('.\DRESDEN_tif\*.tiff');
% xb = [8];
% for img_num = xb
%     filename = strcat('.\DRESDEN_tif\',srcFiles(img_num).name);
%     delete(filename);
%     
% end

%% == comparing the PSD of 1d sequence == %%
% clear all; close all ; clc;
% load('sec_com_Y.mat');
% I = sec_com_Y;
% I_512 = sec_com_Y(1,1:512);
% figure
% histogram(I_512);
% I_1st = first_comp_Y;
% figure
% histogram(I_1st(1:512));
% I_rsz = imresize(I_512,1/0.7);
% 
% figure 
% histogram(I_rsz(1:512));

%% == combining All the Data(Both uncompressed and DRESDEN) == %%

% clear all ; close all;
% 
% per_ALLQ2_uncom_raise_final_PSD = xlsread('per_ALLQ2_uncom_raise_final_PSD.xlsx');
% per_ALLQ2_uncom_raise_final_NLDP = xlsread('per_ALLQ2_uncom_raise_final_NLDP.xlsx');
% per_ALLQ2_dresden_final_PSD = xlsread('per_ALLQ2_dresden_final_PSD.xlsx');
% per_ALLQ2_dresden_final_NLDP = xlsread('per_ALLQ2_dresden_final_NLDP.xlsx');
% 
% per_ALLQ2_dresden_final_PSD = [per_ALLQ2_dresden_final_PSD(:,1)+52,per_ALLQ2_dresden_final_PSD(:,2:5)];
% 
% rslt_psd_final = [per_ALLQ2_uncom_raise_final_PSD;per_ALLQ2_dresden_final_PSD];
% xlswrite('rslt_psd_final.xlsx',rslt_psd_final);
% 
% per_ALLQ2_dresden_final_NLDP = [per_ALLQ2_dresden_final_NLDP(:,1)+52,per_ALLQ2_dresden_final_NLDP(:,2:5)];
% rslt_nldp_final = [per_ALLQ2_uncom_raise_final_NLDP;per_ALLQ2_dresden_final_NLDP];
% xlswrite('rslt_nldp_final.xlsx',rslt_nldp_final);

%% == Performance for Different QF2 == %%
clear all; close all; 
result_psd = xlsread('rslt_psd_final.xlsx');
result_nldp = xlsread('rslt_nldp_final.xlsx');

resize_fact = [0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3 1.4];
ind_rsz = 1:10;
QF1 = 50:10:90; 
QF2 = [50:10:90,99];
ind_qf2 = 1:length(QF2);
mapObj_QF2 = containers.Map(QF2,ind_qf2);
TPR_psd_QF2 = zeros(1,length(QF2));
for i = 1:length(result_psd)
    if(result_psd(i,4)==result_psd(i,5) && result_psd(i,4) == 1.2 )
        TPR_psd_QF2(1,mapObj_QF2(result_psd(i,3))) = TPR_psd_QF2(1,mapObj_QF2(result_psd(i,3))) +1;
    end
end

TPR_nldp_QF2 = zeros(1,length(QF2));
for i = 1:length(result_nldp)
    if(result_nldp(i,4)==result_nldp(i,5) && result_psd(i,4) == 1.2 )
        TPR_nldp_QF2(1,mapObj_QF2(result_nldp(i,3))) = TPR_nldp_QF2(1,mapObj_QF2(result_nldp(i,3))) +1;
    end
end

figure 
plot(QF2,TPR_psd_QF2/(length(result_psd)/(length(QF2)*length(resize_fact))));
hold on
plot(QF2,TPR_nldp_QF2/(length(result_nldp)/(length(QF2)*length(resize_fact))));
%ylim([0,0.1]);
xlabel('QF2');
ylabel('True Positive rate');
legend('Proposed Method','NLDP Method');
hold off 


%% == Error Ploting == %%

% 
% clear all; close all; 
% result_psd = xlsread('rslt_psd_final.xlsx');
% result_nldp = xlsread('rslt_nldp_final.xlsx');
% 
% resize_fact = [0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3 1.4];
% ind_rsz = 1:10;
% QF1 = 50:10:90; 
% QF2 = [50:10:90,99];
% ind_qf2 = 1:length(QF2);
% mapObj_QF2 = containers.Map(QF2,ind_qf2);
% err_psd_QF2 = zeros(1,length(QF2));
% for i = 1:length(result_psd)
%     err = abs(result_psd(i,4)-result_psd(i,5))/result_psd(i,4);
%         err_psd_QF2(1,mapObj_QF2(result_psd(i,3))) = err_psd_QF2(1,mapObj_QF2(result_psd(i,3))) + err;   
% end
% 
% err_nldp_QF2 = zeros(1,length(QF2));
% for i = 1:length(result_nldp)
%     err_p = abs(result_nldp(i,4)-result_nldp(i,5))/result_nldp(i,4);
%         err_nldp_QF2(1,mapObj_QF2(result_nldp(i,3))) = err_nldp_QF2(1,mapObj_QF2(result_nldp(i,3))) + err_p;    
% end
% 
% figure 
% plot(QF2,err_psd_QF2/(length(result_psd)/(length(QF2))));
% hold on
% plot(QF2,err_nldp_QF2/(length(result_nldp)/length(QF2)));
% ylim([0.1,0.4]);
% xlabel('QF2');
% ylabel('mean absolute Error');
% legend('PSD Method','NLDP Method');
% hold off 



%% == Error ploting for different Resize factor == %% 


clear all; close all; 
result_psd = xlsread('rslt_psd_final.xlsx');
result_nldp = xlsread('rslt_nldp_final.xlsx');

resize_fact = [0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3 1.4];
ind_rsz = 1:10;
QF1 = 50:10:90; 
QF2 = [50:10:90,99];
ind_qf2 = 1:length(QF2);
mapObj_rsz = containers.Map(resize_fact,ind_rsz);

err_psd_rsz = zeros(1,length(resize_fact));
for i = 1:length(result_psd)
    err = abs(result_psd(i,4)-result_psd(i,5))/result_psd(i,4);
        err_psd_rsz(1,mapObj_rsz(result_psd(i,4))) = err_psd_rsz(1,mapObj_rsz(result_psd(i,4))) + err;   
end

err_nldp_rsz = zeros(1,length(resize_fact));
for i = 1:length(result_nldp)
    err_p = abs(result_nldp(i,4)-result_nldp(i,5))/result_nldp(i,4);
        err_nldp_rsz(1,mapObj_rsz(result_nldp(i,4))) = err_nldp_rsz(1,mapObj_rsz(result_nldp(i,4))) + err_p;    
end

figure 
plot(resize_fact,err_psd_rsz/(length(result_psd)/(length(resize_fact))));
hold on
plot(resize_fact,err_nldp_rsz/(length(result_nldp)/length(resize_fact)));
ylim([0.1,1]);
xlabel('resize factor');
ylabel('mean absolute Error');
legend('PSD Method','NLDP Method');
hold off 
























