function [sys,x0,str,ts]=NLSEF_3fal(t,x,u,flag,B,A,Delta)
switch flag,
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes;
%     case 2,
%         sys=mdlUpdates(x,u);
    case 3,
        sys=mdlOutputs(t,x,u,B,A,Delta);
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
function sys=mdlOutputs(t,x,u,B,A,Delta) 
    sys=B(1)*fal(u(3),A(1),Delta)+B(2)*fal(u(1),A(2),Delta)+B(3)*fal(u(2),A(3),Delta);   
    
% function sys=mdlGetTimeOfNextVarHit(h)
%     sys=sys+h;
function f=fal(e,a,d)
    if abs(e)<d
        f=e*d^(a-1);
    else f=(abs(e))^a*sign(e);
    end
