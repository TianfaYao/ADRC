function f=fal(e,a,d)

%if a>=1 | a<=0
%    error('a must satisfy 0<a<1');
%end

if abs(e)<=d
    f=e/d^(1-a);
else
    f=(abs(e))^a*sign(e);
end