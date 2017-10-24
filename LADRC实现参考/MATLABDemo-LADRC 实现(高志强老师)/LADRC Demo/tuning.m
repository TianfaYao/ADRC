h=1e-3; %simulation step size
b0=40;
wo=40; %acc paper: 40
wc=150; %acc paper: 150
kp=wc^2;kd=-2.*wc;
sim('Motion_acc03');
