function [ hist_psd ] = PSD_plot( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[row,col] = size(I);
    if(row>512)
    I = I(1:512,1:512);
    end
    DC = conv2(I,ones(8)/8);
    DC = DC(8:end,8:end);
   binHist = (-2^11:1:2^11-1);
   i_x = 1; j_y = 1;
   DC_shift = DC(i_x:8:end,j_y:8:end);
         hist_dc_shift = hist(DC_shift(:),binHist);
        hist_psd = PSD_welch(hist_dc_shift);
%        figure 
%         plot(hist_psd);
end

