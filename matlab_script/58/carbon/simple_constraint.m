function [c,ceq] = simple_constraint(z)
% https://www.mathworks.com/help/gads/constrained-minimization-using-ga.html#gaconstrained-3

% k_aq > k_hr
% k_hr/k_aq < 1
% k_hr/k_aq - 1 < 0

% k_hr > k_hm
% k_hm/k_hr < 1
% k_hm/k_hr - 1 <0

c = [z(2)/z(1) - 1;
    z(3)/z(2) - 1];

ceq = [];