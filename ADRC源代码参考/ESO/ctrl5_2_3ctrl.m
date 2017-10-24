%u is influenced by v,z
function [sys,x0,str,ts]=ctrl5_2_3ctrl(t,x,u,flag)
switch flag,
    case 0,
        [sys,x0,str,ts]=mdlInit();
%     case 1,
%         sys=mdlDer(t,x,u);
    case 3,
        sys=mdlOutput(t,x,u);
    otherwise,
        sys=[];
end;
function [sys,x0,str,ts]= mdlInit()
size=simsizes;
size.NumContStates=0;
size.NumDiscStates=0;
size.NumOutputs=1;
size.NumInputs=5;
size.DirFeedthrough=1;
size.NumSampleTimes=1;
sys=simsizes(size);
x0=[];
str=[];
ts=[0,0];
% function sys=mdlDer(t,x,u)

function sys=mdlOutput(t,x,u)
%x(1:2):v1,v2;
%x(3:5):z1,z2,z3;
global b0;
global r;
global h;
e=u(1:2)-u(3:4);
u0=-fhan(e(1),e(2),r,h);
sys=u0-u(5)/b0;