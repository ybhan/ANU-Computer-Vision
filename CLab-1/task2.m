img2 = imread('Images-for-CLAB1/colorwheel.jpg');
img2_hsv = rgb2hsv(img2);

H=img2_hsv(:,:,1);

figure;
subplot(2,1,1);
imshow(img2);
subplot(2,1,2);
imshow(H);
text(850,750,num2str(round(H(850,750),2)));
text(950,550,num2str(round(H(950,550),2)));
text(850,300,num2str(round(H(850,300),2)));
text(700,150,num2str(round(H(700,150),2)));
text(500,100,num2str(round(H(500,100),2)));
text(250,150,num2str(round(H(250,150),2)));
text(100,300,num2str(round(H(100,300),2)));
text(50,550,num2str(round(H(50,550),2)));
text(100,750,num2str(round(H(100,750),2)));
text(300,900,num2str(round(H(300,900),2)));
text(500,950,num2str(round(H(500,950),2)));
text(700,900,num2str(round(H(700,900),2)));
text(900,750,num2str(round(H(900,750),2)));
