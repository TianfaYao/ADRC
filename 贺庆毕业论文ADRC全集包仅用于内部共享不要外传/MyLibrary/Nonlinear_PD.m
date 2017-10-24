function [sys,x0,str,ts]=Nonlinear_PD(t,x,u,flag,Beta1,Beta2,Delta,a1,a2,h)

if flag==0

    sys = [0;1;1;2;0;1;1];
     x0 = [0];                       
    str = [ ];
     ts = [h 0];           
   
elseif flag==2
    
    Bili=fal(u(1),a1,Delta);
    Weifen=fal(u(2),a2,Delta);
    sys=Beta1*Bili+Beta2*Weifen;    
    
elseif flag==3
    sys=x;
    
elseif flag==4
    sys=sys+h;
    
else 
    sys=[];
end
function f=fal(e,a,d)
    if abs(e)<d
        f=e*d^(a-1);
    else f=(abs(e))^a*sign(e);
    end