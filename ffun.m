function f = ffun( X, Y )
% FFUN  Forcing  f  of the Poisson problem

f = -(X.*X + Y.*Y).*exp(X.*Y);
