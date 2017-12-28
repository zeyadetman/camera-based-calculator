function [ imgouter ] = preprocessing( x)
i=rgb2gray(x);
y=medfilt2(i);
fff = im2bw(y, graythresh(y));
img=fff;
imgout = (img>mean(img(:)));
colorWhite = 0;
colorBlack = 0;
[H W] = size(imgout);
imgouter = zeros(H, W);
for i=1:H
    for j=1:W
        if(imgout(i,j) == 1)
            colorWhite = colorWhite+1;
        else
            colorBlack = colorBlack+1;
        end
    end
end

if(colorWhite>colorBlack)
    
    imgouter = imcomplement(imgout);
else
    imgouter = imgout;

se = strel('square',3);
closeBW = imclose(imgouter,se);
imgouter = imdilate(closeBW,se);
imgouter = imresize(imgouter,3);
se = strel('square',4);
closeBW = imclose(imgouter,se);
imgouter = imdilate(closeBW,se);
imshow(imgouter);
end
end