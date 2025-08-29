clc; clear; close all;

% Load and preprocess image
img = imread('C:\Users\Rahul SV\Desktop\Lenna_(test_image).png');  % correct full path
img_gray = imresize(rgb2gray(img), [128 128]);

A = uint32(img_gray);
B = uint32(circshift(img_gray, [-1 -1]));  % shifted image for multiplication

% Exact product
P_exact = A .* B;

% Define truncation zones
N_two   = 8;   % truncate 8 LSBs (two-zone)
N_three = 4;   % truncate 4 LSBs (three-zone)

mask_two   = bitcmp(uint32(2^N_two - 1), 'uint32');     
mask_three = bitcmp(uint32(2^N_three - 1), 'uint32'); 

P_two   = bitand(P_exact, mask_two);
P_three = bitand(P_exact, mask_three);

% Scale results back to 8-bit image
D_exact  = uint8(min(P_exact, 65535) / 256);
D_two    = uint8(min(P_two, 65535) / 256);
D_three  = uint8(min(P_three, 65535) / 256);

% ---------------- Show Images ----------------
figure('Name','Comparison','NumberTitle','off');
subplot(1,3,1); imshow(D_exact);  title('Exact (reference)');
subplot(1,3,2); imshow(D_two);    title('Two-Zone (baseline)');
subplot(1,3,3); imshow(D_three);  title('Three-Zone (proposed)');

% ---------------- Quality Metrics ----------------
[p2,~] = psnr(D_two, D_exact);   s2 = ssim(D_two, D_exact);
[p3,~] = psnr(D_three, D_exact); s3 = ssim(D_three, D_exact);

fprintf('Comparison vs Exact:\n');
fprintf('Two-Zone  -> PSNR = %.2f dB, SSIM = %.4f\n', p2, s2);
fprintf('Three-Zone-> PSNR = %.2f dB, SSIM = %.4f\n', p3, s3);

% ---------------- Error Maps ----------------
diff2 = im2double(D_exact) - im2double(D_two);
diff3 = im2double(D_exact) - im2double(D_three);

figure('Name','Error Maps','NumberTitle','off');
subplot(1,2,1); imagesc(diff2); axis image off; colorbar; title('Error map: Two-Zone');
subplot(1,2,2); imagesc(diff3); axis image off; colorbar; title('Error map: Three-Zone');


