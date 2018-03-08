% Gaussian Bandpass Filter
%  
% clearall;
%  
% closeall;

 
clc
 
micro = imread('grass2.jpg');

gray_micro = rgb2gray(micro);
 
gray_micro = double(gray_micro);
 
[nx, ny] = size(gray_micro);
 
nx;
 
ny;
 
u = gray_micro;
 
gray_micro = uint8(u);
 
imwrite(gray_micro,'grass5.jpg');
 
fftu = fft2(u,2*nx-1,2*ny-1);
 
fftu = fftshift(fftu);
 
% subplot(2,2,1)
 
% imshow(micro,[]);
 
% subplot(2,2,2)
 
fftshow(fftu,'log')
 
% Initialize filter.
 
filter1 = ones(2*nx-1,2*ny-1);
 
filter2 = ones(2*nx-1,2*ny-1);
 
filter3 = ones(2*nx-1,2*ny-1);

n = 4;
 
for i = 1:2*nx-1
 
    for j = 1:2*ny-1
 
        dist = ((i-(nx+1))^2 + (j-(ny+1))^2)^.5;

        % Use Gaussian filter.

        filter1(i,j) = exp(-dist^2/(2*120^2));

        filter2(i,j) = exp(-dist^2/(2*30^2));

        filter3(i,j) = 1.0 - filter2(i,j);

        filter3(i,j) = filter1(i,j).*filter3(i,j);

    end
 
end
 
% Update image with passed frequencies
 
fil_micro = fftu + filter3.*fftu;
 
% subplot(2,2,3)
 
fftshow(filter3,'log')
 
fil_micro = ifftshift(fil_micro);
 
fil_micro = ifft2(fil_micro,2*nx-1,2*ny-1);
 
fil_micro = real(fil_micro(1:nx,1:ny));
 
fil_micro = uint8(fil_micro);
 
% subplot(2,2,4)

figure
imshow(fil_micro,[])
title('Result')