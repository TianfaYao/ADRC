%the object be controlled
function [sys,x0,str,ts]=ctrl5_2_3obj(t,x,u,flag)
switch flag,
    case 0,
        [sys,x0,str,ts]=mdlInit();
    case 1,
        sys=mdlDer(t,x,u);
    case 3,
        sys=mdlOutput(t,x,u);
    otherwise,
        sys=[];
end;
function [sys,x0,str,ts]= mdlInit()
size=simsizes;
size.NumContStates=2;
size.NumDiscStates=0;
size.NumOutputs=2;
size.NumInputs=1;
size.DirFeedthrough=0;
size.NumSampleTimes=1;
sys=simsizes(size);
x0=[0];
str=[];
ts=[0,0];
function sys=mdlDer(t,x,u)
global b0;
a=1;
sys(1)=x(2);
sys(2)=a*sign(sin(10*t))+u*b0;
function sys=mdlOutput(t,x,u)
sys(1)=x(1);
sys(2)=sign(sin(2*t));