clear all; close all;
srcFiles = dir('.\UNcompressed\*.tif');
%% Read an image from above Folder %%
img_no = 3; 
filename = strcat('.\UNcompressed\',srcFiles(img_no).name);


org_img_rgb = imread(filename);
org_img_Ycbcr = rgb2ycbcr(org_img_rgb);
org_img_Y = org_img_Ycbcr(:,:,1);
org_img_Y1024 = org_img_Y(1024+1:2048,2048+1:3072);
org_img_Ydouble = im2double(org_img_Y1024);

%% Standard Matrix Initialization %% 

D_4_8 = [0.5,0.5,zeros(1,6); 0,0,0.5,0.5,zeros(1,4); zeros(1,4),0.5,0.5,0,0; zeros(1,6),0.5,0.5];
zer_4_8 = zeros(4,8);
p_0 = [D_4_8 ; zer_4_8];
p_1 = [zer_4_8 ; D_4_8];
im_blk00 = org_img_Ydouble(1:8,1:8);
im_blk01 = org_img_Ydouble(1:8,9:16);
im_blk10 = org_img_Ydouble(9:16,1:8);
im_blk11 = org_img_Ydouble(9:16,9:16);
x_ij = [im_blk00, im_blk01 ; im_blk10, im_blk11];
X_d00 = p_0 * im_blk00 * p_0';
X_d10 = p_1 * im_blk10 * p_0';
X_d01 = p_0 * im_blk01 * p_1';
X_d11 = p_1 * im_blk11 * p_1';
P_1 = dct2(p_0);
P_2 = dct2(p_1);


p_0_dct = dct2(p_0);
p_0_dct_t = dct2(p_0)';

im_blk00_dct  = dct2(im_blk00);
X_d00_dct = p_0_dct * im_blk00_dct * p_0_dct_t;
im_blk_00_dct_rev = pinv(p_0_dct) * X_d00_dct ;
im_blk_00_dct_rev = im_blk_00_dct_rev * pinv(p_0_dct_t);
im_blk00_rev = idct2(im_blk_00_dct_rev);
  
%% DCT halving %% 
x_d00_4 = X_d00(1:4,1:4);
%x_d00_dct_4 = 2*dct2(x_d00_4);
x_d00_dct_4 = dct2(x_d00_4);
x_d00_dct_8 = [x_d00_dct_4,zeros(4,4);zeros(4,8)];
x_d00_8 = idct2(x_d00_dct_8);


%% Block Decomposition %% 


