% model equation to generate y values for experimental data


%kc_day = readmatrix('KC28.xlsx','Sheet','Sheet1','Range','A2:A30');
%tspan = kc_day;

tspan = linspace(0,t_end,1000)';

kr = prm(1); 
k1 = prm(2); 
k2 = prm(3); 


for i = 1:length(tspan)
    CT_sim(i) = 1000*exp(-(k1+kr)*tspan(i))+1000*(kr/(k1+kr-k2))*(exp(-k2*tspan(i))-exp(-(k1+kr)*tspan(i)));
end
CT_sim = CT_sim';





