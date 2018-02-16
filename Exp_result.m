close all; clear all; 
rsize_fact = 0.25:0.25:2;
QF_S1 = 30:10:90;
QF_S2 = 30:10:90;
img_no  = 1:6;
k = 1;
for i = 1:length(img_no)
    img_num = img_no(i);
    for QF_1 = QF_S1
        for QF_2 = QF_S2
            for resize_fact = rsize_fact
                resize_DblCmp ;
                [minH1, Q_BP, k1, k2] = minHNA_unq(I);
                [Q_P,r,c,psd_max ] = PSD_peak(I);
                exp_rslt(k,:) = [img_num,QF_1,QF_2,resize_fact, Q_BP, k1, k2, minH1,Q_P,r,c,psd_max];
                k = k+1;  
            end   
        end
    end
end
save exp_rslt.mat;