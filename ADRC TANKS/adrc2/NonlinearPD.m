function [sys,x0,str,ts]=NonlinearPD(t,x,u,flag,Beta1,Beta2,Delta,A1,A2,SampleTime)

if flag==0

    sys = [0;1;1;2;0;1;1];
     x0 = [0 ];                       
    str = [ ];
     ts = [SampleTime 0];
           
   
elseif flag==2
    
    Bili=fal(u(1),A1,Delta);
    Weifen=fal(u(2),A2,Delta);
    sys=Beta1*Bili+Beta2*Weifen;    
    
elseif flag==3
    sys=x;
    
elseif flag==4
    sys=sys+SampleTime;
    
    
else 
    sys=[];
end