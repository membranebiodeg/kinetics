function ff = objf_calib(zguess,varb,t_exp,CT_exp,time_lag,t_end)

% setting parameter to be calibrated
prm = zguess;

% run main code
calib_CT;

% interpolating experimental data to simulation data points
CT_new = interp1(t_exp,CT_exp,tspan,'pchip');

% final objective function
fff = sum((CT_new-CT_sim).^2);

ff = fff;

