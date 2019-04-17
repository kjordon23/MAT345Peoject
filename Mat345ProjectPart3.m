%% Part 3 
A=imread("kharing.jpg");
% rotate the image in the x-y plane
R=[cosd(100),sind(100),0,0;-sind(100),cosd(100),0,0;0,0,1,0;0,0,0,1];
R1=[5,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1];
R2=[1,-2,0,0;0,1,0,0;0,0,1,0;0,0,0,1];
R3=(R2*R1)*R;
rform=affine3d(R3);
B=imwarp(A,rform);
imshow(B)

% Rotating back
D=inv(R3);
dform=affine3d(D);
C=imwarp(B,dform);
imshow(C)
