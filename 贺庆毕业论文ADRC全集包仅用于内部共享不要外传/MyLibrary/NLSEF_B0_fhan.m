function [sys,x0,str,ts]=NLSEF_B0_fhan(t,x,u,flag,Beta0,r1,h1)
switch flag,
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes;
%     case 2,
%         sys=mdlUpdates(x,u);
    case 3,
        sys=mdlOutputs(t,x,u,Beta0,r1,h1);
    %case 4,
     %   sys=mdlGetTimeOfNextVarHit(h);
    case {1,2,4,9},
        sys=[];
    otherwise 
        error(['Unhandled flag=',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes()
    sizes=simsizes;
    sizes.NumContStates=0;
    sizes.NumDiscStates=0;
    sizes.NumOutputs=1;
    sizes.NumInputs=3;
    sizes.DirFeedthrough=1;
    sizes.NumSampleTimes=1;
    sys=simsizes(sizes);
    x0=[];
    str=[];
    ts=[-1 0];  
function sys=mdlOutputs(t,x,u,Beta0,r1,h1) 
    sys=Beta0*(u(3))-fhan(u(1),u(2),r1,h1);
    
% function sys=mdlGetTimeOfNextVarHit(h)
%     sys=sys+h;
function y=fhan(x1,x2,r,h)
d=r*h;
d0=h*d;
y=x1+h*x2;
a0=sqrt(d^2+8*r*abs(y));
if abs(y)>d0
    a=x2+(a0-d)*sign(y)/2;
else
    a=x2+y/h;
end

if abs(a)>d
    y=-r*sign(a);
else 
    y=-r*a/d;
end
