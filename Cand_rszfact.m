function [ output_args ] = Cand_rszfact( I )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
  g = [-1/2,1,1/2];
  [r,c] = size(I); 
  nfft = 2^ceil(log2(max(r,c)));
  
%% Horizontal and Vertical Second derivative %%
  for h = 1:r
      X_h(h,:) = imfilter(I(h,:),g,'symmetric');
  end
  for v = 1:c
      X_v(:,v) = imfilter(I(:,v),g','symmetric');
  end
 
%% Average the horizontal and vertical derivative %% 
   a_h = sum(X_h)';
   a_v = sum(X_v);
   a_h = a_h - mean(a_h);
   a_v = a_v - mean(a_v);
   
%% DFT of second order derivative %% 
    f_h = fft(a_h)./medfilt2(fft(a_h),[1 11]);
    f_v = fft(a_v)./medfilt2(fft(a_v),[1 11]);

    f_h(~isfinite(f_h)) = 0;
    f_v(~isfinite(f_v)) = 0;
    
    f_k = abs(f_h(1:nfft/4))+abs(f_v(1:nfft/4));
    figure 
 plot(log(f_k))
end

