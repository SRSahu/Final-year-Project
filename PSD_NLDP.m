function [ minH1, Q, k1, k2 ] = PSD_NLDP(I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    minQ = 2;
    maxQ = 16;
    DC = conv2(I,ones(8)/8);
    DC = DC(8:end,8:end);
    Qmap = zeros(8,8,maxQ(1,1)-minQ(1,1)+1);
    Qmap_psd = zeros(8,8,maxQ(1,1)-minQ(1,1)+1);
   binHist = (-2^11:1:2^11-1);
   periods = minQ(1,1):maxQ(1,1);
   % define DFT matrix for frequencies corresponding to integer periods
    harmfreq = 1./periods;
    IPDFT = exp(-2*pi*i* binHist' * harmfreq);

for k1 = 1:8
    for k2 = 1:8
        % get DC coefficients for shift k1, k2
        DCpoly = DC(k1:8:end,k2:8:end);
        num4Bin = hist(DCpoly(:),binHist);
        % compute DFT of histogram of DC coeffs
        hspec_dft = num4Bin * IPDFT;
        hspec = abs(num4Bin * IPDFT);
        hspec_psd = conj(hspec_dft)' * hspec_dft; 
        Qmap_psd(k1,k2,:) = abs(sum(hspec_psd));
        Qmap(k1,k2,:) = hspec;
    end
end

%% compare PSD and DFT
xcv = sum(hspec_psd);
figure 
plot(xcv);
figure
plot(abs(xcv))
figure 
plot(hspec)

%% ======= %% 
minH1 = 6;
for k = 1:length(periods)
    Qmaptmp = Qmap(:,:,k);
    % compute IPM
    minH = min(-log2(Qmaptmp(:)/sum(Qmaptmp(:))));
    if minH < minH1
        % record minimum value of minH 
        [m1,i1] = max(Qmaptmp);
        [m2,i2] = max(m1);
        Q = periods(k);
        minH1 = minH;
    end
end

minH1 = minH1/6;
k1 = i1(i2);
k2 = i2;

return
    

end

