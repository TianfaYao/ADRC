function y=fst(x,a,b)
if x>b
    y=1;
elseif x<a
    y=0;
else 
    y=(x-a)/(b-a);
end
        