x = (-1:0.01:1)';
z = acos(x);
y0 = 1.57079-1.57079*x;
y1 = (-0.69813170079773212 .* x .* x - 0.87266462599716477) .* x + 1.5707963267948966;
y2 = pi/2 + (-0.939115566365855*x + 0.9217841528914573.*x.*x.*x) ./ (1-1.2845906244690837.*x.*x + 0.295624144969963174.*x.*x.*x.*x);
plot([z y0 y1 y2])
figure
plot([(z-y2)])