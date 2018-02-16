function [delta] = Esti_resize_fact(I, verbose)
%
% compute delta feature as described in the paper
% M. Kirchner and T. Gloe, “On resampling detection in re-compressed
% images,” in First IEEE International Workshop on Information Forensics
% and Security, 2009, December 2009, pp. 21–25.
%
% I: Y component of JPEG image (see JPEGreadY)
% verbose: flag to plot debugging information
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

if nargin < 2
    verbose = false;
end

[r,c] = size(I);
nfft = 2^ceil(log2(max(r,c)));
gam = 4;
W = 4;
medW = [7 7];

h = [0 -1 0;...
    -1 4 -1;...
     0 -1 0]/4;
 
M = imfilter(I,h,'symmetric');
M = exp(-M.^2);
% M = M - mean(M(:));
A = zeros(nfft);
A(1:r,1:c) = M;

if verbose
    figure, imshow(A, [])
    % pause
end

F = abs(fftshift(fft2(A)));
F = F./medfilt2(F, medW);
F(~isfinite(F)) = 0;

Fmaxf = ordfilt2(F,(2*W+1)^2,ones(2*W+1,2*W+1));
idx = (F == Fmaxf);
Fmax = zeros(size(F));
Fmax(idx) = F(idx);

Fmax(1:nfft/8:end,1:nfft/8:end) = 0;
maxF = max(Fmax(:));
Fmax = maxF * (Fmax / maxF).^gam;

if verbose
    figure, imshow(Fmax.^0.5, [])
    % pause
end

[TH, RH] = meshgrid((0:1/nfft:2-1/nfft)*pi, nfft/8+1:nfft/2-1);
[XI, YI] = pol2cart(TH, RH);

[X, Y] = meshgrid(-nfft/2:nfft/2-1, -nfft/2:nfft/2-1);
Fpol = interp2(X,Y,Fmax,XI,YI);

if verbose
    figure, imshow(Fpol.^0.5, [])
    % pause
end

Fpol = sort(Fpol, 2, 'descend');
sigR = sum(Fpol(:,1:4), 2);

if verbose
    figure, plot(sigR)
    % pause
end

% sigR
% max(sigR)
% median(sigR)
delta = max(sigR) / median(sigR);

return