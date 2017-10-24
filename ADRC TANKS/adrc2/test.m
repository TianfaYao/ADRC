t=1:0.1:10;

for j=0:0.1:10
    y(1)=0;
    for i=1:length(t)
        y(i)=fal(t(i),1/2,j);
    end
    plot(t,y,'k');
    hold on 
end


for j=0:0.1:10
    y(1)=0;
    for i=1:length(t)
        y(i)=fal(t(i),1/4,j);
    end
    plot(t,y,'r');
    hold on 
end