function [ band_matrix ] = band_matrix( image_spatial,row,col)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here  
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
  dct_image = blockproc(image_spatial,[8 8],dct);
  %dct_image = bdct2(image_spatial,8);
  [len,wid] = size(dct_image);
  band_matrix = dct_image(row:8:len,col:8:wid);
end

