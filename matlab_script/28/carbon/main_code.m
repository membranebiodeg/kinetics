clear all; clc; close all

load('kc28_membrane_percent')

% number of parameters to be calibrated
nvars = 6;

% user defined variables
time_lag =28; % can be adjusted
t_end = 180; % end time

% initial guess
varb(1) = 0.0473; % k_aq
varb(2) = 0.0067; % k_hr 
varb(3) = 0.0000593; % k_hm 
varb(4) = 61.9433; % C_aq0
varb(5) = 24.8304; % C_r0
varb(6) = 13.227; % C_m0

% lower and upper bounds for each parameter
lb(1) = 1e-8;
ub(1) = 5;

lb(2) = 1e-8;
ub(2) = 5;

lb(3) = 1e-8;
ub(3) = 5;

lb(4) = 0.01;
ub(4) = 100;

lb(5) = 0.01;
ub(5) = 100;

lb(6) = 0.01;
ub(6) = 100;

%% run GA
tic;
init1 = varb'; %initial guess

ConstraintFunc = @simple_constraint; % impose nonlinear constraint

% linear constraint
% C_aq0 + C_r0 + C_m0 = 100
Aeq = [0 0 0 1 1 1];
beq = [100];

optionsga = gaoptimset('Display','iter','PopulationSize',10,'Generations',1000,'StallGenLimit',30,'InitialPopulation',init1','PlotFcns',@gaplotbestf);

[z,fval,exitFlag,Output,Population,Score] = ga(@(z) objf_calib(z,varb,kc_day,kc_membrane_percent,time_lag,t_end),nvars,[],[],Aeq,beq,lb,ub,ConstraintFunc,optionsga);

time_calib = '\nTotal time elapsed for GA calibration is %.1f seconds.\n';

fprintf(time_calib,toc);

%% run model with calibrated parameters
k_aq = z(1)
k_hr = z(2)
k_hm = z(3)
C_aq0 = z(4)
C_r0 = z(5)
C_m0 = z(6)
prm = z;

calib_CT;

SSE = fval;

plot(kc_day,kc_membrane_percent,'bo','LineWidth',2)
hold on
plot(tspan,CT_sim,'r-','LineWidth',2)
xlabel('Time (days)')
ylabel('CO2 evolved (%)')
legend('Experimental (28°C)','Carbon model (28°C)')
legend('Location','northwest')


CT_new = interp1(kc_day,kc_membrane_percent,tspan,'pchip');
RMSE = sqrt(sum((CT_sim-CT_new).^2)./1000);
nrmse=RMSE/(kc_membrane_percent(29,1)-kc_membrane_percent(1,1));

fprintf('Sum of squares regression (SSE): %d\n',fval)
fprintf('Root Mean Squared Error (RMSE): %d\n',RMSE)
fprintf('Normalized Root Mean Squared Error (NRMSE): %d',nrmse)


