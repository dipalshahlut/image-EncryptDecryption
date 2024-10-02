function [ds] = ImageEncription(t,y,par,s)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

x1 = y(1); x2 = y(2); x3 = y(3);
y1 = y(4); y2 = y(5); y3 = y(6);
% z1 = y(7); z2 = y(8); z3 = y(9);

a = par(1); c = par(2); d1 = par(3); d2 = par(4); 
theta = 4;
% s ='1100001111100';
% for i = 1:length(s)
%     if (s(i) == '0') 
%        th = 4;
%        theta = theta+th;
%     else
%        th = 6;
%        theta = theta+th;
%     end
% end
if (abs(x1)-theta)>0
    bx = d1+d2;
else
    bx = d1-d2;
end

if (abs(y1)-theta)>0
    by = d1+d2;
else
    by = d1-d2;
end

%master equation
ds1 =a*(x2-x1);
ds2 = bx*x1 -x1*x3;
ds3 = -c*x3 + x1*x2;
% 
%controller design 
% u1 = -by*y1 + bx*x1 +a*x1 + y1*y3 -x1*y3 -a*y1;
% u2 = -y1*y2 + x1*y2;
% 
% % slave system
% ds4 = a*(y2-y1);
% ds5 = by*y1 -y1*y3+u1;
% ds6 =-c*y3 + y1*y2+u2;


% slave system
ds4 = a*(y2-y1);
ds5 = (by+20)*x1 -x1*y3-a*y1;
ds6 =-c*y3 + x1*y2;
% 
% dz1 = a*(z2-z1);
% dz2 = -x1*z3 - a*z1;
% dz3 = -c*z3 +x1*z2;

% ds = [ds1; ds2; ds3; ds4; ds5; ds6; ds7; ds8; ds9];
% ds = [ds1; ds2; ds3; ds4; ds5; ds6; dz1; dz2; dz3];
ds = [ds1; ds2; ds3; ds4; ds5; ds6];
end
