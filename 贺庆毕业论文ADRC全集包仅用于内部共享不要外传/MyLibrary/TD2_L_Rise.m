function [sys,x0,str,ts]=TD2_L_Rise(t,x,u,flag,RisingTime,SampleTime)

if flag==0
     sys = [0;2;2;1;0;0;1];
     x0 = [0,0];                       
     str = [ ];
     ts = [SampleTime 0];
     %v1=0;
  elseif flag==2
    %%%二阶过渡过程
    %速度量
    %if t<=RisingTime/2
    %    v2=4*SetPoint*t/RisingTime^2;
    %elseif t>RisingTime/2 & t<=RisingTime
    %    v2=2*(SetPoint/RisingTime)*(1-2/RisingTime*(t-RisingTime/2))
    %else
    %    v2=0;
    %end
    v=SecondRise(u,RisingTime,t);
    sys(2)=x(2)+SampleTime*v;
    sys(1)=x(1)+SampleTime*(sys(2));
       
elseif flag==3
    sys=x;
elseif flag==4
    sys=sys+SampleTime;       
else 
    sys=[];
end

function f=SecondRise(SP,RT,t)

if t<RT/2 & t>=0
    f=4*SP/RT^2;
elseif t>=RT/2 & t<RT
    f=-4*SP/RT^2;
else
    f=0;
end
