% model equation to generate y values for experimental data

t_lag = time_lag;

tspan = linspace(0,t_end,1000)';

ko = prm(1); 
k1 = prm(2); 
k2 = prm(3); 


for i = 1:length(tspan)
    CT_sim(i) = 1000*(1-exp((-k1*tspan(i))-(k2*tspan(i)^2)/2))+ko*tspan(i);
end
CT_sim = CT_sim';

% CT_sim(i) = 1000*(1-exp((-k1*tspan)-(k2*tspan.^2)./2))+ko*tspan;



