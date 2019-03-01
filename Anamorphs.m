%% Project 1 Anamorphs

% Cory Fisher
% Linear Algebra, MAT-345

%% Part 1

% part a
% read in the image of the circle
I = imread('finalprojectpart1.JPG');
% display the image
imshow(I)

% part b
% rotate the image 30 degrees using the rotation matrix
%rotateM = [cos(30), -sin(30); sin(30), cos(30)];
%rotatedI = I*rotateM;
%imshow(rotatedI)

% check the rotation
rotateCheck = imrotate(I, 30);
imshow(rotateCheck)