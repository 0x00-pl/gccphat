

im2 = m2(:,1) + 1j*m2(:,2);
im1 = m1(:,1) + 1j*m1(:,2);

% im2 = im2 - mean(im2);
% im1 = im1 - mean(im1);

ir12 = r12(:,1) + 1j*r12(:,2);
ic21 = c21(:,1) + 1j*c21(:,2);

dr12 = im2.*conj(im1);
dr12 = dr12 ./ (abs(dr12)+0.001);

dc21 = ifft(dr12);

% pause
% 
% m2 = [];
% m1 = [];
% r12 = [];
% c21 = [];

% plot([real(dr12).*256 real(ir12)])
plot([real(dc21).*65536.*2 real(ic21)])
