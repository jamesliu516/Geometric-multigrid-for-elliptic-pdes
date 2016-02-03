function [u,k] = mgv( f, u, h, n1, n2, n3 ,k)

l = 1;
[nx(l),ny(l)] = size( f );
hval(l) = h;
eval(['f_' num2str(l) ' = f;']);
eval(['u_' num2str(l) ' = u;']);

% set up the coarse grids

while (mod(nx(l)-1,2)==0 & mod(ny(l)-1,2)==0 & nx(l)-1>2 & ny(l)-1>2 )
   l = l+1;
   nx(l) = (nx(l-1)-1)/2 + 1;
   ny(l) = (ny(l-1)-1)/2 + 1;
   hval(l) = 2*hval(l-1);
   eval(['f_' num2str(l) ' = zeros(nx(l),ny(l));']);
   eval(['u_' num2str(l) ' = zeros(nx(l),ny(l));']);
end
nl = l;

% downward branch of the V-cycle
for l=1:nl-1
   ul = eval(['u_' num2str(l)]);
   fl = eval(['f_' num2str(l)]);
   for isweep=1:n1
      ul = gsrelax( fl, ul, hval(l) );
      k=k+1;
   end
   eval(['u_' num2str(l) ' = ul;']);
   r = resid( fl, ul, hval(l) );
   eval(['f_' num2str(l+1) ' = injf2c( r );']);
   eval(['u_' num2str(l+1) ' = zeros(nx(l+1),ny(l+1));']);
end

% solve on the coarsest grid by many relaxation sweeps
l = nl;
ul = eval(['u_' num2str(l)]);
fl = eval(['f_' num2str(l)]);
for isweep=1:n3
   ul = gsrelax( fl, ul, hval(l) );
   k=k+1;
end
eval(['u_' num2str(l) ' = ul;']);

% upward branch of the V-cycle
for l=nl-1:-1:1
   uc = eval(['u_' num2str(l+1)]);
   ul = eval(['u_' num2str(l)]);
   ul = ul + ctof( uc );
   fl = eval(['f_' num2str(l)]);
   for isweep=1:n2
      ul = gsrelax( fl, ul, hval(l) );
      k=k+1;
   end
   eval(['u_' num2str(l) ' = ul;']);
end

% copy solution back to original grid
eval(['u = u_' num2str(1) ';']);
