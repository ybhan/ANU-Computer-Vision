img3 = imread('Images-for-CLAB1/face_02_u6617017.jpg');
img3 = img3(30:30+511, 263:263+511, :);

img3_gray = rgb2gray(img3);
imwrite(img3_gray, 'Images-for-CLAB1/img_task3.jpg');

% 50 is too big, so denoising has no notable effect at all. I set it to 5.
sigma = 5;
img3_noisy = imnoise(img3_gray, 'gaussian', 0, sigma);

my_9x9_gausskernel = fspecial('gaussian', [9, 9], sigma);
denoise_matlab = imfilter(img3_noisy, my_9x9_gausskernel, 'conv');
denoise_me = my_Gauss_filter(img3_noisy, my_9x9_gausskernel);

figure;
subplot(2,2,1);imshow(img3_gray);title('Original');
subplot(2,2,2);imshow(img3_noisy);title('Noisy');
subplot(2,2,3);imshow(denoise_me);title('Denoise by my\_Gauss\_filter');
subplot(2,2,4);imshow(denoise_matlab);title('Denoise by imfilter');
