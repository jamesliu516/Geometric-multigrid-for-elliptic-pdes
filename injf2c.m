function uc = injf2c( u )

% Transfers a fine grid to a coarse grid by injection

[nx,ny] = size( u );
uc = u(1:2:nx,1:2:ny);
