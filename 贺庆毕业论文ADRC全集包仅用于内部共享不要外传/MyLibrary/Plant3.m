function [sys,x0,str,ts]=Plant3(t,x,u,flag)

switch flag,
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes;
    case 1,
        sys=mdlDerivatives(x,u);
    case 3,
        sys=mdlOutputs(x);
    case {2,4,9},
        sys=[];
    otherwise 
        error(['Unhandled flag=',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
    sizes=simsizes;
    sizes.NumContStates=3;
    sizes.NumDiscStates=0;
    sizes.NumOutputs=1;
    sizes.NumInputs=1;
    sizes.DirFeedthrough=1;
    sizes.NumSampleTimes=1;
    sys=simsizes(sizes);
    x0=[0;0;0];
    str=[];
    ts=[0 0];
function sys=mdlDerivatives(x,u)
    sys(1)=x(2);
    sys(2)=x(3);
    sys(3)=-x(1)-2*x(2)-3*x(3)+u;
function sys=mdlOutputs(x)   
    sys=x(1);  
   