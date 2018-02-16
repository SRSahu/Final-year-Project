ix = 1;
 tmp_x = ones(10,1)*rst_tab(ix,:);
    psd_obs40 = [tmp_x,exp_rslt_psd(:,:,1)]; 
    ix = 2;
for it = 2:length(exp_rslt_psd)
    %tmp_x = ix*ones(10,1);
    tmp_x = ones(10,1)*rst_tab(ix,:);
    psd_obs40 = [psd_obs40;tmp_x,exp_rslt_psd(:,:,it)]; 
    ix = ix+1;
    
end
xlswrite('psd_obs40.xlsx',psd_obs40);