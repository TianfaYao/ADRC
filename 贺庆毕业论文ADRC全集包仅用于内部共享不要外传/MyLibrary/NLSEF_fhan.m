function [sys,x0,str,ts]=NLSEF_fhan(t,x,u,flag,r,h1)

if flag==0
    sys = [0;0;1;2;0;0;1];
    x0 = [];                       
    str = [ ];
    ts = [0 0];
       
elseif flag==3
    sys=-fhan(u(1),u(2),r,h1);
    
else 
    sys=[];
end