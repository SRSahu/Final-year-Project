function [ output_args ] = candit_rszfact( I )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[r,c] = size(I);
nfft = 2^ceil(log2(max(r,c)));


h = [-1 2 -1]/2;
 
th_mult = 1.2;

%% computed derivatives
M1 = abs(imfilter(I,h,'symmetric'));
M2 = abs(imfilter(I,h','symmetric'));
A1 = zeros(1,nfft);
A2 = zeros(nfft,1);
%% cumulate derivatives along rows and columns
A1(1:c) = sum(M1,1);
A2(1:r) = sum(M2,2);
% remove bias
A1 = A1 - mean(A1);
A2 = A2 - mean(A2);

%% spectrum of cumulated derivatives
F1 = fft(A1);
F2 = fft(A2);

%% normalize spectrum according to median filtered value
F1 = F1./medfilt2(abs(F1), [1 11]);
F1(~isfinite(F1)) = 0;

F2 = F2./medfilt2(abs(F2), [11 1]);
F2(~isfinite(F2)) = 0;

%% sum horizontal and vertical spectra (assume same resize factor)
Mscale = abs(F1(1:nfft/4)) + abs(F2(1:nfft/4))';

end

