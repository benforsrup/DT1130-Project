
 a = 100;
 size = 400;
 H = [0 0 1];
 
scolor = [6 201 245] ./ 255; %F?rg p? klotet
lcolor = [59 250 20] ./ 255; %F?rg p? ljuset
spotcolor =[250 250 250] ./ 255; %F?rg p? spekul?ra spoten


n=2;

% MOV = VideoWriter('Spherebigspot', 'MPEG-4');
% open(MOV);
for i=-5:0.1:n*pi
  
   L = [ 0 sin(i) cos(i)];
   I = lighterfunction(size,L,H,scolor,lcolor,spotcolor,a);
   imagesc(I)
   axis equal
   pause(0.0001)
    %currFrame = getframe;
    %writeVideo(MOV, currFrame);
 end
 %close(MOV);


axis equal
