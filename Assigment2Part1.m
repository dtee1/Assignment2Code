% Student Name: David Talson
% Student Number: 101022690
% Elec4700 Assignment 2 Part 1 
% 
% Solving the potential for a 1D region 
clear all
nx = 50;
ny = 30;
G = sparse(nx*ny,ny*nx);
B = zeros(nx*ny,1);

for i=1:nx
    for j=1:ny
        n = j + (i-1)*ny;
        if i==1
            B(n,1)=1;
            G(n,n)=1;
        elseif i==nx
            B(n,1)=0;
            G(n,n)=1;
        else
       
        nxm = (i-2)*ny + j;
        nxp = i*ny + j;
        nym = (i-1)*ny + j-1;
        nyp = (i-1)*ny + j+1;
       
        G(n,n) = -4;
        G(n, nxm) = 1;
        G(n, nxp) = 1;
        G(n, nym) = 1;
        G(n, nyp) = 1;
        
        end
    end  
end

V = G\B;

for i=1:nx
    for j=1:ny
        n = j + (i-1)*ny;    
           map(i,j) = V(n,1);     
    end
end
figure(1)
surf(map);
title('Potential for a 1D region')
xlabel('Width')
ylabel('Length')
zlabel('Voltage')
colormap spring
colorbar 
grid on 

G = sparse(nx*ny,ny*nx);
B = zeros(nx*ny,1);
for i=1:nx
    for j=1:ny
        n = j + (i-1)*ny;
        if i==1&& j ~= 1 && j ~= ny
            B(n,1)=1;
            G(n,n)=1;
        elseif i==nx&& j ~= 1 && j ~= ny
            B(n,1)=1;
            G(n,n)=1;
        elseif j==1||j==ny
            B(n,1)=0;
            G(n,n)=1;
        else
            nxm = (i-2)*ny + j;
            nxp = i*ny + j;
            nym = (i-1)*ny + j-1;
            nyp = (i-1)*ny + j+1;

            G(n,n) = -4;
            G(n, nxm) = 1;
            G(n, nxp) = 1;
            G(n, nym) = 1;
            G(n, nyp) = 1;
        
        end
    end  
end

V = G\B;
for i=1:nx
    for j=1:ny
        n = j + (i-1)*ny;       
          map(i,j) = V(n,1);
        
    end
end

figure(2)
surf(map);
title('Potential for a 2D region')
xlabel('Width')
ylabel('Length')
zlabel('Voltage')
grid on 
colormap spring
colorbar 

a = ny; 
b = nx/2;
G = sparse(nx*ny,ny*nx);
B = zeros(nx*ny,1);
 
sum0=10;
sum1=100
sum2=200;

mesh0=10;
mesh1=100;
mesh2=200;

[nx1,ny1] = meshgrid(linspace(-b,b,mesh0),linspace(0,a,mesh0));
[nx2,ny2] = meshgrid(linspace(-b,b,mesh1),linspace(0,a,mesh1));
[nx3,ny3] = meshgrid(linspace(-b,b,mesh2),linspace(0,a,mesh2));

v1 = zeros(mesh0,mesh0);% sum==10, mesh=10
v2 = zeros(mesh0,mesh0);% sum=100, mesh=10
v3 = zeros(mesh0,mesh0);% sum=200,mesh=10
v4 = zeros(mesh1,mesh1);% sum=100,mesh=100
v5 = zeros(mesh2,mesh2);% sum=100, mesh=200 
v6 = zeros(mesh1,mesh1);% sum=200,mesh=100
v7 = zeros(mesh2,mesh2);% sum=200,mesh=200

% sum=10, mesh = 10
for k = 1:2:sum0
    v1 = v1 + (1/k).*(cosh((k*pi.*nx1)./(a))./cosh((k*pi*(b))/(a))).*sin((k*pi.*ny1)./(a));
end 
% sum=100, mesh = 10
for k = 1:2:sum1
    v2 = (v2 + (1/k).*(cosh((k*pi.*nx1)./(a))./cosh((k*pi*(b))/(a))).*sin((k*pi.*ny1)./(a)));
end  
% sum=200, mesh = 10
for k = 1:2:sum2
    v3 = (v3 + (1/k).*(cosh((k*pi.*nx1)./(a))./cosh((k*pi*(b))/(a))).*sin((k*pi.*ny1)./(a)));
end  
% sum=100, mesh = 100
for k = 1:2:sum1
    v4 = (v4 + (1/k).*(cosh((k*pi.*nx2)./(a))./cosh((k*pi*(b))/(a))).*sin((k*pi.*ny2)./(a)));
end
% sum=200, mesh = 100
for k = 1:2:sum1
    v6 = (v6 + (1/k).*(cosh((k*pi.*nx2)./(a))./cosh((k*pi*(b))/(a))).*sin((k*pi.*ny2)./(a)));
end  
% sum=100, mesh = 200
for k = 1:2:sum1
    v5 = (v5 + (1/k).*(cosh((k*pi.*nx3)./(a))./cosh((k*pi*(b))/(a))).*sin((k*pi.*ny3)./(a)));
end 
% sum=200, mesh = 200
for k = 1:2:sum2
    v7 = (v7 + (1/k).*(cosh((k*pi.*nx3)./(a))./cosh((k*pi*(b))/(a))).*sin((k*pi.*ny3)./(a)));
end 

v1=(4*1/pi).*v1;
v2=(4*1/pi).*v2;
v3=(4*1/pi).*v3;
v4=(4*1/pi).*v4;
v5=(4*1/pi).*v5;
v6=(4*1/pi).*v6;
v7=(4*1/pi).*v7;

figure(3)
subplot(3,2,1)
colormap spring
surf(v1)
title('Small Mesh, Small Sum')
xlabel('Length')
ylabel('Width')
zlabel('Voltage')
grid on
colorbar

subplot(3,2,2)
surf(v2)
title('Large Mesh, Mid Sum')
xlabel('Length')
ylabel('Width')
zlabel('Voltage')
grid on
colorbar

subplot(3,2,3)
surf(v3)
title('Large Mesh, Large Sum')
xlabel('Length')
ylabel('Width')
zlabel('Voltage')
grid on
colorbar

subplot(3,2,4)
surf(v4)
title('Mid Mesh Mid Sum')
xlabel('Length')
ylabel('Width')
zlabel('Voltage')
grid on
colorbar

subplot(3,2,5)
surf(v5)
title('Small Mesh Mid Sum')
xlabel('Length')
ylabel('Width')
zlabel('Voltage')
grid on
colorbar

subplot(3,2,6)
surf(v6)
title('Mid Mesh Large Sum')
xlabel('Length')
ylabel('Width')
zlabel('Voltage')
grid on
colorbar

figure(5)
colormap spring
surf(v7)
title('Small Mesh Large Sum')
xlabel('Length')
ylabel('Width')
zlabel('Voltage')
grid on
colorbar

