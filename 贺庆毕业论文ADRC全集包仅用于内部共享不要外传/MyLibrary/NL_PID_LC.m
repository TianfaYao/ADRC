function [sys,x0,str,ts]=NL_PID_LC(t,x,u,flag,r0,h0,r1,h1,h,Bet)

switch flag,
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes(h);
    case 2,
        sys=mdlUpdates(x,u,r0,r1,h0,h1,h);
    case 3,
        sys=mdlOutputs(t,x,u,Bet);
    case 4,
        sys=mdlGetTimeOfNextVarHit(h);
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
   
function sys=mdlUpdates(x,u,r0,r1,h0,h1,h)
    fh0=fhan(x(1)-u(1),x(2),r0,h0);
    x(1)=x(1)+h*x(2);
    x(2)=x(2)+h*fh0;
    fh1=fhan(x(3)-u(2),x(4),r1,h1);
    x(3)=x(3)+h*x(4);
    x(4)=x(4)+h*fh1;
    x(5)=x(5)+h*(x(1)-x(3));    
    sys=x;
function sys=mdlOutputs(t,x,u,Bet)   
    sys(1)=Bet(1)*(x(5))+Bet(2)*(x(1)-x(3))+Bet(3)*(x(2)-x(4));
    sys(2)=x(1);
 
function sys=mdlGetTimeOfNextVarHit(h)
   sys=sys+h;
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
    
    

