function [max_id]=srp_phat(Sx, num_doa, fs)
    [nbin, num_frames, num_chs] = size(Sx); 
    delay_mic = [0.04 0.0283 0 -0.0283 -0.04 -0.0283 0 0.0283;
                 0.04 0.0566 0.04 0 -0.04 -0.0566 -0.04 0;
                 0 0.0283 0.04 0.0283 0 -0.0283 -0.04 -0.0283;
                 0 0.0283 0.04 0.0283 0 -0.0283 -0.04  -0.0283;
                 -0.04 0 0.04 0.0566 0.04 0 -0.04 -0.0566;
                 -0.04 -0.0283 0 0.0283 0.04 0.0283 0 -0.0283];
    shiftTau = delay_mic/340;
    maxshift = floor(nbin/2);
    shiftdelay = round(-fs * shiftTau+ maxshift + 1);
    % GCC-PHAT
    N = num_chs * (num_chs - 1)/2;
    Z= zeros(nbin ,N,num_frames);
    p= 0;
    for m1=1:num_chs-1
        for m2=m1+1:num_chs
            p= p+1;
            Z(:,p,:)= Sx(:, :, m1).*conj(Sx(:, :, m2));
        end
    end
    R= zeros(nbin ,N,num_frames);
    for p=1:N
        R(:,p,:)= fftshift(real(ifft(Z(:,p,:))));
    end
    % SRP search
    srp = zeros(num_doa,1);
    for q=1:num_doa
        temp = 0;
        for p = 1: N
             temp = temp + sum(R(shiftdelay(p,q),p,:),3);
        end
        srp(q) = temp;
    end
    [~,max_id] = max(srp);
    imagesc(srp);
    return 
end

% function [max_id]=srp_phat(Sx, num_doa, fs)
%     [nbin, num_frames, num_chs] = size(Sx); 
%     delay_mic = [0.04 0.0283 0 -0.0283 -0.04 -0.0283 0 0.0283;
%                  0.04 0.0566 0.04 0 -0.04 -0.0566 -0.04 0;
%                  0 0.0283 0.04 0.0283 0 -0.0283 -0.04 -0.0283;
%                  0 0.0283 0.04 0.0283 0 -0.0283 -0.04  -0.0283;
%                  -0.04 0 0.04 0.0566 0.04 0 -0.04 -0.0566;
%                  -0.04 -0.0283 0 0.0283 0.04 0.0283 0 -0.0283];
%     shiftTau = delay_mic/340;
%     aug = zeros(num_frames, num_doa);
%     for d=1:num_doa
%          j= 1;
%         for p = 1:num_chs-1
%             for q = p+1: num_chs
%                 
%                 tau = shiftTau(j, d);
%                 aug(:,d) = aug(:,d) + gcc_phat(Sx(:, :, p), Sx(:, :, q), tau, fs, nbin)';
%                 j = j + 1;
%             end
%            
%         end
%         
%     end
%     [~, max_id]= max(sum(real(aug), 1));
%     imagesc(sum(real(aug), 1));
%     return 
% end
% 
% function R=gcc_phat(x1, x2, tau, fs, nbin) 
% f = linspace(0,(fs/2),nbin)';
% R = x1.*conj(x2);
% R = R.*exp(-2*1i*pi*tau*f);
% R = sum(R,1);
% %R = zeros(nfram, nbin);
% end