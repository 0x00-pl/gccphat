close all;

t=zeros(60,1);
for i=1:size(z,1)
    t(z(i,1)+1) = t(z(i,1)+1)+z(i,2);
end

plot(t);

Nz = size(z,1);
Nc = 4;
N = floor(Nz/Nc);

t2 = zeros(60, N);
for i = 0:N-1
    for j = i*Nc:(i+1)*Nc-1
        t2(z(j+1,1)+1, i+1) = t2(z(j+1,1)+1, i+1) + z(j+1,2);
    end
end

imagesc(t2)
figure;
plot([max(t2)' sum(t2)'])
figure;
plot([(max(t2)./sum(t2).*Nc)'])