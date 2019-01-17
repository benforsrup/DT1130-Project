

%for testing
 L = [1 0 0];
 a = 100;
 size = 1000;
 H = [0 0 1];
 
scolor =[41 255 212] ./ 255;
lcolor = [41 255 212] ./ 255;
spotcolor =[250 250 250] ./ 255;
%%%%%%



N = zeros(size,size,3);

%Först skapar vi en meshgrid för alla x och y koordinater
[X,Y] = meshgrid(-1:2/(size-1):1, -1:2/(size-1):1);

%Sen tar vi ut en cirkel från dessa genom att ta alla värden mindre än 1,
%likt som vi gjorde på bildbehandling.
Circle = (X.^2 + Y.^2) <1;

%Nu tar vi fram Z koordinaten och säger att den innehåller endast
%koordinater rakt fram, dvs det enda vi ser. Enligt ett klots ekvation blir
%då z = sqrt(1-x^2-y^2), sen tar man det gånger cirkeln så att man endast
%får koordinater framåt.
Z = sqrt((1-(X.^2+Y.^2))).*Circle;

%Nu klumpar vi ihop koordinaterna till en matris. Dessa koordinater kommer
%då vara cirkelns normaler, som vi ska använda för att kalkylera ljuset.
N(:,:,1)=X;
N(:,:,2)=Y;
N(:,:,3)=Z;


L = L/(L*L');

Ldir(:,:,1) = L(1)*ones(size,size);
Ldir(:,:,2)= L(2)*ones(size,size);
Ldir(:,:,3)= L(3)*ones(size,size);


H = H/(H*H');
Hdir(:,:,1) = H(1)*ones(size,size);
Hdir(:,:,2)= H(2)*ones(size,size);
Hdir(:,:,3)= H(3)*ones(size,size);
% 
% nag = sqrt(N(:,:,1).^2 + N(:,:,2).^2 +N(:,:,3).^2) ;
% 
% Id = max(( Ldir(:,:,1).*N(:,:,1)+  Ldir(:,:,2).*N(:,:,2)  +   Ldir(:,:,3).*N(:,:,3)  ) ./nag,0).*Circle;
% 
%DP=max(0,sum(Ldir.*N,3)).*Circle;
% mag =N(:,:,1).^2 + N(:,:,2).^2 +N(:,:,3).^2;


%Is = specular(N(:,:,1),N(:,:,2),N(:,:,3),L,H,20);

ID = (max(sum(Ldir.*N,3),0)).*Circle;


es = (L+H)./norm(L+H);
Edir(:,:,1) = es(1)*ones(size,size);
Edir(:,:,2)= es(2)*ones(size,size);
Edir(:,:,3)= es(3)*ones(size,size);

Is = (max(sum(Edir.*N,3),0)).^100;
Is = Is .*Circle;


W = specular(N(:,:,1),N(:,:,2),N(:,:,3),L,H,20);
% Upphöjt till alpha enligt uppgifts-beskrivningen

%Colorering the sphere

% img(:,:,1) = Z.*scolor(1);
% img(:,:,2) = Z.*scolor(2);
% img(:,:,3) = Z.*scolor(3);

img(:,:,1) = Z.*((ID.*lcolor(1).*scolor(1))+Is.*(lcolor(1).*spotcolor(1)));
img(:,:,2) = Z.*((ID.*lcolor(2).*scolor(2))+Is.*(lcolor(2).*spotcolor(2)));
img(:,:,3) = Z.*((ID.*lcolor(3).*scolor(3))+Is.*(lcolor(3).*spotcolor(3)));

% q = Z.*ID.*lcolor(1);
% a = Z.*Is;
% f = q+(1.*a);




imagesc(img)
axis equal






