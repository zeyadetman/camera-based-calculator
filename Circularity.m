function [ num ] = Circularity( img )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[H W] = size(img);
halfOfH = H/2;
upper = imcrop(img, [0 0 W halfOfH]);
lower = imcrop(img, [0 halfOfH W H]);
Lc = bwlabel(upper);
stats = regionprops(Lc,'all');
Perimeters = [stats.Perimeter];
Areas = [stats.Area];
Circularities = Perimeters  .^ 2 ./ (4 * pi* Areas);
num = Circularities;
end

