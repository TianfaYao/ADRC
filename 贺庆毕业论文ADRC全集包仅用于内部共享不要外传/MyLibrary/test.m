function [sys,x0,str,ts]=test(t,x,u,flag,r0,h,B01,B02,B03,B1,B2,b0)

switch flag
    case 0
        [sys,x0,str,ts]=mdlInitializeSizes(h);
    case 2
        sys=mdlUpdate(x,u,r0,h,B01,B02,B03,b0);
    case 3
        sys=mdlOutputs(x,B1,B2,b0);
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
    sizes.DirFeedthrough=0;
    sizes.NumSampleTimes=1;
    sys=simsizes(sizes);
    x0=[0;0;0;0;0];
    str=[];
    ts=[h 0];
function sys=mdlUpdate(x,u,r0,h,B01,B02,B03,b0)
    fh=-r0^2*(x(1)-u(1))+2*r0*x(2);
    sys(1)=x(1)+h*x(2);
    sys(2)=x(2)+h*fh;
    e=x(3)-u(2);
    sys(3)=x(3)+h*(x(4)-B01*e);
    sys(4)=x(4)+h*(x(5)-B02*e+b0*u(3));
    sys(5)=x(5)+h*(-B03*e);
%     fe=fal(e,0.5,Delta);
%     fe1=fal(e,0.25,Delta);    
%     sys(1,1)=x(1)+h2*(x(2)-BB(1)*e);
%     sys(2,1)=x(2)+h2*(x(3)-BB(2)*fe+u(1));
%     sys(3,1)=x(3)+h2*(-BB(3)*fe1);
function sys=mdlOutputs(x,B1,B2,b0)
    e1=x(1)-x(3);
    e2=x(2)-x(4);
    sys=B1*e1+B2*e2-x(5)/b0;
function sys=mdlGetTimeOfNextVarHit(t,h)
    sys=t+h;
        