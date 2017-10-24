function [sys,x0,str,ts]=ESO_2L(t,x,u,flag,bet,b)

switch flag
    case 0
        [sys,x0,str,ts]=mdlInitializeSizes;
    case 1
        sys=mdlDerivatives(x,u,bet,b);
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
function sys=mdlDerivatives(x,u,bet,b)
    e=x(1)-u(2);
    sys(1)=x(2)-bet(1)*e;
    sys(2)=x(3)-bet(2)*e+b*u(1);
    sys(3)=-bet(3)*e;
function sys=mdlOutputs(x)
    sys=x;

    