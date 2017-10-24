function [sys,x0,str,ts]=ESO(t,x,u,flag,SampleTime,Delta,Beta1,Beta2,Beta3)

global z1 z2 z3

if flag==0
    sys = [0;3;3;2;0;1;1];
     x0 = [0 0 0];                       
    str = [];
     ts = [SampleTime 0];
     z1=0;z2=0;z3=0;
           
elseif flag==2
    %t
    
    
    e=z1-u(2);
    fe=fal(e,1/2,Delta);
    fe1=fal(e,1/4,Delta);
    z1=z1+SampleTime*(z2-Beta1*e);
    z2=z2+SampleTime*(z3-Beta2*fe+u(1));
    z3=z3+SampleTime*(-Beta3*fe1);
    sys=[z3,z2,z1];
    
elseif flag==3
    sys=x;
    
elseif flag==4
    sys=sys+SampleTime;
    
          
else 
    sys=[];
end