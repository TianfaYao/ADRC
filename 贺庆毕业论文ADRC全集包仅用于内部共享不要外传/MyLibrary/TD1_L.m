function [sys,x0,str,ts]=TD1_L(t,x,u,flag,RisingTime,SampleTime)

if flag==0
     sys = [0;1;1;1;0;0;1];
     x0 = [0];                       
     str = [ ];
     ts = [SampleTime 0];
     %v1=0;
  elseif flag==2
     v=FirstRise(u,RisingTime,t);
     sys=x +SampleTime*v;         
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%一阶过渡过程
    %速度量
    %if t>=0 & t<=RisingTime
    %    v2=SetPoint/RisingTime;
    %else
    %    v2=0;
    %end
    %位置量
    %if t>=0 & t<=RisingTime
    %    v1=SetPoint*t/RisingTime;
    %else
    %    v1=SetPoint;
    %end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%\
    
elseif flag==3
    sys=x;
elseif flag==4
    sys=sys+SampleTime;       
else 
    sys=[];
end
function f=FirstRise(SetPoint,RisingTime,t)
if t<=RisingTime & t>0
    f=SetPoint/RisingTime; 
else
    f=0;
end 
