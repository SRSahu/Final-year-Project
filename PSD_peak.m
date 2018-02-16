function [ Q,r,c,psd_max ] = PSD_peak(I)
%UNTITLED Summary of this function goes here
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
   periods = minQ(1,1):maxQ(1,1);
% %    r = 3; c= 5;
% %    DC_1 = DC(r:8:end,c:8:end);
%    num4bin = hist(DC_1(:),binHist);
%    [N,Edges] = histcounts(DC_1);
%    hist_fourier = abs(fft(num4bin));   
   
   


   
 %% fourier Spectrum Plot %% 
 
%    figure 
%    plot(hist_fourier); 
%     
%    hist_frq = abs(fft(N));
%    figure 
%    plot(hist_frq);
   
%% Histogram periodicity measure By PSD %% 

periods = minQ(1,1):maxQ(1,1);
% define DFT matrix for frequencies corresponding to integer periods
harmfreq = 1./periods;
IPDFT = exp(-2*pi*i* binHist' * harmfreq);
% hist_fr_spct = num4bin * IPDFT;
% hist_psd = abs(sum(conj(hist_fr_spct)' * hist_fr_spct));
% 
% figure
% plot(hist_psd);
% figure 
% plot(abs(hist_fr_spct));


%% PSD of histogram for different shifts
hst_psd = zeros(8,8,maxQ(1,1)-minQ(1,1)+1);
  for  i_x = 1:8
      for j_y = 1:8
         DC_shift = DC(i_x:8:end,j_y:8:end);
         hist_dc_shift = hist(DC_shift(:),binHist);
         hist_fr_spct = hist_dc_shift * IPDFT;
         hist_psd = abs(sum(conj(hist_fr_spct)' * hist_fr_spct));
         hst_psd(i_x,j_y,:) = hist_psd;
      end
  end

  
for k = 1:length(periods)
    hst_psd_k = hst_psd(:,:,k);
    [maxy,y] = max(hst_psd_k);
    [maxx,x] = max(maxy);
    psd_xy_Q(k,:) = [x,y(x),maxx];    
end

  [b,c] = max(psd_xy_Q(:,3));
  Q = periods(c);
  r = psd_xy_Q(c,1);
  c = psd_xy_Q(c,2);
  psd_max  = psd_xy_Q(c,3);
  
 
% xcv = hst_psd(4,4,:);
% figure
% plot(xcv(1,:))
% temp = xcv(1,:);
% max(temp) 
end

