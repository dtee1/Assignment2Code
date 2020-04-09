clear all
% Student Name: David Talson
% Student Number: 101022690
% Elec4700 Assignment 2 Part 1 
% 
% Solving the potential for a 1D region 
nx=50;
ny=30;
CurrDen = [];
G=sparse(nx*ny,nx*ny);
B=zeros(nx*ny,1);
x2=35;
x1=15;
y2=20;
y1=10;
condRegion=1;
condBottle=0.01;
cond=1.*ones(nx,ny);

for i = 1:nx
    for j = 1:ny
        if(((i>=x1)&&(i<=x2)&&(j<=y1))||((i>=x1)&&(i<=x2)&&(j>=y2)))
            cond(i,j) = condBottle;
        end
    end
end

for i=1:nx
    for j=1:ny
        
        n = j + (i-1)*ny;
        nxm = (i-2)*ny + j;
        nxp = i*ny + j;
        nym = (i-1)*ny + j-1;
        nyp = (i-1)*ny + j+1;
        
        if i==1
            B(n,1)=1;
            G(n,n)=1;
        elseif i==nx
            B(n,1)=0;
            G(n,n)=1;
        elseif j==1
            B(n,1)=0;
            
            condxm = (cond(i,j) + cond(i-1,j))/2;
            condxp = (cond(i,j) + cond(i+1,j))/2;
            condyp = (cond(i,j) + cond(i,j+1))/2;
            
            G(n,n) = -(condxm+condxp+condyp);
            G(n,nxm) = condxm;
            G(n,nxp) = condxp;
            G(n,nyp) = condyp;
            
        elseif j==ny
            B(n,1)=0;
            
            condxm = (cond(i,j) + cond(i-1,j))/2;
            condxp = (cond(i,j) + cond(i+1,j))/2;
            condym = (cond(i,j) + cond(i,j-1))/2;
            
            G(n,n) = -(condxm+condxp+condym);
            G(n,nxm) = condxm;
            G(n,nxp) = condxp;
            G(n,nym) = condym;
        else
            B(n,1) = 0;
            condxm = (cond(i,j) + cond(i-1,j))/2;
            condxp = (cond(i,j) + cond(i+1,j))/2;
            condyp = (cond(i,j) + cond(i,j+1))/2;
            condym = (cond(i,j) + cond(i,j-1))/2;

            G(n,n) = -(condxm+condxp+condyp+condym);
            G(n,nxm) = condxm;
            G(n,nxp) = condxp;
            G(n,nym) = condym;
            G(n,nyp) = condyp;
            
        end
    end  
end
V=G\B;
for i = 1:nx
    for j = 1:ny
        n = j+(i-1)*ny;
        map(i,j) = V(n,1);
    end
end

[Ex,Ey] = gradient(map,1,1);

figure(5)
surf(cond)
colorbar
grid on 
colormap spring
title('Conductance Plot')
xlabel('Region Width')
ylabel('Region Length')

figure(6)
surf(map)
colorbar
grid on 
colormap spring
title('Voltage Plot of Region')
xlabel('Region Width')
ylabel('Region Length')

figure(7) 
quiver(-Ex,-Ey)
title('Electric Field of Region')
xlabel('Region Width')
ylabel('Region Length')
grid on 


figure(8)
quiver(cond.*(-Ex),cond.*(-Ey))
title('Current Density of Region')
xlabel('Region Width')
ylabel('Region Length')
grid on 



for numitr = 1:50
    nx = 4*numitr;
    ny = 3*numitr;
   
    G = sparse(ny*nx,ny*nx); 
    B = zeros(ny*nx,1);
 
    cond=1.*ones(nx,ny);
    for i = 1:nx
        for j = 1:ny
            if(((i>=x1)&&(i<=x2)&&(j<=y1))||((i>=x1)&&(i<=x2)&&(j>=y2)))
                cond(i,j) = condBottle;
            end
        end
    end

    for i=1:nx
        for j=1:ny

            n = j + (i-1)*ny;
            nxm = (i-2)*ny + j;
            nxp = i*ny + j;
            nym = (i-1)*ny + j-1;
            nyp = (i-1)*ny + j+1;

            if i==1
                B(n,1)=1;
                G(n,n)=1;
            elseif i==nx
                B(n,1)=0;
                G(n,n)=1;
            elseif j==1
                B(n,1)=0;

                condxm = (cond(i,j) + cond(i-1,j))/2;
                condxp = (cond(i,j) + cond(i+1,j))/2;
                condyp = (cond(i,j) + cond(i,j+1))/2;

                G(n,n) = -(condxm+condxp+condyp);
                G(n,nxm) = condxm;
                G(n,nxp) = condxp;
                G(n,nyp) = condyp;

            elseif j==ny
                B(n,1)=0;

                condxm = (cond(i,j) + cond(i-1,j))/2;
                condxp = (cond(i,j) + cond(i+1,j))/2;
                condym = (cond(i,j) + cond(i,j-1))/2;

                G(n,n) = -(condxm+condxp+condym);
                G(n,nxm) = condxm;
                G(n,nxp) = condxp;
                G(n,nym) = condym;
            else
                B(n,1) = 0;
                condxm = (cond(i,j) + cond(i-1,j))/2;
                condxp = (cond(i,j) + cond(i+1,j))/2;
                condyp = (cond(i,j) + cond(i,j+1))/2;
                condym = (cond(i,j) + cond(i,j-1))/2;

                G(n,n) = -(condxm+condxp+condyp+condym);
                G(n,nxm) = condxm;
                G(n,nxp) = condxp;
                G(n,nym) = condym;
                G(n,nyp) = condyp;

            end
        end  
    end

        V = G\B;
        for i = 1:nx
            for j = 1:ny
            n = j+(i-1)*ny;
            map(i,j) = V(n,1);
            end
        end
   
    [Ex,Ey] = gradient(map);
    jx = cond.*(-Ex);
    jy = cond.*(-Ey);
    CurrDen(numitr) = mean(mean((((jx.^2)+(jy.^2)).^0.5)));
end
figure(9)
plot(1:50,CurrDen)
title('Current Density for varying mesh sizes')
xlabel('Mesh Factor (Length = 4*Factor, Width=3*Factor)')
ylabel('Current Density')
grid on

for numitr = 1:25
 
    G = sparse(ny*nx,ny*nx); 
    B = zeros(ny*nx,1);
    x2 = 25+numitr;
    x1 = 25-numitr;
    cond=1.*ones(nx,ny);
    for i = 1:nx
        for j = 1:ny
            if(((i>=x1)&&(i<=x2)&&(j<=y1))||((i>=x1)&&(i<=x2)&&(j>=y2)))
                cond(i,j) = condBottle;
            end
        end
    end

    for i=1:nx
        for j=1:ny
            
            n = j + (i-1)*ny;
            nxm = (i-2)*ny + j;
            nxp = i*ny + j;
            nym = (i-1)*ny + j-1;
            nyp = (i-1)*ny + j+1;

            if i==1
                B(n,1)=1;
                G(n,n)=1;
            elseif i==nx
                B(n,1)=0;
                G(n,n)=1;
            elseif j==1
                B(n,1)=0;

                condxm = (cond(i,j) + cond(i-1,j))/2;
                condxp = (cond(i,j) + cond(i+1,j))/2;
                condyp = (cond(i,j) + cond(i,j+1))/2;

                G(n,n) = -(condxm+condxp+condyp);
                G(n,nxm) = condxm;
                G(n,nxp) = condxp;
                G(n,nyp) = condyp;

            elseif j==ny
                B(n,1)=0;

                condxm = (cond(i,j) + cond(i-1,j))/2;
                condxp = (cond(i,j) + cond(i+1,j))/2;
                condym = (cond(i,j) + cond(i,j-1))/2;

                G(n,n) = -(condxm+condxp+condym);
                G(n,nxm) = condxm;
                G(n,nxp) = condxp;
                G(n,nym) = condym;
            else
                B(n,1) = 0;
                condxm = (cond(i,j) + cond(i-1,j))/2;
                condxp = (cond(i,j) + cond(i+1,j))/2;
                condyp = (cond(i,j) + cond(i,j+1))/2;
                condym = (cond(i,j) + cond(i,j-1))/2;

                G(n,n) = -(condxm+condxp+condyp+condym);
                G(n,nxm) = condxm;
                G(n,nxp) = condxp;
                G(n,nym) = condym;
                G(n,nyp) = condyp;

            end
        end  
    end

        V = G\B;
        for i = 1:nx
            for j = 1:ny
            n = j+(i-1)*ny;
            map(i,j) = V(n,1);
            end
        end
   
    [Ex,Ey] = gradient(map);
    jx = cond.*(-Ex);
    jy = cond.*(-Ey);
    CurrDen(numitr) = mean(mean((((jx.^2)+(jy.^2)).^0.5)));
end

figure(9)
plot(1:25,CurrDen)
title('Current Density of Region with varying bottleneck Length')
xlabel('Bottleneck factor, x2=25 + factor, x1=25 - factor')
ylabel('Current Density')
grid on

for numitr = 1:50
 
    G = sparse(ny*nx,ny*nx); 
    B = zeros(ny*nx,1);
    
    cond=1.*ones(nx,ny);
    for i = 1:nx
        for j = 1:ny
            if(((i>=x1)&&(i<=x2)&&(j<=y1))||((i>=x1)&&(i<=x2)&&(j>=y2)))
                cond(i,j) = numitr*0.01;
            end
        end
    end

    for i=1:nx
        for j=1:ny
            
            n = j + (i-1)*ny;
            nxm = (i-2)*ny + j;
            nxp = i*ny + j;
            nym = (i-1)*ny + j-1;
            nyp = (i-1)*ny + j+1;

            if i==1
                B(n,1)=1;
                G(n,n)=1;
            elseif i==nx
                B(n,1)=0;
                G(n,n)=1;
            elseif j==1
                B(n,1)=0;

                condxm = (cond(i,j) + cond(i-1,j))/2;
                condxp = (cond(i,j) + cond(i+1,j))/2;
                condyp = (cond(i,j) + cond(i,j+1))/2;

                G(n,n) = -(condxm+condxp+condyp);
                G(n,nxm) = condxm;
                G(n,nxp) = condxp;
                G(n,nyp) = condyp;

            elseif j==ny
                B(n,1)=0;

                condxm = (cond(i,j) + cond(i-1,j))/2;
                condxp = (cond(i,j) + cond(i+1,j))/2;
                condym = (cond(i,j) + cond(i,j-1))/2;

                G(n,n) = -(condxm+condxp+condym);
                G(n,nxm) = condxm;
                G(n,nxp) = condxp;
                G(n,nym) = condym;
            else
                B(n,1) = 0;
                condxm = (cond(i,j) + cond(i-1,j))/2;
                condxp = (cond(i,j) + cond(i+1,j))/2;
                condyp = (cond(i,j) + cond(i,j+1))/2;
                condym = (cond(i,j) + cond(i,j-1))/2;

                G(n,n) = -(condxm+condxp+condyp+condym);
                G(n,nxm) = condxm;
                G(n,nxp) = condxp;
                G(n,nym) = condym;
                G(n,nyp) = condyp;

            end
        end  
    end

        V = G\B;
        for i = 1:nx
            for j = 1:ny
            n = j+(i-1)*ny;
            map(i,j) = V(n,1);
            end
        end
   
    [Ex,Ey] = gradient(map);
    jx = cond.*(-Ex);
    jy = cond.*(-Ey);
    CurrDen(numitr) = mean(mean((((jx.^2)+(jy.^2)).^0.5)));
end

figure(11)
plot(1:50,CurrDen)
title('Current Density of Region with varying Conductance')
xlabel('Conductance factor, Conductance=factor*0.01')
ylabel('Current Density')
grid on