function [sys,x0,str,ts]=ADRC_2fal(t,x,u,flag,r,h,B01,B02,B03,D,b,k1,k2,Ds)
switch flag
   case 0
    [sys,x0,str,ts]=mdlInitializeSizes(h);
   case 2
        sys=mdlUpdate(x,u,r,h,B01,B02,B03,b,D);
   case 3
        sys=mdlOutputs(x,k1,k2,Ds,b);
   case 4,
        sys=mdlGetTimeOfNextVarHit(t,h);
   case {1,9}
       sys=[];
  otherwise 
       error(['Unhandled flag=',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes(h)
    sizes=simsizes;sizes.NumContStates=0;
    sizes.NumDiscStates=5;
    sizes.NumOutputs=1;
    sizes.NumInputs=3;
    sizes.DirFeedthrough=1;
    sizes.NumSampleTimes=1;
    sys=simsizes(sizes);
    x0=[0;0;0;0;0];
    str=[];
    ts=[h 0];
function sys=mdlUpdate(x,u,r,h,B01,B02,B03,b,D)
    e1=x(1)-u(1);
    fh=fhan(e1,x(2),r,h);
    sys(1)=x(1)+h*x(2);
    sys(2)=x(2)+h*fh;
    e2=x(3)-u(2);
    sys(3)=x(3)+h*(x(4)-B01*e2);
    sys(4)=x(4)+h*(x(5)-B02*fal(e2,0.5,D)+b*u(3));
    sys(5)=x(5)+h*(-B03*fal(e2,0.25,D));

function sys=mdlOutputs(x,k1,k2,Ds,b)
   e3=x(1)-x(3);
   e4=x(2)-x(4);
   sys=k1*fal(e3,0.5,Ds)+k2*fal(e4,1.5,Ds)-x(5)/b;
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