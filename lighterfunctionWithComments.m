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

%Först skapar vi en meshgrid för alla x och y koordinater
[X,Y] = meshgrid(-1:2/(size-1):1, -1:2/(size-1):1);

%Sen tar vi ut en cirkel från dessa genom att ta alla värden mindre
%än 1, likt som vi gjorde på bildbehandling.
Circle = (X.^2 + Y.^2) <1;

%Nu tar vi fram Z koordinaten och säger att den innehåller endast
%koordinater rakt fram, dvs det enda vi ser. Enligt ett klots ekvation
%blir då z = sqrt(1-x^2-y^2), sen tar man det gånger cirkeln så att
%man endast får koordinater framåt.
Z = sqrt((1-(X.^2+Y.^2))).*Circle;

%Nu klumpar vi ihop koordinaterna till en matris. Dessa koordinater
%kommer då vara cirkelns normaler, sosize vi ska använda för att
%kalkylera ljuset.
N(:,:,1)=X;
N(:,:,2)=Y;
N(:,:,3)=Z;


%Först normerar vi ljusvektorn, därefter skapar vi en oändlig ljuskälla
%genom att fylla riktningarna med vektorns värden
L = L/(L*L');
Ldir(:,:,1) = L(1)*ones(size,size);
Ldir(:,:,2)= L(2)*ones(size,size);
Ldir(:,:,3)= L(3)*ones(size,size);

%Liknande sätt för observerarn
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
 
%Beräknar ID faktorn genom att ta skalärprodukten(enligt formeln i peket)
%sen ta gånger cirkelmasken
ID = (max(sum(Ldir.*N,3),0)).*Circle;

%Vi gör på liknande sätt som innan
es = (L+H)./norm(L+H);
Edir(:,:,1) = es(1)*ones(size,size);
Edir(:,:,2)= es(2)*ones(size,size);
Edir(:,:,3)= es(3)*ones(size,size);

%Beräknar Is faktorn och tar gånger cirkelmasken
Is = (max(sum(Edir.*N,3),0)).^a;
Is = Is .*Circle;

%inbyggda funktionen som får finare resultat
W = specular(N(:,:,1),N(:,:,2),N(:,:,3),L,H,20);


%Här fyller vi en bild med information. 
%Varje lager motsvarer en RGB färg, där vi tar(enligt peket) ID gånger
%ljusets färg och sfärens färg, sen addera det med IS multiplicerat med
%ljusfärger och blänketsfärg. Allt detta görs på tre olika lager, därav ser
%det ut som nedan.
img(:,:,1) = Z.*((ID.*lcolor(1).*scolor(1))+Is.*(lcolor(1).*spotcolor(1)));
img(:,:,2) = Z.*((ID.*lcolor(2).*scolor(2))+Is.*(lcolor(2).*spotcolor(2)));
img(:,:,3) = Z.*((ID.*lcolor(3).*scolor(3))+Is.*(lcolor(3).*spotcolor(3)));

%Returnerar bilden
Y = img;

end