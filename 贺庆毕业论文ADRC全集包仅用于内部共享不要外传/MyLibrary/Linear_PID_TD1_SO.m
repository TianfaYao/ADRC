function [sys,x0,str,ts]=Linear_PID_TD1_SO(t,x,u,flag,r0,h,B,Bet,D)

switch flag,
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes(h);
    case 2,
        sys=mdlUpdates(x,u,r0,h,B,D);
    case 3,
        sys=mdlOutputs(t,x,u,Bet);
    case 4,
        sys=mdlGetTimeOfNextVarHit(t,h);
    case {1,9},
        sys=[];
    otherwise 
        error(['Unhandled flag=',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes(h)
    sizes=simsizes;
    sizes.NumContStates=0;
    sizes.NumDiscStates=5;
    sizes.NumOutputs=2;
    sizes.NumInputs=2;
    sizes.DirFeedthrough=1;
    sizes.NumSampleTimes=1;
    sys=simsizes(sizes);
    x0=[0;0;0;0;0];
    str=[];
    ts=[h 0];  
   
function sys=mdlUpdates(x,u,r0,h,B,D)
    fh0=-r0*(r0*(x(1)-u(1))+sqrt(3)*x(2));
    x(1)=x(1)+h*x(2);
    x(2)=x(2)+h*fh0;    
    x(3)=x(3)+h*(x(4)-B(1)*(x(3)-u(2)));
    fh1=fal((x(3)-u(2)),0.5,D);
    x(4)=x(4)-h*(B(2)*fh1);
    x(5)=x(5)+h*(x(1)-x(3)); 
    sys=x;

function sys=mdlOutputs(t,x,u,Bet)  
    sys(1)=Bet(1)*x(5)+Bet(2)*(x(1)-x(3))+Bet(3)*(x(2)-x(4));
    sys(2)=x(1);
 
function sys=mdlGetTimeOfNextVarHit(t,h)
    sys=t+h;

function f=fal(e,a,d)
    if abs(e)<d
        f=e*d^(a-1);
    else f=(abs(e))^a*sign(e);
    end
    
    

