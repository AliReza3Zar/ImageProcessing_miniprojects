clc
clear all
close all
%%
pic = imread("YAD1-256.bmp");
m = 0;
varGauss = .01;
picGauss = imnoise(pic,'gaussian',m,varGauss);
d = 0.05;
picSalt = imnoise(pic,'salt & pepper',d);

figure
sgtitle("picture's")

subplot(2,3,1)
imshow(pic)
title("Orginal")
subplot(2,3,2)
imshow(picGauss)
title("gaussian Noise")
subplot(2,3,3)
imshow(picSalt)
title("salt & pepper")

subplot(2,3,4)
hist1 = pichist(pic);
title("histogram : Orginal")
ylabel("number of repeat")
xlabel("observation")

subplot(2,3,5)
hist1 = pichist(picGauss);
title("histogram : gaussian Noisy Picture")
ylabel("number of repeat")
xlabel("observation")

subplot(2,3,6)
hist1 = pichist(picSalt);
title("histogram : salt & pepper Noisy Picture")
ylabel("number of repeat")
xlabel("observation")
%%
i = 0;
figure(5)
sgtitle("Salt & Pepper Noise , Average Filter ")
subplot(2,2,1)
imshow(picSalt)
title("Noisy Picture")

figure(6)
sgtitle("Salt & Pepper Noise , Average Filter , Histogarm ")
subplot(2,2,1)
hist1 = pichist(picSalt);
title("histogram :  Salt & Pepper Noisy Picture")
ylabel("number of repeat")
xlabel("observation")

figure(9)
sgtitle("Salt & Pepper Noise")

for n = [3 5 7] %filter size
    i = i+1;
    avefilter = (1/(n*n))*ones(n,n);
    nfft = 64;
    Fmedfilter1 =fftshift(fft2(avefilter,nfft,nfft));
    
    freq = linspace(-pi,pi,nfft);
    offset = 0.5;
    figure
    s = surf(freq,freq,offset +  abs(Fmedfilter1));
    hold on
    imagesc(freq,freq,offset +  abs(Fmedfilter1));
    xticks([-pi -pi/2  0  pi/2 pi])
    xticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'})
    yticks([-pi -pi/2  0  pi/2 pi])
    yticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'})
    zticks([offset,offset+0.5,offset+1])
    zticklabels({'0','0.5','1'})
    % s.EdgeColor = 'none';
    title("Frequency Response of filter (size : "+ num2str(n) + " * "+num2str(n)+")")
    xlabel("X")
    ylabel("Y")
    xlim([-pi pi])
    ylim([-pi pi])
    
    picAveFiltered = uint8(conv2(picSalt,avefilter,'same'));
  
    figure(5)
    subplot(2,2,i+1)
    imshow((picAveFiltered))
    title("filter Size : "+ num2str(n) + " * "+num2str(n)) 
    
    figure(6)
    subplot(2,2,i+1)
    hist1 = pichist(picAveFiltered);
    title("histogram : filter Size : "+ num2str(n) + " * "+num2str(n))
    ylabel("number of repeat")
    xlabel("observation")
    figure(9)
    subplot(2,3,i)
    imshow(picAveFiltered)
    title("Average filter: "+ num2str(n) + " * "+num2str(n))
end
figure(7)
sgtitle("Salt & Pepper Noise , Median Filter ")
subplot(2,2,1)
imshow(picSalt)
title("Noisy Picture")
figure(8)
sgtitle("Salt & Pepper Noise , Median Filter , Histogarm ")
subplot(2,2,1)
hist1 = pichist(picSalt);
title("histogram : Salt & Pepper Noisy Picture")
ylabel("number of repeat")
xlabel("observation")

i = 0;
for n = [3 5 7]
    i = i+1;
    medfilter = ones(n);
    picMedFiltered = uint8(ordfilt2(picSalt,round(n^2/2),medfilter)); 
    figure(7)
    subplot(2,2,i+1)
    imshow((picMedFiltered))
    title("filter Size : "+ num2str(n) + " * "+num2str(n)) 
    figure(8)
    subplot(2,2,i+1)
    hist1 = pichist(picMedFiltered);
    title("histogram : filter Size : "+ num2str(n) + " * "+num2str(n))
    ylabel("number of repeat")
    xlabel("observation")
    
    figure(9)
    subplot(2,3,i+3)
    imshow(picMedFiltered)
    title("Median filter: "+ num2str(n) + " * "+num2str(n))
end





