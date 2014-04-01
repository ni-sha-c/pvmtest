clear;
%close all
part=load('Positions');
d=121;
length(part)/d
number=1;
f1=figure(13)
xb=part(1:number*(d-1),1);
yb=part(1:number*(d-1),2);
zb=part(1:number*(d-1),3);
iset=0;
%for i=1:10:(length(part)+number)/d-number
%for i=1:3:(length(part)+number)/d-number-5
%st=number*(d-1)+(i-1)*d+1;
%en=st+d-1;
%plot3(part(st:en,1),part(st:en,2),part(st:en,3),'r-')
%iset=iset+1;
%x(iset,:)=part(st:en,1)';
%y(iset,:)=part(st:en,2)';
%z(iset,:)=part(st:en,3)';
%u(iset,:)=part(st:en,7)';
%v(iset,:)=part(st:en,8)';
%w(iset,:)=part(st:en,9)';
%hold on
%end
plot3(xb,yb,zb,'g.');
axis equal
f2=figure(11)
surf(x,y,z)
hold on
plot3(xb,yb,zb,'g.');
axis equal
alpha=0.
tangent_x=cos(alpha*pi/180);
tangent_y=0.0;
tangent_z=sin(alpha*pi/180);
uu=u*tangent_x+v*tangent_y+w*tangent_z;

tangent_x=-sin(alpha*pi/180);
tangent_y=0.0;
tangent_z=cos(alpha*pi/180);
ww=u*tangent_x+v*tangent_y+w*tangent_z;

vtot=sqrt(u.*u+w.*w+v.*v);
vv=sqrt(vtot.*vtot-uu.*uu-ww.*ww);

