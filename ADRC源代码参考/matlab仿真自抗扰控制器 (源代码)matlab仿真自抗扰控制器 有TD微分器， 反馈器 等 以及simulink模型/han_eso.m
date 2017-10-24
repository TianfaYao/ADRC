function [sys,x0,str,ts]=han_eso(t,x,u,flag,d,bet,b,T)
switch flag,
case 0
   [sys,x0,str,ts] = mdlInitializeSizes; % 初始化
case 2
   sys = mdlUpdates(x,u,d,bet,b,T); % 离散状态的更新
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
sizes.NumContStates = 0; % 无连续状态变量
sizes.NumDiscStates = 3; % 3个离散状态变量
sizes.NumOutputs = 3;    % 三路输出
sizes.NumInputs = 2;     % 两路输入：u和y
sizes.DirFeedthrough = 0; % 输入信号不直接在输出中反映出来
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0 = [0; 0; 0]; % 设置初始状态为零状态
str = []; % 将str变量设置为空字符串
ts = [-1 0]; % 采样周期: 假设它继承输入信号的采样周期
%==============================================================
% 在主函数的flag=2时，更新离散系统的状态变量
%==============================================================
function sys = mdlUpdates(x,u,d,bet,b,T)
e=x(1)-u(2);
sys(1,1)=x(1)+T*(x(2)-bet(1)*e);
sys(2,1)=x(2)+T*(x(3)-bet(2)*fal(e,0.5,d)+b*u(1));
sys(3,1)=x(3)-T*bet(3)*fal(e,0.25,d);
%==============================================================
% 在主函数flag=3时，计算系统的输出变量
%==============================================================
function sys = mdlOutputs(x)
sys=x; 
%==============================================================
% 用户定义的子函数： fal
%==============================================================
function f=fal(e,a,d)
if abs(e)<d
   f=e*d^(a-1);
else
   f=(abs(e))^a*sign(e);
end
