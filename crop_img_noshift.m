function [ res_img ] = crop_img_noshift( org_img, size )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
   
res_img  = org_img(1:size,1:size);

end

