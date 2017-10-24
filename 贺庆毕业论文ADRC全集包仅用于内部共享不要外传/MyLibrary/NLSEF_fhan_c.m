function [sys,x0,str,ts]=NLSEF_fhan_c(t,x,u,flag,c,r2,h2)

if flag==0
    sys = [0;0;1;2;0;1;1];
    x0 = [];                       
    str = [ ];
    ts = [0 0];
       
elseif flag==3
    sys=-fhan(u(1),c*u(2),r2,h2);
    
else 
    sys=[];
end