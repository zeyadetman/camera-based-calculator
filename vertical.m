function [ out, out2 ] = vertical( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% img=im2bw(img);
BW = edge(img,'canny');
[H,T,R] = hough(BW);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(img,T,R,P,'FillGap',10,'MinLength',1);
% figure, imshow(im2bw(img)), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end


mxwdth = 0;
mxhght = 0;
for i=1:length(lines)
    if(lines(i).theta == 0)
        if(abs(lines(i).point1(2)-lines(i).point2(2)) > mxhght)
            mxhght = abs(lines(i).point1(2)-lines(i).point2(2));
        end
    elseif(lines(i).theta == -90)
        if(abs(lines(i).point1(1)-lines(i).point2(1)) > mxwdth)
            mxwdth = abs(lines(i).point1(1)-lines(i).point2(1));
        end
    end
end

out = mxhght;
out2 = mxwdth;    
end


