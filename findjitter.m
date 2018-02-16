function [jitter] = findjitter(p,N)
%
% [jitter] = findjitter(p,N)
%
% find exact location of FFT peak (used in findJPeaks_sc2)
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

eps = 1e-4;
if p(3) > p(1)
    if jitterfunc(p,-eps,N) < 0
        jitter = -eps/2;
    elseif jitterfunc(p,-0.5,N) > 0
        jitter = -0.5;
    else
        jitter = fzero(@(x) jitterfunc(p,x,N), [-0.5, -eps]);
    end
elseif p(1) > p(3)
    if jitterfunc(p,eps,N) > 0
        jitter = eps/2;
    elseif jitterfunc(p,0.5,N) < 0
        jitter = 0.5;
    else
        jitter = fzero(@(x) jitterfunc(p,x,N), [eps, 0.5]);
    end
else
    jitter = 0;
end

return