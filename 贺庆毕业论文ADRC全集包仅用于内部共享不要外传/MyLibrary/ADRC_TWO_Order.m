function [sys,x0,str,ts]=ADRC_Two_order(t,x,u,flag,r0,h,B01,B02,B03,D,b0,c,r1,h1)

switch flag
    case 0
        [sys,x0,str,ts]=mdlInitializeSizes(h);
    case 2
        sys=mdlUpdate(x,u,r0,h,B01,B02,B03,b0,D);
    case 3
        sys=mdlOutputs(x,c,r1,h1,b0);
    case 4,
        sys=mdlGetTimeOfNextVarHit(t,h);
    case {1,9}
        sys=[];
    otherwise 
        error(['Unhandled flag=',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes(h)
    sizes=simsizes;
    sizes.NumContStates=0;
    sizes.NumDiscStates=5;
    sizes.NumOutputs=1;
    sizes.NumInputs=3;
    sizes.DirFeedthrough=1;
    sizes.NumSampleTimes=1;
    sys=simsizes(sizes);
    x0=[0;0;0;0;0];
    str=[];
    ts=[h 0];
function sys=mdlUpdate(x,u,r0,h,B01,B02,B03,b0,D)
    e1=x(1)-u(1);
    fh=fhan(e1,x(2),r0,h);
    sys(1)=x(1)+h*x(2);
    sys(2)=x(2)+h*fh;
    e2=x(3)-u(2);
    sys(3)=x(3)+h*(x(4)-B01*e2);
    sys(4)=x(4)+h*(x(5)-B02*fal(e2,0.5,D)+b0*u(3));
    sys(5)=x(5)+h*(-B03*fal(e2,0.25,D));

function sys=mdlOutputs(x,c,r1,h1,b0)
    e3=x(1)-x(3);
    e4=x(2)-x(4);
    sys=-fhan(e3,c*e4,r1,h1)-x(5)/b0;
function sys=mdlGetTimeOfNextVarHit(t,h)
    sys=t+h;
    
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

function f=fal(e,a,d)
    if abs(e)<d
        f=e*d^(a-1);
    else f=(abs(e))^a*sign(e);
    end