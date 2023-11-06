clc 
clear all
close all
%%
p1 = imread("Picture2.bmp");
p2 = imread("picture3.bmp");
size1 = size(p1);
pixels1 = size1(1)*size1(2);

size2 = size(p2);
pixels2 = size1(2)*size2(2);
figure
sgtitle("stretch using Min Max scaling")

subplot(2,2,1)
imshow(p1)
title("picture 1 before stretch")

subplot(2,2,2)
hist1 = pichist(p1);
title("histogram : picture 1 before stretch")
ylabel("number of repeat")
xlabel("observation")

figure
sgtitle("stretch using Min Max scaling")

subplot(2,2,1)
imshow(p2)
title("picture 2 before stretch")

subplot(2,2,2)
hist2 = pichist(p2);
title("histogram of picture 2 before stretch")
ylabel("number of repeat")
xlabel("observation")
%% section 1
% p1cont = (log(double(p1))./double((max(max(p1)) - min(min(p1)))));
% p1cont = p1cont / max(max(p1cont)) *255;
% figure
% imshow(uint8(p1cont))
% pichist(uint8(p1cont))
p1cont1 = uint8((double(p1 - min(min(p1))) / double(max(max(p1)) - min(min(p1))))*255);
figure(1)
subplot(2,2,3)
imshow(p1cont1)
title("picture 1 after stretch")

subplot(2,2,4)
hist1cont = pichist(p1cont1);
title("histogram : picture 1 after stretch")
ylabel("number of repeat")
xlabel("observation")

p1cont2 = uint8((double(p2 - min(min(p2))) / double(max(max(p2)) - min(min(p2))))*255);
figure(2)
subplot(2,2,3)
imshow(p1cont2)
title("picture 2 after stretch")

subplot(2,2,4)
hist2cont = pichist(p1cont2);
title("histogram : picture 2 after stretch")
ylabel("number of repeat")
xlabel("observation")
%% section 2
 pp1 = hist1./pixels1;
 Fpp1 = zeros(1,256);
for index = 1:256
   Fpp1(index) = sum(pp1(1:index)) ;
end
figure(3)
sgtitle("Histogram Equalization")
subplot('Position',[.1 .55 .35 .35])
imshow(p1)
title("picture 1 before Equalization")
subplot(3,2,2)
bar((0:255),hist1);
title("histogram : picture 1 before Equalization")
ylabel("number of repeat")
xlabel("observation")

subplot(3,2,4)
bar((0:255),Fpp1);
title("transformation")

Sk1 = uint8(round(Fpp1*255));
eqp1 = zeros(size1(1),size1(2));
for indexw = 1:size1(1)
    for indexl = 1:size1(2)
        eqp1(indexw,indexl) = Sk1(p1(indexw,indexl)+1);
    end
end
eqp1 = uint8(eqp1);

subplot('Position',[.1 .1 .35 .35])

imshow(eqp1)
title("picture 1 after Equalization")

subplot(3,2,6)
pichist(eqp1);
title("histogram : picture 1 after Equalization")
ylabel("number of repeat")
xlabel("observation")

 pp2 = hist2./pixels2;
 Fpp2 = zeros(1,256);
for index = 1:256
   Fpp2(index) = sum(pp2(1:index)) ;
end
figure(4)
sgtitle("Histogram Equalization")
subplot('Position',[.1 .55 .35 .35])
imshow(p2)
title("picture 2 before Equalization")
subplot(3,2,2)
bar((0:255),hist2);
title("histogram : picture 2 before Equalization")
ylabel("number of repeat")
xlabel("observation")

subplot(3,2,4)
bar((0:255),Fpp2);
title("transformation")

Sk2 = uint8(round(Fpp2*255));
eqp2 = zeros(size2(1),size2(2));
for indexw = 1:size2(1)
    for indexl = 1:size2(2)
        eqp2(indexw,indexl) = Sk2(p2(indexw,indexl)+1);
    end
end
eqp2 = uint8(eqp2);

subplot('Position',[.1 .1 .35 .35])

imshow(eqp2)
title("picture 2 after Equalization")

subplot(3,2,6)
pichist(eqp2);
title("histogram : picture 2 after Equalization")
ylabel("number of repeat")
xlabel("observation")

%% 
p1fromF2 =  zeros(size1);
for indexw = 1:size1(1)
    for indexl = 1:size1(2)
        p1fromF2(indexw,indexl) = mean (find(Sk2 == eqp1(indexw,indexl),1));
        if (isnan(p1fromF2(indexw,indexl)))
           p1fromF2(indexw,indexl) = mean(find(Sk2 == 1 + eqp1(indexw,indexl),1)); 
        end
        if (isnan(p1fromF2(indexw,indexl)))
           p1fromF2(indexw,indexl) = mean(find(Sk2 == (-1) + eqp1(indexw,indexl),1)); 
        end
    end
end
p1fromF2 = uint8(p1fromF2);

figure(5)
sgtitle("reference")
subplot(3,1,1)
pichist(p1);
title("histogram : picture 1 before references")
ylabel("number of repeat")
xlabel("observation")
subplot(3,1,2)
pichist(eqp1);
title("histogram : Equalized picture 1 ")
ylabel("number of repeat")
xlabel("observation")
subplot(3,1,3)
pichist(p1fromF2);
title("histogram : matched picture 1  ")
ylabel("number of repeat")
xlabel("observation")

figure(6)
sgtitle("picture reference")
subplot(2,2,1)
imshow(p1)
title("picture 1")
subplot(2,2,2)
imshow(eqp1)
title("Equalied")
subplot(2,2,3)
imshow(p2)
title("picture 2")
subplot(2,2,4)

imshow(p1fromF2)
title("matched picture")

figure
psum = ones(200,200)*255;
psum(1:152,1:152) = p2;
d1 = 34;
d2 = 30;
psum(d1+2:152+d1,d2+2:152+d2) = p1fromF2(2:152,2:152);
imshow(uint8(psum))



