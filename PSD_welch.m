function [ S_k ] = PSD_welch( X_n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
   N = length(X_n);
   M = 256;             %%Number of points in each segment or batch size 
   S = M/2;             %%Number of points to shift between segments 
   K = N /(M-S)-1;        %%Number of segment or batches
   i_v = 2:M/2;
   v =  i_v/M;
    m = 1:M;
    kernel = exp(-2*pi*1i* m' * v);
   for k = 1:K 
       st_pt = (k-1)*S +1; 
     dat_seq(k,:) = X_n(st_pt:st_pt+M-1);    
   end

   X_k = dat_seq*kernel;
   P_k = 1/M * (abs(X_k).^2);
   S_k = 1/K *sum(P_k);
%    figure 
% plot(S_k)
   
end

