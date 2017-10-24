% Following code bakes a birthday cake for someone special to whom you
% wanna surprise on his/her birthday with a cake in MATLAB ;)
%
% This is a chocolate flavored cake decorated with cheries on top ......
% yyuummmyy :) :)
%
% Lighted birthday candle has been put up on cake; Think of a wish and blow
% off candle by clicking on flame (yellowish in colour)... and here comes
% the celebration with birthday song.. :) :) .. Wish you a very very happy
% birthday..
%
% While running code, make sure that PC speakers are ON
%
% Cake prepared by Amol G. Mahurkar
%
% Birthday_gift.m Revisions
%
% Version 1.2   04/25/2013  A/V sync
%
% Version 1.1	12/19/2011
%
% Version 1.0	10/28/2011
%
% Please suggest some extra features you think should be in this birthday gift
%

%%
function Birthday_gift()

clc; clear; close all;

instruc = ['Happy Birthday !!!!',char(10),char(10),...
    'Here is a birthday cake for someone special,',char(10),char(10),...
    'Make sure that PC speakers are ON',char(10),char(10),...
    'This cake has following features:',char(10),...
    '1. Chocolate flavored... and yummy :) :) ',char(10),...
    '2. Decorated with cheries :) :)',char(10),...
    '3. Lighted birthday candle on top of it',char(10),char(10),...
    'Think of a wish, and',char(10),...
    'Blow off candle by clicking on flame (yellowish in colour, obviously)',char(10),...
    'Enjoy your birthday cake!!!',char(10),char(10),...
    'And ya, wish you a very happy birthday'];

if(~strcmp('Ok',questdlg(instruc,'Surprise !!!!!','Ok','Cancel','Ok')))
    quit;
end

global bday_name;
global your_name;
temp = inputdlg({'Birthday boy/girl name:','Best Wishes from:'});
bday_name = temp{1};
your_name = temp{2};
clear temp;
%% Base

n = 20;
theta = (0:n)/n*2*pi;
sintheta = sin(theta); sintheta(n+1) = 0;
m = 11;
r = ones(1,m)';
x1 = r * cos(theta);
y1 = r * sintheta;
z1 = (0:m-1)'/(m-1) * ones(1,n+1);

r = [1 1 linspace(0.8,0,9)]';
x2 = r * cos(theta);
y2 = r * sintheta;
z2 = ones(11,21);

%% Cherry

theta = (-n:2:n)/n*pi;
phi = (-n:2:n)'/n*pi/2;
cosphi = cos(phi); cosphi(1) = 0; cosphi(n+1) = 0;
sintheta = sin(theta); sintheta(1) = 0; sintheta(n+1) = 0;
x3 = 0.1.*cosphi*cos(theta);
y3 = 0.1.*cosphi*sintheta;
z3 = 0.1.*sin(phi)*ones(1,n+1);

%% Candle

x4=0.05.*ones(m,1)*cos(theta) + 0.5;
y4=0.05.*ones(m,1)*sintheta + 0.5;
z4 = (0:m-1)'/(m-1) * ones(1,n+1) + 0.5;

r11=linspace(0.05,0,10);
r11=[0.05 r11];
r11=r11';
x5=r11*cos(theta) + 0.5;
y5=r11*sintheta + 0.5;
z5 = linspace(1.5,1.8,11)' * ones(1,n+1);

%% Flame

theta = (-n:2:n)/n*pi;
phi = (-n:2:n)'/n*pi/2;
cosphi = cos(phi); cosphi(1) = 0; cosphi(n+1) = 0;
sintheta = sin(theta); sintheta(1) = 0; sintheta(n+1) = 0;
x6 = 0.04.*cosphi*cos(theta) + 0.5;
y6 = 0.04.*cosphi*sintheta + 0.5;
z6 = (linspace(1.7,2,21)')*ones(1,n+1);

%% Cake

[figure1, axes1] = figureset();
cake_w_flame(x1,x2,x3,x4,x5,x6,y1,y2,y3,y4,y5,y6,z1,z2,z3,z4,z5,z6,figure1,axes1,1);

again = 1;
while(again)
[xin yin] = ginput(1);
if(xin < 0.5 && xin > -1 && yin < 0.6 && yin > -1)
    again = 0;
    load('bday_song_8bit_11025.mat');
%     sound(song,11025,8);
    obj = audioplayer(song, 11025, 8);
    play(obj);
    close(figure1)
    [figure1, axes1] = figureset();
    cake_w_flame(x1,x2,x3,x4,x5,x6,y1,y2,y3,y4,y5,y6,z1,z2,z3,z4,z5,z6,figure1,axes1,0);
    eatmore = 'Wanna eat more ??  Use rotate tool or/and zoom in/out tool for it';
    msgbox(eatmore);
else
    while(~strcmp(questdlg('Blow off candle','Click on candle to blow it off','Ok','No'),'Ok'))
    end
    again = 1;
end
end

function [figure1, axes1] = figureset()

figure1 = figure('NumberTitle','off','Name','Wish you a very very happy birthday');

axes1 = axes('Visible','off','Parent',figure1,'PlotBoxAspectRatio',[1 1 1],...
    'DataAspectRatio',[1 1 1],'CameraViewAngle',10);   
% 10.7508094342063
view(axes1,[-72.5 30]);
hold(axes1,'all');

oldRootUnits=get(0,'Units');
set(0,'Units','Pixels');
pos=get(0,'ScreenSize');
set(0,'Units',oldRootUnits);
maxPos=[-3 27 pos(3)+8 pos(4)-22];
oldUnits=get(figure1,'Units');
oldActivePositionProperty=get(figure1,'ActivePositionProperty');
set(figure1,'Units','Pixels','ActivePositionProperty','outerposition');
set(figure1,'Position',maxPos,'OuterPosition',maxPos);
set(figure1,'Units',oldUnits,'ActivePositionProperty',oldActivePositionProperty);

%% Cake w/wo flame
function cake_w_flame(x1,x2,x3,x4,x5,x6,y1,y2,y3,y4,y5,y6,z1,z2,z3,z4,z5,z6,~,axes1,flame)

global bday_name;
global your_name;

surf(x1,y1,z1,'Parent',axes1,'FaceLighting','phong',...
    'LineStyle','none',...
    'FaceColor',[0.200000002980232 0 0]);
surf(x2,y2,z2,'Parent',axes1,'FaceLighting','phong',...
    'LineStyle','none',...
    'FaceColor',[0.600000023841858 0.200000002980232 0]);

text('Parent',axes1,'String','Happy Birthday','Position',[-0.57 0.18 1.5],...
    'FontSize',28,...
    'FontName','Monotype Corsiva','Color',[1 0 0]);
text('Parent',axes1,'String',bday_name,'Position',[-0.3 -0.1 1.2],...
    'FontSize',28,...
    'FontName','Monotype Corsiva','Color',[1 0 0]);
text('Parent',axes1,'String',['Best Wishes from ',your_name],'Position',[-1.5 -1.5 1.5],...
    'FontSize',28,...
    'FontName','Monotype Corsiva','Color',[1 0 0]);
surf(x3+0,y3+0.8,z3+1.1,'Parent',axes1,'FaceLighting','phong',...
    'LineStyle','none',...
    'FaceColor',[1 0 0]);
surf(x3+0,y3-0.8,z3+1.1,'Parent',axes1,'FaceLighting','phong',...
    'LineStyle','none',...
    'FaceColor',[1 0 0]);
surf(x3+0.8,y3+0,z3+1.1,'Parent',axes1,'FaceLighting','phong',...
    'LineStyle','none',...
    'FaceColor',[1 0 0]);

surf(x3-0.8,y3+0,z3+1.1,'Parent',axes1,'FaceLighting','phong',...
    'LineStyle','none',...
    'FaceColor',[1 0 0]);
surf(x4,y4,z4,'Parent',axes1,'FaceLighting','phong',...
    'LineStyle','none',...
    'FaceColor',[0.925490200519562 0.839215695858002 0.839215695858002]);
surf(x5,y5,z5,'Parent',axes1,'FaceLighting','phong',...
    'LineStyle','none',...
    'FaceColor',[0.925490200519562 0.839215695858002 0.839215695858002]);
if(flame==1)
surf(x6,y6,z6,'Parent',axes1,'FaceLighting','phong',...
    'LineStyle','none',...
    'FaceColor',[1 1 0]);
end
light('Parent',axes1,'Style','local',...
    'Position',[-10.162701816704 -0.924193626363743 14.9951905283833]);

if(flame==0)
for i=1:110
view(axes1,[-10*i 20+0.2727*i])
pause(0.205)     %0.15
end
end
% EOF