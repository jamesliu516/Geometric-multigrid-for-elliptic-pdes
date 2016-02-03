clear all;
close all;
format long;
clc;
a=0;
b=1;
N=100;
h=(b-a)/N;
h1=h*h;
x=a:h:b;
omega=1.952;
uexact = sin(pi*x);
f = -pi*pi*sin(pi*x);
u=zeros(N+1,1);
u1=zeros(N+1,1);
for j=1:N+1
    u1(j)= sin(50*pi*x(j));
    u(j) = sin(50*pi*x(j));
end
u(1)=0;
u1(1)=0;
u(N+1)=0;
u1(N+1)=0;
k=0;
error=100;
tol=1e-10;
while error>tol
    u=u1;
    for j=2:N
        %u1(j) = (1-omega)*u(j) + (omega*(u1(j+1) + u1(j-1) - h1*f(j))/2);
        u1(j) = (u1(j+1) + u1(j-1) - h1*f(j))/2;
        %u1(j) = (u(j+1) + u(j-1) - h1*f(j))/2;
    end
    error = max(abs(u1-u));
    plot(x,abs(u1-uexact'))
    pause(0.5);
    k=k+1;
end
diff = max(abs(u1-uexact'))
% plot(x,uexact');
% hold on;
% plot(x,u1,'r');
