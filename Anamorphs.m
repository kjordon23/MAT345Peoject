G = imread("pic.PNG");
G_ref = imref2d(size(G))
R = [cosd(30) sind(30) 0;-sind(30) cosd(30) 0;0 0 1];
rform = affine2d(R)
G_rotated = imwarp(G,rform)
imshow(G_rotated)