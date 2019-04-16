%% Part 1 of MAT 345 Final Project
G = imread("pic.PNG");
% Part A: Perform a rotation of 30 degrees
R = [cosd(30) sind(30) 0;-sind(30) cosd(30) 0;0 0 1];
rform = affine2d(R)
G_rotated = imwarp(G,rform);
figure;
imshow(G_rotated)
revert = inv(R);
revert_form = affine2d(revert);
G_revert = imwarp(G_rotated, revert_form);
figure;
imshow(G_revert);