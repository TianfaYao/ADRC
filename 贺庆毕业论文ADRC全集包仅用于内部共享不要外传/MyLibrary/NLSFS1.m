function [sys,x0,str,ts]=NLSFS1(t,x,u,flag)

switch flag,
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes;
    case 1,
        sys=mdlDerivatives(t,x,u);
    case 3,
        sys=mdlOutputs(t,x,u);
    case {2,4,9},
        sys=[];
    otherwise 
        error(['Unhandled flag=',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
    sizes=simsizes;
    sizes.NumContStates=2;
    sizes.NumDiscStates=0;
    sizes.NumOutputs=1;
    sizes.NumInputs=1;
    sizes.DirFeedthrough=0;
    sizes.NumSampleTimes=1;
    sys=simsizes(sizes);
    x0=[0;0];
    str=[];
    ts=[0 0];
function sys=mdlDerivatives(t,x,u)
    sys(1)=x(2);
    sys(2)=-20*sign(x(1)-u(1)+x(2)*abs(x(2))/(2*20));
    
function sys=mdlOutputs(t,x,u)   
    sys=x(1);

    
        
    
    

