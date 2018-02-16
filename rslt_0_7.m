 %close all;
 load('exp_rslt_psd.mat');
 load('exp_rslt_piva.mat');
 load('exp_rslt_2ndcom.mat');
 Ot_psd = exp_rslt_psd;
 Ot_piva = exp_rslt_piva;
 forg_dat = exp_rslt_2ndcom;
 resize_fact = [0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3 1.4];
 %resize_fact = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
 %resize_fact = [0.5 0.6 0.7 0.8 0.9 1];
 %QF2 = 50:5:95;
 QF2 = [50:10:90,99];
 %ind_rsz = 1:10;
 ind_Q2 =1:length(QF2); 
 %mapObj = containers.Map(resize_fact,ind_rsz);
 mapObj = containers.Map(QF2,ind_Q2);
 
 for ir = 1:length(Ot_psd)
        [v_psd,I_psd] = max(Ot_psd(:,4,ir));
        [v_piva, I_piva] = min(Ot_piva(:,4,ir));
        rsz_psd = resize_fact(I_psd);
        rsz_piva = resize_fact(I_piva);
        rst_tab(ir,:) = [forg_dat(ir,:),v_psd,rsz_psd,v_piva,rsz_piva];     
 end
 
 %% Ploting the Performance %% 

 TP = zeros(1,length(QF2));
 
 for  a = 1:length(rst_tab)
     if(rst_tab(a,7)==rst_tab(a,14))
        % rst_tab(a,7)
         TP(1,mapObj(rst_tab(a,8))) = TP(1,mapObj(rst_tab(a,8)))+1;
     end
 end
 
 
 
 TP_P = zeros(1,length(QF2));
 for  a = 1:length(rst_tab)
     if(rst_tab(a,7)==rst_tab(a,16))
        % rst_tab(a,7)
         TP_P(1,mapObj(rst_tab(a,8))) = TP_P(1,mapObj(rst_tab(a,8)))+1;
     end
 end
%  TP = TP/(length(rst_tab)/10); 
%  figure
%  plot(resize_fact,TP);
%  hold on
%  %ylim([0,1]);
%  %title('PSD Method');
%   TP_P = TP_P/(length(rst_tab)/10); 
%  %figure
%  plot(resize_fact,TP_P);
%  ylim([0,1]);
% legend('PSD Method','NLDP Method');
% xlabel('Resizing factor');
% ylabel('True Positive Rate');
%  hold off;


 TP = TP/(length(rst_tab)/length(QF2)); 
 figure
 plot(QF2,TP);
 hold on
 %ylim([0,1]);
 %title('PSD Method');
  TP_P = TP_P/(length(rst_tab)/length(QF2)); 
 %figure
 plot(QF2,TP_P);
 ylim([0,1]);
legend('PSD Method','NLDP Method');
xlabel('QF2');
ylabel('True Positive Rate');
 hold off;