%% Part 3 
A=imread("kharing.jpg");
% rotate the image in the x-y plane
R=[cosd(100),sind(100),0,0;-sind(100),cosd(100),0,0;0,0,1,0;0,0,0,1]; % transformation matrix that rotates the image clockwise by 100 degrees
R1=[5,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1]; % transformation matrix that makes stretches the image horizontally by a factor of 5
R2=[1,-2,0,0;0,1,0,0;0,0,1,0;0,0,0,1]; % transformation matrix pulling the images left and right bounds by a factor of 2
R3=(R2*R1)*R; % multiplying the transformation matricies together to get the final transformation matrix 

rform=affine3d(R3); 
B=imwarp(A,rform); % transforming the image by the transformations above
figure;
imshow(B) 

% Rotating the image back to its original viewing angle
D=inv(R3); % inverse of the transformation matrix is supposed to revert the image back to its self
dform=affine3d(D); 
C=imwarp(B,dform); % transforming the image back to the original
figure;
imshow(C)
