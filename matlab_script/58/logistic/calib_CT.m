% model equation to generate y values for experimental data

tspan = linspace(0,t_end,1000)';

p = prm(1); 
k = prm(2); 


for i = 1:length(tspan)
    CT_sim(i) = p/(1+exp(-k*tspan(i)));
    
end
CT_sim = CT_sim';





