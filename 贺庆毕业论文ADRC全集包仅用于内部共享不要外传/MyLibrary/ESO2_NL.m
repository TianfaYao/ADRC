function [sys,x0,str,ts]=ESO2_NL(t,x,u,flag,a1,a2,d,Beta,b0)
switch flag,
    case 0
      sys=[3,0,3,2,0,0,1];
      x0=[0;0;0];
      str=[];
      ts=[0 0];
    case 1
      e=x(1)-u(1);
      sys(1)=x(2)-Beta(1)*e;
      sys(2)=x(3)-Beta(2)*fal(e,a1,d)+b0*u(2);
      sys(3)=-Beta(3)*fal(e,a2,d);
    case 3
        sys=x;
    case {2,4,9}
        sys=[];
    otherwise 
        error(['Unhandled flag=',num2str(flag)]);
end
function f=fal(e,a,d)
    if abs(e)<d
        f=e*d^(a-1);
    else f=(abs(e))^a*sign(e);
    end