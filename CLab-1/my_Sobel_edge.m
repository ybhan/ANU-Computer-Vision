function [output_image] = my_Sobel_edge(imag)

[height, width] = size(imag);
F2 = double(imag);
U = double(imag);
uSobel = imag;

for i = 2 : height-1   %sobel????
    for j = 2 : width-1
        Gx = (U(i+1,j-1) + 2*U(i+1,j) + F2(i+1,j+1)) - ...
             (U(i-1,j-1) + 2*U(i-1,j) + F2(i-1,j+1));
        Gy = (U(i-1,j+1) + 2*U(i,j+1) + F2(i+1,j+1)) - ...
             (U(i-1,j-1) + 2*U(i,j-1) + F2(i+1,j-1));
        uSobel(i,j) = sqrt(Gx^2 + Gy^2);
    end
end

output_image = uint8(uSobel);

end
