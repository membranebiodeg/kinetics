% model equation to generate y values for experimental data


%kc_day = readmatrix('KC28.xlsx','Sheet','Sheet1','Range','A2:A30');
%tspan = kc_day;

tspan = linspace(0,t_end,1000)';

p = prm(1); %input from objf_calib input?
rm = prm(2); 
k = prm(3); 


for i = 1:length(tspan)
    CT_sim(i) = p*exp(-exp(((exp(1)*rm*(k-tspan(i)))/p)+1));
    
end
CT_sim = CT_sim';





