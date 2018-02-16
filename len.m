function [ len ] = len( X )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
  l = length(X);
  s = 1; e = l;
 while(X(s)==0)
     s= s+1;
 end
 while(X(e)==0)
     e= e-1;
 end
  
 len = e-s;

end

