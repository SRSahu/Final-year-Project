function [ org_img_rgb_1024 ] = crop_1024( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
org_img_Ycbcr = rgb2ycbcr(I);
org_img_Y = org_img_Ycbcr(:,:,1);

[hgh_org, wid_org] = size(org_img_Y);
%xcv = crop_image(org_img_Ycbcr,floor(hgh_org/3), floor(wid_org/3));
org_img_Y_1024 = crop_image(org_img_Y, floor(hgh_org/5), floor(wid_org/5));
org_img_1024(:,:,1) = org_img_Y_1024;
org_img_1024(:,:,2) = crop_image(org_img_Ycbcr(:,:,2),floor(hgh_org/5), floor(wid_org/5));
org_img_1024(:,:,3) = crop_image(org_img_Ycbcr(:,:,3),floor(hgh_org/5), floor(wid_org/5));
org_img_rgb_1024 = ycbcr2rgb(org_img_1024);

end






