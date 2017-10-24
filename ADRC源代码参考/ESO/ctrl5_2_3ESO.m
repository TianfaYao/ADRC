%it is a state obsever of v1
function [sys,x0,str,ts]=ctrl5_2_3ESO(t,x,u,flag)
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
size.NumContStates=3;
size.NumDiscStates=0;
size.NumOutputs=3;
size.NumInputs=2;
size.DirFeedthrough=0;
size.NumSampleTimes=1;
sys=simsizes(size);
x0=[0,0,0];
str=[];
ts=[0,0];


function sys=mdlDer(t,x,u)
global b0;
b=[50,800,10000];
e=x(1)-u(1);
fe=fal(e,0.5,0.01);
fe1=fal(e,0.25,0.01);
sys(1)=x(2)-b(1)*e;
sys(2)=x(3)-b(2)*fe+b0*u(2);
sys(3)=-b(3)*fe1;
function sys=mdlOutput(t,x,u)
sys=x;