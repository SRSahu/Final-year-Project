function [ rsz_factor ] = rszFct_psd(I, scales)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if(length(I)>512)
    I = I(1:512,1:512);
end


a = 1;
for rsz_fct = scales 
    reverse_rszfct = 1/rsz_fct;
  
     rvr_rsz_image = imresize(I, reverse_rszfct,'bicubic');    
   
    [Q(a),r(a),c(a),psd_max(a)] = Norm_PSD(rvr_rsz_image);
    a = a+1;
end
  [mx_val,mx_idx] = max(psd_max);
   rsz_factor = scales(mx_idx);
end

