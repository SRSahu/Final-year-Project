function [derr, err] = jitterfunc(p,delta,N)
%
% [derr, err] = jitterfunc(p,delta,N)
%
% find derivative of error function for jitter delta
% it assumes periodic sinc shaped peak
% used in findjitter
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

x = [-1; 0; 1] + delta;
svec = sincp(x,N);
dsvec = dsincp(x,N);

err = sum(((p*svec)/(svec'*svec) * svec - p').^2);
derr = (p*svec) * (dsvec'*svec)/(svec'*svec) - p*dsvec;

return