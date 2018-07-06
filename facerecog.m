function [recognized_img]=facerecog(datapath,testimg)
D = dir(datapath);  % D is a Lx1 structure with 4 fields as: name,date,byte,isdir of all L files present in the directory 'datapath'
imgcount = 0;
for i=1 : size(D,1)
    if not(strcmp(D(i).name,'.')|strcmp(D(i).name,'..')|strcmp(D(i).name,'Thumbs.db'))
        imgcount = imgcount + 1; % Number of all images in the training database
    end
end
%creating the image matrix X 
X = [];
for i = 1 : imgcount
    str = strcat(datapath,'\',int2str(i),'.jpg');%%>>
    img = imread(str);
    img = rgb2gray(img);
    [r c] = size(img);
    temp = reshape(img',r*c,1); 
    X = [X temp];              
end
%Now we calculate m, A and eigenfaces.
m = mean(X,2); % Computing the average face image or mean image vector
imgcount = size(X,2);
%calculating A matrix, i.e. after subtraction of all image vectors from the mean image vector
A = [];
for i=1 : imgcount
    temp = double(X(:,i)) - m;
    A = [A temp];
end
L= A' * A;
[V,D]=eig(L);  % V : eigenvector matrix  D : eigenvalue matrix
% again we use Kaiser's rule here to find how many Principal Components (eigenvectors) to be taken
%if corresponding eigenvalue is greater than 1, then the eigenvector will be chosen for creating eigenface
L_eig_vec = [];
for i = 1 : size(V,2) 
    if( D(i,i) > 1 )
        L_eig_vec = [L_eig_vec V(:,i)];
    end
end
% finally the eigenfaces
eigenfaces = A * L_eig_vec;
%In this part of recognition, we compare two faces by projecting the images into facespace and 
%finding the projection of each image vector on the facespace (where the eigenfaces are the co-ordinates or dimensions)
projectimg = [ ];  % projected image vector matrix
for i = 1 : size(eigenfaces,2)
    temp = eigenfaces' * A(:,i);
    projectimg = [projectimg temp];
end
%extractiing PCA features of the test image
test_image = imread(testimg);
test_image = test_image(:,:,1);
[r c] = size(test_image);
temp = reshape(test_image',r*c,1); % creating (MxN)x1 image vector from the 2D image
temp = double(temp)-m; % mean subtracted vector
projtestimg = eigenfaces'*temp; % projection of test image onto the facespace
%calculating & comparing the euclidian distance of all projected trained images from the projected test image
euclide_dist = [ ];
for i=1 : size(eigenfaces,2)
    temp = (norm(projtestimg-projectimg(:,i)))^2;
    euclide_dist = [euclide_dist temp];
end
[euclide_dist_min recognized_index] = min(euclide_dist);
recognized_img = strcat(int2str(recognized_index),'.jpg');