[far, fs] = audioread('./ch1.wav');
[near, fs] = audioread('./ch3.wav');
% [near1, fs] = audioread('./ch5.wav');
% [near2, fs] = audioread('./ch7.wav');
%sig1 = delayseq(far,3);
% from 90',4 mic,4cm
% load("z1.mat");
% z1_3 = delayseq(z1(:,1),3);
% 
% 
% sig1 = delayseq(z1(:,1),3);
% 
% 
%[tau1,shift1] = gcc_phat(sig1, far);
% [idx,tau] = gccphat(z1(:,1), z1(:,5),  1);



distance1 = 0.04;
distance2 = 0.056569;
distance3 = distance2/2;
ch1 = delayseq(far,0/340,fs);
ch2 = delayseq(far,0/340,fs);
ch3 = delayseq(far,0*2/340, fs);
ch4 = delayseq(far, 0*3/340, fs);
audiowrite('./gcc_py/ch2.wav', ch2, 16000)
audiowrite('./gcc_py/ch1.wav', ch1, 16000)
audiowrite('./gcc_py/ch4.wav', ch4, 16000)
audiowrite('./gcc_py/ch3.wav', ch3, 16000)
 wlen = 512;
ch1234 = [ch1 ch2 ch3  ch4];
mic_loc = [4.02,4.02,0;4-0.02,4.02,0;4-0.02,4-0.02,0;4.02,4-0.02,0];
% shift = estimate_delay_gcc_phat(ch1(1:256), ch3(1:256));
Sx = stft_multi(ch1234',wlen);
num_doa = 8;
srp = srp_phat(Sx,num_doa,fs)
lsb = [2 2 0]; 
usb = [6 6 0];
[finalpos,finalsrp]=srpphat(ch1234, mic_loc, fs, lsb, usb);
room = zeros(usb(1),usb(2));
for k=1:numel(finalsrp)
    room(round(finalpos(k,1)),round(finalpos(k,2)))=max(room(round(finalpos(k,1)),round(finalpos(k,2))),finalsrp(k));
end
figure;  imagesc(room');axis xy;
%save("4ch.mat",ch1234);
%audiowrite('./ch1234.wav', ch1234, 16000);
%audiowrite('./srp_c/ch1_d1_2.wav', sig1, 16000);
% shift = estimate_delay_gcc_phat(near1, far);
% tau0 = shift/fs;
% [tau1,shift1] = gcc_phat(near1, far ,  fs, 0.0008, 1);
% [tau2,R, lags] = gccphat(near1, far,  fs);
% plot(1000*lags,real(R(:,1)))
% hold on;
% xlabel('Lag Times (ms)')
% ylabel('Cross-correlation')
% axis([-5,5,-.4,1.1])
% 
% plot(1000*lags,real(R(:,2)))
% plot(1000*lags,real(R(:,3)))
% hold off;
