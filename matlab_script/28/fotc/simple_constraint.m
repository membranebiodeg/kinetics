function [c,ceq] = simple_constraint(z)
% https://www.mathworks.com/help/gads/constrained-minimization-using-ga.html#gaconstrained-3


% k1 > k2
% k2/k1 < 1
% k2/k1-1 < 0

c = [z(3)/z(2) - 1];

ceq = [];