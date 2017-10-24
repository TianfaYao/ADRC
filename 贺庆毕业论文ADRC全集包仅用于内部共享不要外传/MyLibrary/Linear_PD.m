function [sys,x0,str,ts]=Linear_PD(t,x,u,flag,Beta1,Beta2,h)

if flag==0

    sys = [0;1;1;2;0;1;1];
     x0 = 0;                       
    str = [ ];
     ts = [h 0];           
   
elseif flag==2
    
    sys=Beta1*u(1)+Beta2*u(2);  
    
elseif flag==3
    sys=x;
    
elseif flag==4
    sys=sys+h;
    
else 
    sys=[];
end