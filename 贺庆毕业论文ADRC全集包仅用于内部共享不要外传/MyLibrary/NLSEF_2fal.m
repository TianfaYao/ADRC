function [sys,x0,str,ts]=NLSEF_2fal(t,x,u,flag,Beta1,A1,Beta2,A2,Delta)

switch flag
    case 0
        [sys,x0,str,ts]=mdlInitializeSizes;
    case 1
        sys=mdlDerivatives;
    case 3
        sys=mdlOutputs(u,Beta1,A1,Beta2,A2,Delta);
    case 4,
        sys=mdlGetTimeOfNextVarHit(t,H);
    case {2,9}
        sys=[];
    otherwise 
        error(['Unhandled flag=',num2str(flag)]);
end 
function [sys,x0,str,ts]=mdlInitializeSizes
    sizes=simsizes;
    sizes.NumContStates=0;
    sizes.NumDiscStates=0;
    sizes.NumOutputs=1;
    sizes.NumInputs=2;
    sizes.DirFeedthrough=1;
    sizes.NumSampleTimes=1;
    sys=simsizes(sizes);
    x0=[];
    str=[];
    ts=[-1 0];

function sys=mdlOutputs(u,Beta1,A1,Beta2,A2,Delta)
    sys=Beta1*fal(u(1),A1,Delta)+Beta2*fal(u(2),A2,Delta);    
function f=fal(e,a,d)
    if abs(e)<d
        f=e*d^(a-1);
    else f=(abs(e))^a*sign(e);
    end
    