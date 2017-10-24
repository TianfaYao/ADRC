function y=fdb(x,a,b)
if x>b
    y=1;
elseif x<a
    y=-1;
elseif x=b
    y=1/2;
elseif x=a
    y=-1/2;
end
    