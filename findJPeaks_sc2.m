function [P] = findJPeaks_sc2(I)
%
% function [P] = findJPeaks_sc2(I)
%
% compute candidate resize factors for image I
% implements algorithm described in 
% Bianchi T., Piva A., "Reverse engineering of double JPEG compression in 
% the presence of image resizing". In: 2012 IEEE International Workshop on 
% Information Forensics and Security, WIFS 2012, Tenerife, Spain, December,
% 2-5, 2012. pp. 127-132.
% I: Y component of JPEG image (see JPEGreadY)
%
% P.scale: vector of candidate resize factors
%
% Copyright (C) 2012 Signal Processing and Communications Laboratory (LESC),       
% Dipartimento di Elettronica e Telecomunicazioni - Università di Firenze                        
% via S. Marta 3 - I-50139 - Firenze, Italy                   
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
% 
% 
% Additional permission under GNU GPL version 3 section 7
% 
% If you modify this Program, or any covered work, by linking or combining it 
% with Matlab JPEG Toolbox (or a modified version of that library), 
% containing parts covered by the terms of Matlab JPEG Toolbox License, 
% the licensors of this Program grant you additional permission to convey the 
% resulting work. 

[r,c] = size(I);
nfft = 2^ceil(log2(max(r,c)));


h = [-1 2 -1]/2;
 
th_mult = 1.2;

% computed derivatives
M1 = abs(imfilter(I,h,'symmetric'));
M2 = abs(imfilter(I,h','symmetric'));
A1 = zeros(1,nfft);
A2 = zeros(nfft,1);
% cumulate derivatives along rows and columns
A1(1:c) = sum(M1,1);
A2(1:r) = sum(M2,2);
% remove bias
A1 = A1 - mean(A1);
A2 = A2 - mean(A2);

% spectrum of cumulated derivatives
F1 = fft(A1);
F2 = fft(A2);

% normalize spectrum according to median filtered value
F1 = F1./medfilt2(abs(F1), [1 11]);
F1(~isfinite(F1)) = 0;

F2 = F2./medfilt2(abs(F2), [11 1]);
F2(~isfinite(F2)) = 0;

% sum horizontal and vertical spectra (assume same resize factor)
Mscale = abs(F1(1:nfft/4)) + abs(F2(1:nfft/4))';

% find peaks of spectrum (candidate resize factors)
[m, idxcand] = sort(Mscale, 'descend');

P.scale = [];
th = th_mult*median(Mscale);
for k = idxcand
    if k > 5*nfft/64 && k < nfft/4
        if Mscale(k) > th && Mscale(k) > Mscale(k-1) && Mscale(k) > Mscale(k+1)
      
            scale = k - 1 - findjitter(Mscale(k-1:k+1), nfft);
            P.scale = [P.scale nfft/scale/8];
         
        end
    end
end



return