% model equation to generate y values for experimental data

t_lag = time_lag;

tspan = linspace(0,t_end,1000)';

k_aq = prm(1); 
k_hr = prm(2); 
k_hm = prm(3); 
C_aq0 = prm(4);
C_r0 = prm(5);
C_m0 = prm(6);

frac1 = k_aq/(k_aq - k_hr); % k_aq/(k_aq - k_hr)
frac2 = (k_hr)/(k_aq - k_hr); % k_hr/(k_aq - k_hr)
frac3 = k_aq/(k_aq - k_hm); % k_aq/(k_aq - k_hm)
frac4 = (k_hm)/(k_aq - k_hm); % k_hm/(k_aq - k_hm)

for i = 1:length(tspan)
    if tspan(i) >= t_lag
        CT_sim(i) = C_aq0.*(1 - exp(-k_aq.*(tspan(i)-t_lag))) +...
            C_r0.*(1 - frac1.*exp(-k_hr.*(tspan(i)-t_lag)) + frac2.*exp(-k_aq*(tspan(i)-t_lag)))+...
            C_m0.*(1 - frac3.*exp(-k_hm.*(tspan(i)-t_lag)) + frac4.*exp(-k_aq.*(tspan(i)-t_lag)));
    elseif tspan(i) < t_lag
        CT_sim(i) = 0;
    end
end
CT_sim = CT_sim';
