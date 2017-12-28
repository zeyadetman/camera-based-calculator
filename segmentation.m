function [ ] = segmentation( inputimg )
% inputimg=rgb2gray(inputimg);
Lc = bwlabel(inputimg);
stats = regionprops(Lc,'all');
imshow(stats(1).Image);
[x y] = size(stats);
for i=1:x
    
    h = figure;
    I1 = stats(i).Image;
     imshow(I1);
    %horizontal(I1);
    st = regionprops(I1,'all');
    area = st.Area;
    [VL HL] = vertical(I1);
    [hight width] = size(I1);
    if (area > 15)
        if(holes(I1) == 2)
            fprintf('8');
        elseif(holes(I1) == 1)
            BW2 = imfill(I1,'holes');
            stat22 = regionprops(BW2,'all');
            len = length(stat22);
            Perimeters = [stat22(len).Perimeter];
            Areas = [stat22(len).Area];
            Circularities = Perimeters  .^ 2 ./ (4 * pi* Areas);
            if(floor(Circularities) == 1)
                fprintf('0');
            else
                num = floor(Circularity(BW2));
                num2 = floor(Circularitybelow(BW2));
                imshow(BW2);
                if (num == 1)
                    fprintf('9');
                elseif (num2==1 )
                    fprintf('6');
                else
                    fprintf('4');
                end
            end
        else %holes =0
            [H W] = size(I1);
            I2 = im2uint8(I1);
            verticalLineimg = insertShape(I2, 'line', [0 0 0 H], 'LineWidth', 10,'Color','white');
            verticalLineimg = im2bw(verticalLineimg);
            imshow(verticalLineimg);
            [r1 r2] = vertical(verticalLineimg);
            if(holes(verticalLineimg) == 0 && abs(r1-H)<2 )
                fprintf('1');
            elseif(holes(verticalLineimg) > 0)
                verticalLineimg = im2uint8(verticalLineimg);
                horizontalLineimg = insertShape(verticalLineimg, 'line', [0 H/2 W H/2], 'LineWidth', 10,'Color','white');
                horizontalLineimg = im2bw(horizontalLineimg);
                imshow(horizontalLineimg);
                halfOfH = H/2;
                upper = imcrop(horizontalLineimg, [0 0 W halfOfH]);
                lower = imcrop(horizontalLineimg, [0 halfOfH W H]);
                imshow(upper);
                imshow(lower);
                if(holes(upper) >= 1 && holes(lower) >= 1)
                    fprintf('3');
                elseif(holes(lower) >= 1)
                    fprintf('5');
                else
                    horizontalLineimg = im2bw(horizontalLineimg);
                    BW2 = imfill(horizontalLineimg,'holes');
                    stat22 = regionprops(BW2,'all');
                    len = length(stat22);
                    if(Circularity(BW2)==1)
                        fprintf('2');
                    else
                        fprintf('7');
                    end
                end
        end
        
        imshow(I1); 
        rectangle('Position',st.BoundingBox,'EdgeColor','black','LineWidth',1 );
        saveas(h,strcat('PIC31',num2str(i)),'jpg');
        
    end
    
end
end