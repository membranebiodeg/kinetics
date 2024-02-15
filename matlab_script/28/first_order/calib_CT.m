% model equation to generate y values for experimental data

tspan = linspace(0,t_end,1000)';

k1 = prm(1); 


for i = 1:length(tspan)
    CT_sim(i) = 1000*exp(-k1*tspan(i));
end
CT_sim = CT_sim';



