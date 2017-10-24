function [sys,x0,str,ts]=han_ctrl(t,x,u,flag,aa,bet1,b,d)
switch flag,
case 0
   [sys,x0,str,ts] = mdlInitializeSizes(t,u,x); % 初始化
case 3
   sys = mdlOutputs(t,x,u,aa,bet1,b,d); % 输出量的计算
case { 1,2,4,9 }
   sys = []; % 未使用的flag值
otherwise
   error(['Unhandled flag = ',num2str(flag)]); % 处理错误
end;
%==============================================================
% 当flag为0时进行整个系统的初始化
%==============================================================
function [sys,x0,str,ts] = mdlInitializeSizes(t,u,x)
% 首先调用simsizes函数得出系统规模参数sizes, 并根据离散系统的实际
% 情况设置sizes变量
sizes = simsizes;
sizes.NumContStates = 0; % 连续状态数为0
sizes.NumDiscStates = 0; % 离散状态数为0
sizes.NumOutputs = 1;    % 输出路数为1
sizes.NumInputs = 5;     % 输入路数为5
sizes.DirFeedthrough = 1;% 输入在输出中直接显示出来，注意不能将其设置为0
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0 = []; % 设置初始状态为零状态
str = []; % 将str变量设置为空字符串
ts = [-1 0]; % 采样周期: [period, offset]
%==============================================================
% 在主函数flag=3时，计算系统的输出变量
%==============================================================
function sys = mdlOutputs(t,x,u,aa,bet1,b,d)
e1=u(1)-u(3); e2=u(2)-u(4); 
u0=bet1(1)*fal(e1,aa(1),d)+bet1(2)*fal(e2,aa(2),d);
sys=u0-u(5)/b;
%==============================================================
% 用户定义的子函数： fal
%==============================================================
function f=fal(e,a,d)
if abs(e)<d
   f=e*d^(a-1);
else
   f=(abs(e))^a*sign(e);
end
