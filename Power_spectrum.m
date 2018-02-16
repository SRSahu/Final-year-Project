
scales = [0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3 1.4];

if(length(I)>512)
    I = I(1:512,1:512);
end


figure
for rsz_fct = scales 
    reverse_rszfct = 1/rsz_fct;
  
     rvr_rsz_image = imresize(I, reverse_rszfct);  
       psd_plot_rvr =  PSD_plot( rvr_rsz_image );
     hold on
      plot(psd_plot_rvr);
      
    %[Q(a),r(a),c(a),psd_max(a)] = Norm_PSD(rvr_rsz_image);
   
end
legend('0.6', '0.7', '0.8', '0.9', '0.95', '1.05', '1.1', '1.2', '1.3', '1.4');
title(['Q_1' num2str(QF_1) 'Q_2' num2str(QF_2) 'R_f' num2str(resize_fact)]);
hold off 




%title(['Q_1' num2str(QF_1) 'Q_2' num2str(QF_2) 'R_f' num2str(resize_fact)]);

     