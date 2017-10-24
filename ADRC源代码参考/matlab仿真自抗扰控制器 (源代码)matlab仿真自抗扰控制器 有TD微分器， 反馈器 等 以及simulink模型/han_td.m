function [sys,x0,str,ts]=han_td(t,x,u,flag,r,h,T)
switch flag,
case 0
   [sys,x0,str,ts] = mdlInitializeSizes; % 初始化
case 2 
   sys = mdlUpdates(x,u,r,h,T);  % 离散状态的更新
case 3
   sys = mdlOutputs(x); % 输出量的计算
case { 1, 4, 9 }
   sys = []; % 未使用的flag值
otherwise
   error(['Unhandled flag = ',num2str(flag)]); % 处理错误
end;
%==============================================================
% 当flag为0时进行整个系统的初始化
%==============================================================
function [sys,x0,str,ts] = mdlInitializeSizes
% 首先调用simsizes函数得出系统规模参数sizes, 并根据离散系统的实际
% 情况设置sizes变量
sizes = simsizes;
sizes.NumContStates = 0;  % 无连续状态
sizes.NumDiscStates = 2;  % 无离散状态
sizes.NumOutputs = 2;     % 输出个数为2
sizes.NumInputs = 1;      % 输入个数为1
sizes.DirFeedthrough = 0; % 输入不直接在输出中反映出来
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0 = [0; 0]; % 设置初始状态为零状态
str = []; % 将str变量设置为空字符串
ts = [-1 0]; % 采样周期: [period, offset] 继承输入信号的采样周期
%==============================================================
% 在主函数的flag=2时，更新离散系统的状态变量
%==============================================================
function sys = mdlUpdates(x,u,r,h,T)
sys(1,1)=x(1)+T*x(2);
sys(2,1)=x(2)+T*fst2(x,u,r,h);
%==============================================================
% 在主函数flag=3时，计算系统的输出变量
%==============================================================
function sys = mdlOutputs(x)
sys=x; 
%==============================================================
% 用户定义的子函数： fst2
%==============================================================
function f=fst2(x,u,r,h)
delta=r*h; delta0=delta*h; y=x(1)-u+h*x(2);
a0=sqrt(delta*delta+8*r*abs(y));
if abs(y)<=delta0
    a=x(2)+y/h;
else
    a=x(2)+0.5*(a0-delta)*sign(y);
end
if abs(a)<=delta
    f=-r*a/delta;
else
    f=-r*sign(a);
end
