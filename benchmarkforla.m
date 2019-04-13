I = imread('art.png');
A = imresize(I,[600,900]);
imshow(A)
A = rgb2gray(A);
A = double(A)
%%Building the Zero Matrix

Matrix = zeros(1800,900);

%%filling in the zero matrix with x , y , g;
%multiply size of A,1 by 3 to make room for x y and g
for i = 3:3:1800
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


RMatrix = eye(1800,1800);
for p = 1:3:1800;
RMatrix(p,p) = 1/4;
end


NMatrix = RMatrix*Matrix;




%RMatrix = R*Matrix

%R = [1/2,0,0;0,1,0;0,0,1];




%for j = 1:1:size(A,1)
%G(1,j) = A(1,j)
%end
%x = size(A,1)/2
%y = size(A,2)/2



