addpath('.\jpegtbx_1.4');


%% Read an image from above Folder %%

%% Double Compressed Image (JPEG) %%
% srcDCJpg = dir('.\DCMISALLIGN\*.jpg');
% img_num = 3;
% img_name = strcat('.\DCMISALLIGN\',srcDCJpg(img_num).name);
% img_Ycbcr = rgb2ycbcr(imread(img_name));
% img_Y = img_Ycbcr(:,:,1);

%% image of TIF format %% 
srcFiles = dir('.\UNcompressed\*.tif');
%img_num = 1; 
filename = strcat('.\UNcompressed\',srcFiles(img_num).name);
org_img_rgb = imread(filename);
org_img_Ycbcr = rgb2ycbcr(org_img_rgb);
org_img_Y = org_img_Ycbcr(:,:,1);

[hgh_org, wid_org] = size(org_img_Y);
org_img_Y_1024 = crop_image(org_img_Y, floor(hgh_org/3), floor(wid_org/3));
org_img_1024(:,:,1) = org_img_Y_1024;
org_img_1024(:,:,2) = crop_image(org_img_Ycbcr(:,:,2),floor(hgh_org/3), floor(wid_org/3));
org_img_1024(:,:,3) = crop_image(org_img_Ycbcr(:,:,3),floor(hgh_org/3), floor(wid_org/3));
org_img_rgb_1024 = ycbcr2rgb(org_img_1024);
%% Tamper the image with resizing %% 
%QF_1 = 80; QF_2 = 50;
imwrite(org_img_rgb_1024,'single_compress.jpg','Quality',QF_1); %% first JPEG compression with QF-50
first_comp_ycbcr = rgb2ycbcr(imread('single_compress.jpg'));
%resize_fact = 0.75;
img_resized_1comp = imresize(first_comp_ycbcr,resize_fact,'bilinear');
single_comp_resized_rgb =  ycbcr2rgb(img_resized_1comp);
imwrite(single_comp_resized_rgb,'double_compress_resized.jpg','Quality',QF_2);

%% NLDP calculation of Double compressed Image %% 
second_comp_ycbcr = rgb2ycbcr(imread('double_compress_resized.jpg'));
sec_com_Y = second_comp_ycbcr(:,:,1);
%[minH1,Q1, K11, K21] = PSD_NLDP(first_comp_ycbcr(:,:,1));
%[minH2, Q2, K12, K22] = PSD_NLDP(sec_com_Y);


%% Estimation of candidate Resizing Factors %% 
f_K = Esti_resize_fact(im2double(sec_com_Y));
I = sec_com_Y;