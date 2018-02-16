clear; close all;
addpath('.\jpegtbx_1.4');
srcFiles = dir('.\UNcompressed\*.tif');
%srcFiles = dir('.\DRESDEN_tif\*.tiff');
%srcFiles = dir('D:\Proj files\Images\RAISE\*.tif');
%% Experimenting   for a dataset of 50 Images %%
% img_no = 2:6;
% QF1 = [50:10:90,99];
% resize_fact = [0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3 1.4];
% QF2 = [50:10:90,99];

%% Experimenting for a single combination %% 
 %img_no =58;
 img_no = 1:length(srcFiles);
 QF1 = 50:10:90; 
 resize_fact =  [0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3 1.4];
 %resize_fact = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
 resize_fact = [0.5 0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3];
 %resize_fact =  0.7;
 QF2 = [50:10:90,99];
 %QF2 = 90;
 %QF2 = 50:5:95;
 i = 1; j = 1; k = 1; 
 ind_rsz = 1:10;
 mapObj = containers.Map(resize_fact,ind_rsz);
 per_PSD = zeros(1,10);
 per_NLDP = zeros(1,10);
for img_num = img_no
    img_num
    tic
    filename = strcat('.\UNcompressed\',srcFiles(img_num).name);
    %filename = strcat('.\DRESDEN_tif\',srcFiles(img_num).name);
    %filename = strcat('D:\Proj files\Images\RAISE\',srcFiles(img_num).name);
    org_img_rgb = imread(filename);
    org_img_rgb_1024 = crop_1024(org_img_rgb);
    for QF_1 = QF1
        imwrite(org_img_rgb_1024,'single_compress.jpg','Quality',QF_1); %% first JPEG compression with QF_1
        first_comp_ycbcr = rgb2ycbcr(imread('single_compress.jpg'));
        [Q_1,r_1,c_1,psd_max1] = Norm_PSD(first_comp_ycbcr(:,:,1));
        exp_rslt_1stcom(i,:) = [img_num,QF_1,Q_1,r_1,c_1,psd_max1];
        QF_1
        i = i+1;
        x_shift = randi(8,1);
        y_shift = randi(8,1);
        
        
      first_com_Ycbcr_shifted =   crop_image( first_comp_ycbcr, x_shift, y_shift );
        for QF_2 = QF2
            QF_2
            for rsze_fact = resize_fact
            img_resized_1comp = imresize(first_com_Ycbcr_shifted,rsze_fact,'bicubic');
            single_comp_resized_rgb =  ycbcr2rgb(img_resized_1comp);
            imwrite(single_comp_resized_rgb,'double_compress_resized.jpg','Quality',QF_2);    
            doubly_com_ycbcr =  rgb2ycbcr(imread('double_compress_resized.jpg'));
            second_comp_ycbcr = rgb2ycbcr(imread('double_compress_resized.jpg'));
            sec_com_Y = second_comp_ycbcr(:,:,1);
            [Q_2,r_2,c_2,psd_max2] = Norm_PSD(doubly_com_ycbcr(:,:,1));
          % RD_img = im2double(doubly_com_ycbcr(:,:,1));
            RD_img = sec_com_Y;
            temppp = [img_num,QF_1,QF_2,rsze_fact,];
          % exp_rslt_2ndcom(j,:) = [img_num,rsze_fact,QF_2,Q_2,r_2,c_2,psd_max2];
            exp_rslt_2ndcom(j,:) = temppp;
              
              %%===== Main Algorithm ======%%
                               % tic;
                % demo_main
                % tic
                  RF_psd  = rszFct_psd(sec_com_Y, resize_fact);
                  rslt_psd(j,:) = [img_num,QF_1,QF_2,rsze_fact,RF_psd];
                %  toc
                  if(RF_psd == rsze_fact)
                     per_PSD(1,mapObj(RF_psd)) =  per_PSD(1,mapObj(RF_psd)) +1;
                  end
                % tic 
                % [minH, Q, k1, k2, scale] = getJRS_priori(RD_img(1:512,1:512), resize_fact); 
                [minH, Q, k1, k2, scale] = getJRS_priori(RD_img, resize_fact); 
                  RF_nldp = scale;
                  rslt_nldp(j,:) = [img_num,QF_1,QF_2,rsze_fact,RF_nldp];
                 % toc
                  if(RF_nldp == rsze_fact)
                      per_NLDP(1,mapObj(RF_nldp)) = per_NLDP(1,mapObj(RF_nldp))+1;
                  end
                      j = j+1;        
            end
        end
    end
    toc
end

%% =====Performance measure===== %%
per_PSD = per_PSD/(j/length(resize_fact));
per_NLDP = per_NLDP/(j/length(resize_fact));
figure
plot(resize_fact,per_PSD);
hold on
 %figure
plot(resize_fact,per_NLDP);
ylim([0,1]);
legend('PSD Method','NLDP Method');
xlabel('Resizing factor');
ylabel('True Positive Rate'); 
hold off;
%save rslt_psd_1.mat;
%save rslt_nldp_1.mat;
        
xlswrite('rslt_psd_dresden.xlsx',rslt_psd);
per_ALLQ2_dresden_final_PSD =   rslt_psd;
per_ALLQ2_drsden_final_NLDP =  rslt_nldp;
xlswrite('per_ALLQ2_dresden_final_PSD.xlsx',per_ALLQ2_dresden_final_PSD);
xlswrite('per_ALLQ2_dresden_final_NLDP.xlsx',per_ALLQ2_drsden_final_NLDP);


xlswrite('rslt_psd_0_5.xlsx',rslt_psd);
xlswrite('rslt_nldp_0_5.xlsx',rslt_nldp);

