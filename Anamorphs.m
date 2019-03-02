%% Part 1 of MAT 345 Final Project
G = imread("pic.PNG");
% Part A: Perform a rotation of 30 degrees
R = [cosd(30) sind(30) 0;-sind(30) cosd(30) 0;0 0 1];
rform = affine2d(R);
G_rotated = imwarp(G,rform);
imshow(G_rotated)
% Part B: Perform compressing by a scalar of 2/3 along the y-axis
S = [1,0,0;0,2/3,0;0,0,1];
sform = affine2d(S);
G_scaled = imwarp(G, sform);
imshow(G_scaled)
% Part C: Stretch image by a factor of 4 times along the x-axis from Part B
S = [4,0,0;0,1,0;0,0,1]
sform = affine2d(S);
G_scaled2 = imwarp(G_scaled, sform)
imshow(G_scaled2)
% Part D: Rotate 30 Degrees from image on Part C
G_transform = imwarp(G_scaled2,rform)
imshow(G_transform)