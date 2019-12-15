img4 = imread('Images-for-CLAB1/img_task3.jpg');
img4_noisy = imnoise(img4, 'salt & pepper', 0.1);

denoise_me = my_median_filter(img4_noisy, 3);
denoise_mat = medfilt2(img4_noisy, [3, 3]);

figure;
subplot(2,2,1);imshow(img4);title('Original');
subplot(2,2,2);imshow(img4_noisy);title('Noisy');
subplot(2,2,3);imshow(denoise_me);title('Denoise by my\_median\_filter');
subplot(2,2,4);imshow(denoise_mat);title('Denoise by medfilt2');


denoise_me = my_Sobel_edge(img4);
denoise_mat = edge(img4, 'sobel');

figure;
subplot(2,2,1);imshow(img4);title('Original');
subplot(2,2,2);imshow(img4_noisy);title('Noisy');
subplot(2,2,3);imshow(denoise_me);title('Denoise by my\_Sobel\_edge');
subplot(2,2,4);imshow(denoise_mat);title('Denoise by edge');
