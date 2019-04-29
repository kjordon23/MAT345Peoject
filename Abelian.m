imagepad = imread('pic.png');
[nrows ncols nslices] = size(imagepad);
midx=ceil((ncols+1)/2);
midy=ceil((nrows+1)/2);

scale = [2/3 0; 0 1];

% Ensures that transformation is being performed about the center
[X Y] = meshgrid(1:ncols,1:nrows);
XYt = [X(:)-midx Y(:)-midy]*scale;
XYt = bsxfun(@plus,XYt,[midx midy]);

xout = round(XYt(:,1)); yout = round(XYt(:,2)); % calculating nearest neighbor!
outbound = yout<1 | yout>nrows | xout<1 | xout>ncols;
zout=repmat(cat(3,1,2,3),nrows,ncols,1); zout=zout(:);
xout(xout<1) = 1; xout(xout>ncols) = ncols;
yout(yout<1) = 1; yout(yout>nrows) = nrows;
xout = repmat(xout,[3 1]); yout = repmat(yout,[3 1]);
imagescale = imagepad(sub2ind(size(imagepad),yout,xout,zout(:))); % lookup
imagescale = reshape(imagescale,size(imagepad)); % Resizes the size of the matrix to the scale factor
imagescale(repmat(outbound,[1 1 3])) = 0; % set background value to [0 0 0] (black)
figure;
imshow(imagescale)

degree = 30;
% Convert to radians and create transformation matrix
a = degree*pi/180;
R = [+cos(a),+sin(a); -sin(a),+cos(a)];

% Figure out the size of the transformed image
[m,n,p] = size(imagescale);
dest = round( [1 1; 1 n; m 1; m n]*R ); 
dest = bsxfun(@minus, dest, min(dest)) + 1;
imagerot = zeros([max(dest) p],class(imagescale)); % Insert Place Values in new Matrix

% Map all pixels of the transformed image to the original image
    for ii = 1:size(imagerot,1)
        for jj = 1:size(imagerot,2)
            source = ([ii jj]-dest(1,:))*R.';
            if all(source >= 1) && all(source <= [m n])

                % Get all 4 surrounding pixels
                C = ceil(source);
                F = floor(source);

                % Compute the relative areas and determine weighted 
                % averages for set of pixels. (Computes the rotation
                % transformation as a "translation" which causes each pixel
                % to translate to the rotated position.
                A = [...
                    ((C(2)-source(2))*(C(1)-source(1))),...
                    ((source(2)-F(2))*(source(1)-F(1)));
                    ((C(2)-source(2))*(source(1)-F(1))),...
                    ((source(2)-F(2))*(C(1)-source(1)))];

                % Extract colors and re-scale them relative to area
                cols = bsxfun(@times, A, double(imagescale(F(1):C(1),F(2):C(2),:)));
                % All of the other values will be assigned to black pixels
                % (color value of 0)
                % Assign computed values                  
                imagerot(ii,jj,:) = sum(sum(cols),2);

            end
        end
    end        
figure;
imshow(imagerot);

[nrows ncols nslices] = size(imagerot);
midx=ceil((ncols+1)/2);
midy=ceil((nrows+1)/2);

stretch = [1 0; 0 4]; % Scaling matrix

% Ensures that transformation is being performed about the center
[X Y] = meshgrid(1:ncols,1:nrows);
XYt = [X(:)-midx Y(:)-midy]*stretch;
XYt = bsxfun(@plus,XYt,[midx midy]);

xout = round(XYt(:,1)); yout = round(XYt(:,2)); % calculating nearest neighbor!
outbound = yout<1 | yout>nrows | xout<1 | xout>ncols;
zout=repmat(cat(3,1,2,3),nrows,ncols,1); zout=zout(:);
xout(xout<1) = 1; xout(xout>ncols) = ncols;
yout(yout<1) = 1; yout(yout>nrows) = nrows;
xout = repmat(xout,[3 1]); yout = repmat(yout,[3 1]);
imagestretch = imagerot(sub2ind(size(imagerot),yout,xout,zout(:))); % lookup
imagestretch = reshape(imagestretch,size(imagerot)); % Resizes the size of the matrix to the scale factor
imagestretch(repmat(outbound,[1 1 3])) = 0; % set background value to [0 0 0] (black)
figure;
imshow(imagestretch)