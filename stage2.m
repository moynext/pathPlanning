clc;clear;
k = 100; n = 40; part = 50;
obsPos = [21 61 15 91 81 61 41;25 19 56 41 89 61 99];
robot = [0;25];
roboti = [0;0];

u=inline('-(120 - x)./sqrt((100-y).^2+(120-x).^2)','x','y');
v=inline('-(100 - y)./sqrt((100-y).^2+(120-x).^2)','x','y');

obsx = inline('(2*k/n)*(xi-x).*(exp(-((xi-x).^2+(yi-y).^2)./n))','x','y','k','n','xi','yi');
obsy = inline('(2*k/n)*(yi-y).*(exp(-((xi-x).^2+(yi-y).^2)./n))','x','y','k','n','xi','yi');

x=linspace(0,150,part);
y=linspace(0,120,part);
[X,Y]=meshgrid(x,y);

st =sqrt((120-X).^2+(100-Y).^2);
ob1 = k * (exp(-((obsPos(1,1)-X).^2+(obsPos(2,1)-Y).^2)/n));
ob2 = k * (exp(-((obsPos(1,2)-X).^2+(obsPos(2,2)-Y).^2)/n));
ob3 = k * (exp(-((obsPos(1,3)-X).^2+(obsPos(2,3)-Y).^2)/n));
ob4 = k * (exp(-((obsPos(1,4)-X).^2+(obsPos(2,4)-Y).^2)/n));
ob5 = k * (exp(-((obsPos(1,5)-X).^2+(obsPos(2,5)-Y).^2)/n));
ob6 = k * (exp(-((obsPos(1,6)-X).^2+(obsPos(2,6)-Y).^2)/n));
ob7 = k * (exp(-((obsPos(1,7)-X).^2+(obsPos(2,7)-Y).^2)/n));
z=st + ob1 + ob2 + ob3 + ob4 + ob5 + ob6 + ob7;

hold on
contour(x,y,z)
contour3(X,Y,z);
surface(x,y,z,'EdgeColor',[.9 .9 .9])
surf(x,y,z)
obs_x = obsx(X,Y,k,n,obsPos(1,1),obsPos(2,1)) + obsx(X,Y,k,n,obsPos(1,2),obsPos(2,2)) +  obsx(X,Y,k,n,obsPos(1,3),obsPos(2,3)) + obsx(X,Y,k,n,obsPos(1,4),obsPos(2,4)) + obsx(X,Y,k,n,obsPos(1,5),obsPos(2,5)) + obsx(X,Y,k,n,obsPos(1,6),obsPos(2,6)) + obsx(X,Y,k,n,obsPos(1,7),obsPos(2,7));
obs_y = obsy(X,Y,k,n,obsPos(1,1),obsPos(2,1)) + obsy(X,Y,k,n,obsPos(1,2),obsPos(2,2)) +  obsy(X,Y,k,n,obsPos(1,3),obsPos(2,3)) + obsy(X,Y,k,n,obsPos(1,4),obsPos(2,4)) + obsy(X,Y,k,n,obsPos(1,5),obsPos(2,5)) + obsy(X,Y,k,n,obsPos(1,6),obsPos(2,6)) + obsy(X,Y,k,n,obsPos(1,7),obsPos(2,7));
U=-(u(X,Y) + obs_x);
V=-(v(X,Y) + obs_y);

quiver(X,Y,U,V)
axis image

while (abs(robot(1) - 120) + abs(robot(2) - 100) > 2) ,
    scatter(robot(1), robot(2), 'black','filled');
    roboti(1) = - (u(robot(1),robot(2)) + obsx(robot(1),robot(2),k,n,obsPos(1,1),obsPos(2,1)) + obsx(robot(1),robot(2),k,n,obsPos(1,2),obsPos(2,2)) +obsx(robot(1),robot(2),k,n,obsPos(1,3),obsPos(2,3)) +obsx(robot(1),robot(2),k,n,obsPos(1,4),obsPos(2,4)) + obsx(robot(1),robot(2),k,n,obsPos(1,5),obsPos(2,5)) + obsx(robot(1),robot(2),k,n,obsPos(1,6),obsPos(2,6)) + obsx(robot(1),robot(2),k,n,obsPos(1,7),obsPos(2,7)) ); 
    roboti(2) = - (v(robot(1),robot(2)) + obsy(robot(1),robot(2),k,n,obsPos(1,1),obsPos(2,1)) + obsy(robot(1),robot(2),k,n,obsPos(1,2),obsPos(2,2)) +obsy(robot(1),robot(2),k,n,obsPos(1,3),obsPos(2,3)) +obsy(robot(1),robot(2),k,n,obsPos(1,4),obsPos(2,4)) + obsy(robot(1),robot(2),k,n,obsPos(1,5),obsPos(2,5)) + obsy(robot(1),robot(2),k,n,obsPos(1,6),obsPos(2,6)) + obsy(robot(1),robot(2),k,n,obsPos(1,7),obsPos(2,7)) );
    
    robot(1) = robot(1) + 0.5 * roboti(1)/norm(roboti);
    robot(2) = robot(2) + 0.5 * roboti(2)/norm(roboti);
    
    pause(0.01)
end
%%scatter(2*robot(1),2*robot(2), 'black','filled');
