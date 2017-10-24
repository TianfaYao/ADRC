function f=SecondRise(SP,RT,t)

if t<RT/2 & t>=0
    f=4*SP/RT^2;
elseif t>=RT/2 & t<RT
    f=-4*SP/RT^2;
else
    f=0;
end