close all; 
%% Reading the Doubly Compressed Image %% 
image = rgb2ycbcr(imread('double_compress_resized.jpg'));
image_Y = image(:,:,1);
%% Estimate the Resizing factor
resize_fct = [0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3 1.4];
%resize_fct = [0.5 0.6 0.7 0.8 0.9 1];
a = 1 ;
%tic
for rsz_fct = resize_fct 
    reverse_rszfct = 1/rsz_fct;
   % tic
    %rvr_rsz_image = Resize_Arb(image_Y, reverse_rszfct, reverse_rszfct);
    
     rvr_rsz_image = imresize(image_Y, reverse_rszfct);    %toc
   %  rvr_rsz_image1 = imresize(image_Y, reverse_rszfct);
    [Q(a),r(a),c(a),psd_max(a)] = Norm_PSD(rvr_rsz_image);
    
   % [min_HNA(a), Q1(a),r1(a),c1(a)] = minHNA_unq(rvr_rsz_image1); 
    a = a+1;
end
%toc