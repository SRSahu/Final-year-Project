clear all; % close all;
addpath('.\jpegtbx_1.4');


%% Read an image from above Folder %%

% %% Double Compressed Image (JPEG) %%
% srcDCJpg = dir('.\DCMISALLIGN\*.jpg');
% img_num = 5;
% img_name = strcat('.\DCMISALLIGN\',srcDCJpg(img_num).name)
% img_Ycbcr = rgb2ycbcr(imread(img_name));
% img_Y = img_Ycbcr(:,:,1);
% I = img_Y;
%% image of TIF format %% 
srcFiles = dir('.\UNcompressed\*.tif');
img_num =23; 
filename = strcat('.\UNcompressed\',srcFiles(img_num).name);
org_img_rgb = imread(filename);
org_img_Ycbcr = rgb2ycbcr(org_img_rgb);
org_img_Y = org_img_Ycbcr(:,:,1);

[hgh_org, wid_org] = size(org_img_Y);
xcv = crop_image(org_img_Ycbcr,floor(hgh_org/3), floor(wid_org/3));
org_img_Y_1024 = crop_image(org_img_Y, floor(hgh_org/3), floor(wid_org/3));
org_img_1024(:,:,1) = org_img_Y_1024;
org_img_1024(:,:,2) = crop_image(org_img_Ycbcr(:,:,2),floor(hgh_org/3), floor(wid_org/3));
org_img_1024(:,:,3) = crop_image(org_img_Ycbcr(:,:,3),floor(hgh_org/3), floor(wid_org/3));
org_img_rgb_1024 = ycbcr2rgb(org_img_1024);
%% Tamper the image with resizing %% 
QF_1 = 70; QF_2 = 90; 
imwrite(org_img_rgb_1024,'single_compress.jpg','Quality',QF_1); %% first JPEG compression with QF-50
first_comp_ycbcr = rgb2ycbcr(imread('single_compress.jpg'));
first_comp_Y = first_comp_ycbcr(:,:,1);
figure 
plot(PSD_plot(first_comp_Y));
title('PSD Spectra(Histogram DC band) of Single Compressed Image');

resize_fact =0.7;
img_resized_1comp = imresize(first_comp_ycbcr,resize_fact,'bicubic');
single_com_rszd = img_resized_1comp(:,:,1);
figure
plot(PSD_plot(single_com_rszd));
title('PSD Spectra(Histogram DC band) of Single Compressed Resized image');
single_comp_resized_rgb =  ycbcr2rgb(img_resized_1comp);
imwrite(single_comp_resized_rgb,'double_compress_resized.jpg','Quality',QF_2);

%% NLDP calculation of Double compressed Image %% 
second_comp_ycbcr = rgb2ycbcr(imread('double_compress_resized.jpg'));
sec_com_Y = second_comp_ycbcr(:,:,1);
figure 
plot(PSD_plot(sec_com_Y));
title('PSD Spectra(Histogram DC band) of Doubly Compressed Resized Image')
%[minH1,Q1, K11, K21] = PSD_NLDP(first_comp_ycbcr(:,:,1));
%[minH2, Q2, K12, K22] = PSD_NLDP(sec_com_Y);


%% Estimation of candidate Resizing Factors %% 
f_K = Esti_resize_fact(im2double(sec_com_Y));
I = sec_com_Y;
save sec_com_Y.mat;
P = findJPeaks_sc2(I);
save P.mat;

Power_spectrum

%% Resizing image in compressed Domain %% 
org_img = first_comp_ycbcr(:,:,1);
%resized_img = 

filename


% figure 
% imshow(sec_com_Y)

scales = [0.6 0.7 0.8 0.9 0.95 1.05 1.1 1.2 1.3 1.4];
rszFct_psd(I, scales)
[minH, Q, k1, k2, scale] = getJRS_priori(I, scales);
scale
%getJRS_priori(I,scales)


