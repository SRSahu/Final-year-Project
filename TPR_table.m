clear all ; close all; 
result_psd = xlsread('rslt_psd_0_5.xlsx');
result_nldp = xlsread('rslt_nldp_0_5.xlsx');
resize_fact = [0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3 1.4];
resize_fact = [0.5 0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3];
ind_rsz = 1:10;
QF1 = 50:10:90; 
QF2 = [50:10:90,99];
mapObj_rszfct = containers.Map(resize_fact,ind_rsz);
mapObj_QF1 = containers.Map(QF1,1:5);
mapObj_QF2 = containers.Map(QF2,1:6);
rslt_table_psd = zeros(length(QF1),length(QF2),length(resize_fact));
rslt_table_nldp = zeros(length(QF1),length(QF2),length(resize_fact));
for i = 1:length(result_psd)
    if(result_psd(i,4)==result_psd(i,5))
        rslt_table_psd(mapObj_QF1(result_psd(i,2)), mapObj_QF2(result_psd(i,3)),mapObj_rszfct(result_psd(i,4)))= rslt_table_psd(mapObj_QF1(result_psd(i,2)), mapObj_QF2(result_psd(i,3)),mapObj_rszfct(result_psd(i,4)))+1;
    end
end

for i = 1:length(result_nldp)
    if(result_nldp(i,4)==result_nldp(i,5))
        rslt_table_nldp(mapObj_QF1(result_nldp(i,2)), mapObj_QF2(result_nldp(i,3)),mapObj_rszfct(result_nldp(i,4)))= rslt_table_nldp(mapObj_QF1(result_nldp(i,2)), mapObj_QF2(result_nldp(i,3)),mapObj_rszfct(result_nldp(i,4)))+1;
    end
end
TPR_PSD =  rslt_table_psd / (length(result_psd)/(length(QF1)*length(QF2)*length(resize_fact)));
TPR_nldp = rslt_table_nldp / (length(result_psd)/(length(QF1)*length(QF2)*length(resize_fact)));
TPR_psd_apnd = resize_fact(1)*ones(1,6);
for j = 1:length(resize_fact)
    TPR_psd_apnd = [TPR_psd_apnd;TPR_PSD(:,:,j);resize_fact(j)*ones(1,6);];
end
xlswrite('TPR_psd_0_5.xlsx',TPR_psd_apnd);


TPR_nldp_apnd = resize_fact(1)*ones(1,6);
for j = 1:length(resize_fact)
    TPR_nldp_apnd = [TPR_nldp_apnd;TPR_nldp(:,:,j);resize_fact(j)*ones(1,6);];
end
xlswrite('TPR_nldp_0_5.xlsx',TPR_nldp_apnd);