function u = gsrelax( f, u, h )
[nx,ny] = size( f );
h2 = h*h;
r2 = 0;
for j=2:ny-1
  for i=2:nx-1
    u(i,j) = (u(i-1,j) + u(i+1,j) + u(i,j-1) + u(i,j+1) + h2*f(i,j))/4;
  end
end
