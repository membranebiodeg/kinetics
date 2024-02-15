function S = michaelismenten(B, t)
% MONODKINETICS1 codes the system of differential equations describing one
%   version of Monod kinetics:
%       dS/dt = -(mmax * M)/(Km + M);
%   with:
%       Variables:  x = M
%       Parameters: mmax = B(1),  Km = B(2)
m0 = 1000;

[T,Sv] = ode45(@DifEq, t, m0);
      function dS = DifEq(t, x)
         dS = -(B(1) .* x) ./ (B(2) + x);
      end
  S = Sv;
end
