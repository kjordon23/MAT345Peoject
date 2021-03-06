


R = [0 -1 0;1 0 0;0 0 1]
A = imread('art.png');
rform = affine2d(R);
A = imwarp(A,rform);

A = imresize(A,[600,900]);
imshow(A)
A = rgb2gray(A);
A = double(A);
%%Building the Zero Matrix

Matrix = zeros(1800,900);
%% Making Matrix in (x, y, g)
%%filling in the zero matrix with x , y , g;
%multiply size of A,1 by 3 to make room for x y and g
for i = 3:3:1800;
%get the gradient from the original image matrix
%divide by 3 so you can count by one
gradient = A((i/3),:);
%get the columns (-400 to 400) round first number down round second number
%up
columns = ceil(-size(A,2)/2):1:floor(size(A,2)/2)-1;
%make all y same for every row count down by one. from 250 to -250
rows = ones(1,900)*(301-(i/3));
%sub 2 to start at one.
Matrix(i-2,:) = columns;
%sub 1 to put at second one in the set
Matrix(i-1,:) = rows ;
% put at three in the set
Matrix(i,:) = gradient;
end

%% creating the transformation matrix
RMatrix = eye(1800,1800);
for p = 1:3:1800;
RMatrix(p,p) = 1/4;
end



%% get the product to transform the matrix
NMatrix = RMatrix*Matrix;


%create new matrix to put values
C_Matrix = zeros(600,224);
%blank matrix
Zero = zeros(3,900);


%% translate image back to original format
%delete all numbers that have a decimal.
for j = 3:3:1800;
x = 1
Zero(1,:) = NMatrix(j-2,:);
Zero(2,:) = NMatrix(j-1,:);
Zero(3,:)= NMatrix(j,:);

for i = 1:1:900;
if (rem(Zero(1,i),1) == 0)
 C_Matrix(j/3,x) = Zero(3,i);
 x = x+1;
 
end

end
end

%show image
C_Matrix = uint8(C_Matrix);
imshow(C_Matrix);



