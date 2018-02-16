function [ shift_image ] = crop_img( org_img, shift_image, area_crop )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [row,col] = size(shift_image);
    cntr_pxl = (1/2)*[row,col];
    crop_size = area_crop.*[row,col];
    st_row = cntr_pxl(1)-(crop_size(1)/2)+1;
    st_col = cntr_pxl(2)-(crop_size(2)/2)+1;
    shift_image(st_row:st_row+crop_size(1), st_col:st_col+crop_size(2))= org_img(st_row+20:st_row+20+crop_size(1), st_col+25:st_col+25+crop_size(2));

end

