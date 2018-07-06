function [ area ] = area_cal( testimgm )
%AREA Summary of this function goes here
%   Detailed explanation goes here

%===========================================================================================================

x=double(testimgm);                      %conversion to binary image
tot=0;
[a,b]=size(x);
y=zeros(a,b);
for i=1:a
    for j=1:b
        y(i,j)=0;
    end
end

for i=1:a
    for j=1:b
        tot=tot+x(i,j);
    end
end
thr=tot/(a*b);
thr=thr-30;
for i=1:a
    for j=1:b
        if x(i,j) > thr
            y(i,j)=0;
        else
            y(i,j)=1;
        end
    end
end
testimgbinary=imcomplement(y);

%===========================================================================================================
% testimgbinary=im2bw(testimgm,0.43);
%testimgbinary=imbinarize(testimgm);         %conversion to binary image
imwrite(testimgbinary,'.\temp\testimgbinary.jpg');

testimgcomplement=imcomplement(testimgbinary);                  %finding the complement
imwrite(testimgcomplement,'.\temp\testimgcomplement.jpg');

%
testimgfilter=medfilt2(testimgcomplement);                      %noise removal
testimgfilled = imfill(testimgfilter,'holes');                  %filling holes
se=strel('disk',1);
testimgopen=imopen(testimgfilled,se);
imwrite(testimgopen,'.\temp\testimgopen.jpg');

testimgedge=edge(testimgopen,'sobel');
area1=regionprops(testimgedge,'FilledArea');                      %finding the area of mouth
% area=regionprops(testimgopen,'FilledArea'); 
area=max([area1.FilledArea]) ;


figure;
subplot(2,2,1);imshow(testimgfilled);
subplot(2,2,2);imshow(testimgbinary);
subplot(2,2,3);imshow(testimgopen);
subplot(2,2,4);imshow(testimgedge);
end