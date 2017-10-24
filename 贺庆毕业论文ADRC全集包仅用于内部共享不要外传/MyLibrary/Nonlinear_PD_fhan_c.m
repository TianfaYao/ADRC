function [sys,x0,str,ts]=Nonlinear_PD_fhan_c(t,x,u,flag,c,r,h,h1)

if flag==0

    sys = [0;1;1;2;0;1;1];
     x0 = [0];                       
    str = [ ];
     ts = [h 0];           
   
elseif flag==2    
    
    sys=-fhan(u(1),c*u(2),r,h1);    
    
elseif flag==3
    sys=x;
    
elseif flag==4
    sys=sys+h;
    
else 
    sys=[];
end
function y=fhan(x1,x2,r,h)
d=r*h;
d0=h*d;
y=x1+h*x2;
a0=sqrt(d^2+8*r*abs(y));
if abs(y)>d0
    a=x2+(a0-d)*sign(y)/2;
else
    a=x2+y/h;
end

if abs(a)>d
    y=-r*sign(a);
else 
    y=-r*a/d;
end