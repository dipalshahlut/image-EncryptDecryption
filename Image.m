clc; clear all; close all
I = imread('lena512color.tiff');
figure;
imshow(I);
title('Original image')
[u,v,w] = size(I);
n =u*v;
I = double(I);
S1 = zeros(u,v);  S2 = zeros(u,v);  S3 = zeros(u,v);
%% permutation
% y =[0.2 0.7 1.6 0.7 0.95 2];
y =[0.2 0.7 1.6 0.7 0.95 2];
% y =[0.12 0.4 0.8 0.2 0.5 0.95];
% yinit = [y y(4)-y(1) y(5)-y(2) y(6)-y(3)];
a = 20; c = 8; d1 = 70; d2 = 15;
par = [a c d1 d2];
ts = 0; tspan = linspace(0,1000,300000);
[t,s] = ode45(@ImageEncription,tspan,y,[],par);
x1 = s(37857:end,1); x2 = s(37857:end,2); x3 = s(37857:end,3);
y1 = s(37857:end,4); y2 = s(37857:end,5); y3 = s(37857:end,6);
% e1 = s(37857:end,7);   e2 = s(37857:end,8);   e3 = s(37857:end,9);
e1 = y1-x1;   e2 = y2-x2;   e3 = y3-x3;
figure
plot3(s(37857:end,1),s(37857:end,2), s(37857:end,3), 'b.')
xlabel('x');ylabel('y');zlabel('z') 
title('Lorenz like sys1');
figure
plot3(s(37857:end,4), s(37857:end,5), s(37857:end,6), 'r.');
xlabel('x');ylabel('y');zlabel('z') 
title('Lorenz like sys2'); 
figure
subplot(131)
plot(t,s(:,1),'r')
subplot(132)
plot(t,s(:,2),'r')
subplot(133)
plot(t(37857:end),y1-x1,'r')
%%
Zm_x1=1000*x1-round(1000*x1);
Zm_x2=1000*x2-round(1000*x2);
Zm_x3=1000*x3-round(1000*x3);

[Sx1,lx]=sort(Zm_x1);
[Sx2,ly]=sort(Zm_x2);
[Sx3,lz]=sort(Zm_x3);

%% Image Encryption
P1=I(:,:,1);   P2=I(:,:,2);   P3=I(:,:,3);
P1=reshape(P1,1,[]);P2=reshape(P2,1,[]);
P3=reshape(P3,1,[]);
A2(1:n)=P1(lx);
B2(1:n)=P2(ly);
C2(1:n)=P3(lz);
A2=reshape(A2,size(I,1),size(I,2));
B2=reshape(B2,size(I,1),size(I,2));
C2=reshape(C2,size(I,1),size(I,2));
Enc = zeros(512,512,3);
Enc(:,:,1)=A2;
Enc(:,:,2)=B2;
Enc(:,:,3)=C2;
Enc = uint8(Enc);
figure;
imshow(Enc); 
title('encrypted image');

%% Image Decryption 

%simo
Enc = double(Enc);

Zm_y1=1000*y1-round(1000*y1);
Zm_y2=1000*y2-round(1000*y2);
Zm_y3=1000*y3-round(1000*y3);

[Sy1,lx1]=sort(Zm_y1);
[Sy2,ly1]=sort(Zm_y2);
[Sy3,lz1]=sort(Zm_y3);

A3=Enc(:,:,1); B3=Enc(:,:,2); C3=Enc(:,:,3);
A3=reshape(A3,1,[]);
B3=reshape(B3,1,[]);
C3=reshape(C3,1,[]);
A4(lx1)=A3(1:n);
B4(ly1)=B3(1:n);
C4(lz1)=C3(1:n);
A5=reshape(A4,size(Enc,1),size(Enc,2));
B5=reshape(B4,size(Enc,1),size(Enc,2));
C5=reshape(C4,size(Enc,1),size(Enc,2));
Decrypt = zeros(512,512,3);
Decrypt(:,:,1)=A5;
Decrypt(:,:,2)=B5;
Decrypt(:,:,3)=C5;
Decrypt = uint8(Decrypt);
figure;
imshow(Decrypt); 
title('Decrypted image');

% % DiffImage = double(I)-double(Decrypt);
% % find(DiffImage(:,:,1) > 0)