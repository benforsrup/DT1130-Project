function Y = lighterfunction(size, L,O, scolor,lcolor,spotcolor,a)
%
% Calculates the diffuse and specular pass of a sphere
%
% input: 
%   size (integer) - Size of sphere
%   L (vector) - Direction of the light
%   O (vector) - Direction of the observer

%   scolor (vector) - Color of the sphere
%   lcolor (vector) - Color of the light
%   spotcolor (vector) - Color of the specular spot
%   a (integer) - size of the specular spot
%
% output: 
%   img (matrix) - img of calculated light passes




size = 500;
N = zeros(size,size,3);
[X,Y] = meshgrid(-1:2/(size-1):1, -1:2/(size-1):1);
Circle = (X.^2 + Y.^2) <1;
Z = sqrt((1-(X.^2+Y.^2))).*Circle;

N(:,:,1)=X;
N(:,:,2)=Y;
N(:,:,3)=Z;


L = L./norm(L);
Ld(:,:,1) = L(1)*ones(size,size);
Ld(:,:,2)= L(2)*ones(size,size);
Ld(:,:,3)= L(3)*ones(size,size);
ID = (max(sum(Ld.*N,3),0)).*Circle;




O = O./norm(O);
es = (L+O)./norm(L+O);
Ed(:,:,1) = es(1)*ones(size,size);
Ed(:,:,2)= es(2)*ones(size,size);
Ed(:,:,3)= es(3)*ones(size,size);


Is = (max(sum(Ed.*N,3),0)).^a;
Is = Is .*Circle;


%W = specular(N(:,:,1),N(:,:,2),N(:,:,3),L,O,20);



% img(:,:,1) = (Z.*scolor(1))+0.3.*((ID.*lcolor(1).*scolor(1))+Is.*(lcolor(1).*spotcolor(1)));
% img(:,:,2) = (Z.*scolor(2))+0.3.*((ID.*lcolor(2).*scolor(2))+Is.*(lcolor(2).*spotcolor(2)));
% img(:,:,3) = (Z.*scolor(3))+0.3.*((ID.*lcolor(3).*scolor(3))+Is.*(lcolor(3).*spotcolor(3)));


% 
% img(:,:,1) = (Z.*scolor(1))+0.5.*Z.*((ID.*lcolor(1).*scolor(1))+Is.*(lcolor(1).*spotcolor(1)));
% img(:,:,2) = (Z.*scolor(2))+0.5.*Z.*((ID.*lcolor(2).*scolor(2))+Is.*(lcolor(2).*spotcolor(2)));
% img(:,:,3) = (Z.*scolor(3))+0.5.*Z.*((ID.*lcolor(3).*scolor(3))+Is.*(lcolor(3).*spotcolor(3)));


img(:,:,1) = Z.*((ID.*lcolor(1).*scolor(1))+Is.*(lcolor(1).*spotcolor(1)));
img(:,:,2) = Z.*((ID.*lcolor(2).*scolor(2))+Is.*(lcolor(2).*spotcolor(2)));
img(:,:,3) = Z.*((ID.*lcolor(3).*scolor(3))+Is.*(lcolor(3).*spotcolor(3)));

Y = img;


end