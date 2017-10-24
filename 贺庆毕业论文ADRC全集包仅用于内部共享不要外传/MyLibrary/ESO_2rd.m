function [sys,x0,str,ts]=ESO_2rd(t,x,u,flag,d,bet,b)

switch flag
    case 0
        [sys,x0,str,ts]=mdlInitializeSizes;
    case 1
        sys=mdlDerivatives(x,u,d,bet,b);
    case 3
        sys=mdlOutputs(x);
    case {2,4,9}
        sys=[];
    otherwise 
        error(['Unhandled flag=',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
    sizes=simsizes;
    sizes.NumContStates=3;
    sizes.NumDiscStates=0;
    sizes.NumOutputs=3;
    sizes.NumInputs=2;
    sizes.DirFeedthrough=1;
    sizes.NumSampleTimes=1;
    sys=simsizes(sizes);
    x0=[0;0;0];
    str=[];
    ts=[-1 0];
function sys=mdlDerivatives(x,u,d,bet,b)
    e=x(1)-u(2);
    sys(1,1)=x(2)-bet(1)*e;
    sys(2,1)=x(3)-bet(2)*fal(e,0.5,d)+b*u(1);
    sys(3,1)=-bet(3)*fal(e,0.25,d);
function sys=mdlOutputs(x)
    sys=x;
function f=fal(e,a,d)
    if abs(e)<d
        f=e*d^(a-1);
    else f=(abs(e))^a*sign(e);
    end
    