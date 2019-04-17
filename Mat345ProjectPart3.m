%% Part 3 
A=imread("kharing.jpg");
% rotate the image in the x-y plane
R=[cosd(30),sind(30),0,0;-sind(30),cosd(30),0,0;0,0,1,0;0,0,0,1];
R2=[1,2,0,0;3,1,0,0;0,0,1,0;0,0,0,1];
R3=R*R2;
rform=affine3d(R3);
B=imwarp(A,rform);
imshow(B)

