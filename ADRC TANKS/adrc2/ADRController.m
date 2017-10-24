function [sys,x0,str,ts]=ADRController(t,x,u,flag,Beta1,Beta2,Delta1,A1,A2,Delta2,Gamma1,Gamma2,Gamma3,b0,SampleTime)
global z1 z2 z3
if flag==0
    sys = [0;1;1;4;1;1;1];
     x0 = [0];  
    str = [ ];
     ts = [SampleTime 0];
     z1=0;
     z2=0;
     z3=0;
elseif flag==2
    e=z1-u(3);
    fe=fal(e,1/2,Delta2);
    fe1=fal(e,1/4,Delta2);
    z1=z1+SampleTime*(z2-Gamma1*e);
    z2=z2+SampleTime*(z3-Gamma2*fe+b0*u(4));
    z3=z3+SampleTime*(-Gamma3*fe1);
    Error1=u(1)-z1;
    Error2=u(2)-z2;
    Bili=fal(Error1,A1,Delta1);
    Weifen=fal(Error2,A2,Delta1);
    sys=Beta1*Bili+Beta2*Weifen-z3/b0; 
elseif flag==3
    sys=x;   
elseif flag==4
    sys=sys+SampleTime;
else 
    sys=[];
end