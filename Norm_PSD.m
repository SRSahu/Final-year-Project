function [ Q_n,r_n,c_n,mx_psd ] = Norm_PSD( I )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    minQ = 2;
    maxQ = 16;
    [row,col] = size(I);
    if(row>512)
    I = I(1:512,1:512);
    end
    DC = conv2(I,ones(8)/8);
    DC = DC(8:end,8:end);
   
   binHist = (-2^11:1:2^11-1);
   %periods = minQ(1,1):maxQ(1,1);
   
%% Histogram periodicity measure By PSD %% 

%periods = minQ(1,1):maxQ(1,1);
% define DFT matrix for frequencies corresponding to integer periods
%harmfreq = 1./periods;
freq = 2:128;
harmfreq = freq/256;

%IPDFT = exp(-2*pi*i* binHist' * harmfreq);


%% PSD of histogram for different shifts
%hst_psd = zeros(8,8,maxQ(1,1)-minQ(1,1)+1);
hst_psd = zeros(8,8,length(harmfreq));
%figure
  for  i_x = 1:8
      for j_y = 1:8
         DC_shift = DC(i_x:8:end,j_y:8:end);
         hist_dc_shift = hist(DC_shift(:),binHist);
        
      
        hist_psd = PSD_welch(hist_dc_shift);
        
        
         [max_P, Q_P] = max(hist_psd);
%           plot(hist_psd)
%           hold on
         hst_psd(i_x,j_y,:) = hist_psd;
         hst_Npsd(i_x,j_y,:) = [max_P, Q_P];
      end
  end
%hold off;
  
%% Maximum PSD %%
[max_x, rw] = max(hst_Npsd(:,:,1));
[mx_x, cl] = max(max_x);
  r_n = rw(cl);
  c_n = cl;
  mx_psd = mx_x;
  Q_n = hst_Npsd(r_n,c_n ,2);
  
end

