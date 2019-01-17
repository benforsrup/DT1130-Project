function Y = lighterfunction(size, L,H, scolor,lcolor,spotcolor,a)
%
% Calculates the diffuse and specular pass of a sphere
%
% input: N (matrix) - MxMx3 with coordinates of the normals of
% a sphere L (vector) - Direction of the light H (vector) - Direction of
% the observer
%
% output: img (matrix) - img of calculated light passes

%Allocating N
N = zeros(size,size,3);

%F�rst skapar vi en meshgrid f�r alla x och y koordinater
[X,Y] = meshgrid(-1:2/(size-1):1, -1:2/(size-1):1);

%Sen tar vi ut en cirkel fr�n dessa genom att ta alla v�rden mindre
%�n 1, likt som vi gjorde p� bildbehandling.
Circle = (X.^2 + Y.^2) <1;

%Nu tar vi fram Z koordinaten och s�ger att den inneh�ller endast
%koordinater rakt fram, dvs det enda vi ser. Enligt ett klots ekvation
%blir d� z = sqrt(1-x^2-y^2), sen tar man det g�nger cirkeln s� att
%man endast f�r koordinater fram�t.
Z = sqrt((1-(X.^2+Y.^2))).*Circle;

%Nu klumpar vi ihop koordinaterna till en matris. Dessa koordinater
%kommer d� vara cirkelns normaler, sosize vi ska anv�nda f�r att
%kalkylera ljuset.
N(:,:,1)=X;
N(:,:,2)=Y;
N(:,:,3)=Z;


%F�rst normerar vi ljusvektorn, d�refter skapar vi en o�ndlig ljusk�lla
%genom att fylla riktningarna med vektorns v�rden
L = L/(L*L');
Ldir(:,:,1) = L(1)*ones(size,size);
Ldir(:,:,2)= L(2)*ones(size,size);
Ldir(:,:,3)= L(3)*ones(size,size);

%Liknande s�tt f�r observerarn
H = H/(H*H');
Hdir(:,:,1) = H(1)*ones(size,size);
Hdir(:,:,2)= H(2)*ones(size,size);
Hdir(:,:,3)= H(3)*ones(size,size);

% nag = sqrt(N(:,:,1).^2 + N(:,:,2).^2 +N(:,:,3).^2) ;
% 
% Id = sizeax(( Ldir(:,:,1).*N(:,:,1)+  Ldir(:,:,2).*N(:,:,2)  +
% Ldir(:,:,3).*N(:,:,3)  ) ./nag,0).*Circle;
% 
% %DP=sizeax(0,susize(Ldir.*N,3)).*Circle; sizeag =N(:,:,1).^2 +
% N(:,:,2).^2 +N(:,:,3).^2;
% 
% %Is = specular(N(:,:,1),N(:,:,2),N(:,:,3),L,H,20);
 
%Ber�knar ID faktorn genom att ta skal�rprodukten(enligt formeln i peket)
%sen ta g�nger cirkelmasken
ID = (max(sum(Ldir.*N,3),0)).*Circle;

%Vi g�r p� liknande s�tt som innan
es = (L+H)./norm(L+H);
Edir(:,:,1) = es(1)*ones(size,size);
Edir(:,:,2)= es(2)*ones(size,size);
Edir(:,:,3)= es(3)*ones(size,size);

%Ber�knar Is faktorn och tar g�nger cirkelmasken
Is = (max(sum(Edir.*N,3),0)).^a;
Is = Is .*Circle;

%inbyggda funktionen som f�r finare resultat
W = specular(N(:,:,1),N(:,:,2),N(:,:,3),L,H,20);


%H�r fyller vi en bild med information. 
%Varje lager motsvarer en RGB f�rg, d�r vi tar(enligt peket) ID g�nger
%ljusets f�rg och sf�rens f�rg, sen addera det med IS multiplicerat med
%ljusf�rger och bl�nketsf�rg. Allt detta g�rs p� tre olika lager, d�rav ser
%det ut som nedan.
img(:,:,1) = Z.*((ID.*lcolor(1).*scolor(1))+Is.*(lcolor(1).*spotcolor(1)));
img(:,:,2) = Z.*((ID.*lcolor(2).*scolor(2))+Is.*(lcolor(2).*spotcolor(2)));
img(:,:,3) = Z.*((ID.*lcolor(3).*scolor(3))+Is.*(lcolor(3).*spotcolor(3)));

%Returnerar bilden
Y = img;

end