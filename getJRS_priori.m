function [minH, Q, k1, k2, scale] = getJRS_priori(I, scales)
%
% [minH, Q, k1, k2, scale] = getJRS_priori(I, scales)
%
% Computation of features able to test whether image I was previously JPEG 
% compressed and resized
% it assumes prior knowledge on resize factor
% algorithm described in 
% Bianchi T., Piva A., "Reverse engineering of double JPEG compression in 
% the presence of image resizing". In: 2012 IEEE International Workshop on 
% Information Forensics and Security, WIFS 2012, Tenerife, Spain, December,
% 2-5, 2012. pp. 127-132.
%
% I: Y component of JPEG image (see JPEGreadY)
% scales: possible resize factors
%
% minH: min-entropy of integer periodicity map
% Q: quantization step of DC coeff of previous JPEG compression
% k1,k2: shift of DCT grid of previous JPEG compression
% scale: detected scale factor
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
[row,col] = size(I);
    if(row>512)
    I = I(1:512,1:512);
    end


minH = 6;
for k = 1:length(scales)
    I2 = imresize(I, 1/scales(k));

    [minHtmp, Qtmp, k1tmp, k2tmp] = minHNA_unq(I2);

    if minHtmp < minH
        minH = minHtmp;
        Q = Qtmp;
        k1 = k1tmp;
        k2 = k2tmp;
        scale = scales(k);
    end
end
                
return