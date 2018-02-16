function [ res_image ] = crop_image( image, x_shift, y_shift )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 %res_img_size = [1024,1024];
  %res_image = image(1+x_shift:x_shift+res_img_size(1), 1+y_shift:y_shift+res_img_size(2));
  res_image = image(1+x_shift:end,1+y_shift:end,:); 
end

