function [sys,x0,str,ts]=ESO(t,x,u,flag,Delta,h2,BB)

switch flag
    case 0
        [sys,x0,str,ts]=mdlInitializeSizes(h2);
    case 2
        sys=mdlUpdate(x,u,Delta,h2,BB);
    case 3
        sys=mdlOutputs(x);
    case 4,
        sys=mdlGetTimeOfNextVarHit(h2);
    case {1,9}
        sys=[];
    otherwise 
        error(['Unhandled flag=',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes(h2)
    sizes=simsizes;
    sizes.NumContStates=0;
    sizes.NumDiscStates=3;
    sizes.NumOutputs=3;
    sizes.NumInputs=2;
    sizes.DirFeedthrough=1;
    sizes.NumSampleTimes=1;
    sys=simsizes(sizes);
    x0=[0;0;0];
    str=[];
    ts=[h2 0];
function sys=mdlUpdate(x,u,Delta,h2,BB)
    e=x(1)-u(2);
    fe=fal(e,0.5,Delta);
    fe1=fal(e,0.25,Delta);
    sys(1,1)=x(1)+h2*(x(2)-BB(1)*e);
    sys(2,1)=x(2)+h2*(x(3)-BB(2)*fe+u(1));
    sys(3,1)=x(3)+h2*(-BB(3)*fe1);
function sys=mdlOutputs(x)
    sys=x;
function sys=mdlGetTimeOfNextVarHit(h2)
    sys=sys+h2;
 function f=fal(e,a,d)
    if abs(e)<d
        f=e*d^(a-1);
    else f=(abs(e))^a*sign(e);
    end
    