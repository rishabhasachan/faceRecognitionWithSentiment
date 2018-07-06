function [moutharea eyearea]=area(TestImage)


FDetect = vision.CascadeObjectDetector;
I = imread(TestImage);
BB = step(FDetect,I);
BB_copy=BB;
BB(1)=BB(1)-(BB(1)/2);
BB(2)=BB(2)-(BB(2)/2);
BB(3)=BB(3)+(BB(1)*2);
BB(4)=BB(4)+(BB(1)*2);
img_clipped=imcrop(I,BB);
img_clipped2 = imresize(img_clipped, [200 180]);
% figure;imshow(img_clipped);
% figure;imshow(img_clipped2);
imwrite(img_clipped2,'.\temp\temp.jpg');
TestImage='.\temp\temp.jpg';

% --- voila jones algo%------------------------------------- Mouth detection -------------------------------------%
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',100);
I_m = imread(TestImage);
figure;
imshow(I_m); %hold on
BBM = step(MouthDetect,I_m);
% for i = 1:size(BBM,1)
%     rectangle('Position',BBM(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','g');
% end
outm=insertObjectAnnotation(I_m,'rectangle',BBM,'Mouth');
imshow(outm);

imgcrop=imcrop(I_m,BBM);
imwrite(imgcrop,'.\temp\imgcropm.jpg');
testimgm1=imread('.\temp\imgcropm.jpg');
if size(testimgm1,3)==3
testimgm=rgb2gray(testimgm1);  % converting to greyscale
else
    testimgm=testimgm1;
end
% --- voila jones algo%------------------------------------- eye detection -------------------------------------%
EyeDetect=vision.CascadeObjectDetector('EyePairBig');
I_e = imread(TestImage);
figure;
imshow(I_e);
BBE = step(EyeDetect,I_e);

% for i = 1:size(BBM,1)
%     rectangle('Position',BBM(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','g');
% end

oute=insertObjectAnnotation(I_e,'rectangle',BBE,'Eyes');
imshow(oute);
imgcrop=imcrop(I_e,BBE);
imwrite(imgcrop,'.\temp\imgcrope.jpg');
testimge1=imread('.\temp\imgcrope.jpg');
if size(testimge1,3)==3
testimge=rgb2gray(testimge1);  % converting to greyscale
else
    testimge=testimge1;
end

moutharea=area_cal(testimgm);
eyearea=area_cal(testimge);


%------------------------------------- SA ends -------------------------------------%

%%