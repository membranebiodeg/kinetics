clear all; clc; close all

load('kc58_membrane_co2')

% number of parameters to be calibrated
nvars = 2;

% user defined variables
t_end = 130; % end time

% initial guess
varb(1) = 331.2825; % theoretical CO2 production
varb(2) = 0.056; % time rate constant of the process

% lower and upper bounds for each parameter
lb(1) = 0;
ub(1) = 500;

lb(2) = 0;
ub(2) = 30;


%% run GA
tic;
init1 = varb'; %initial guess


% linear constraint
Aeq = [];
beq = [];

optionsga = gaoptimset('Display','iter','PopulationSize',10,'Generations',1000,'StallGenLimit',30,'InitialPopulation',init1','PlotFcns',@gaplotbestf);

[z,fval,exitFlag,Output,Population,Score] = ga(@(z) objf_calib(z,varb,kc58_day,kc58_membrane_co2,t_end),nvars,[],[],Aeq,beq,lb,ub,[],optionsga);

% although @(z) is usually used to define an anonymous function, in the
% context of GA, z will be treated as a variable determined by GA
% optimization

time_calib = '\nTotal time elapsed for GA calibration is %.1f seconds.\n';

fprintf(time_calib,toc);

%% run model with calibrated parameters

p = z(1)
k = z(2)

prm = z;

calib_CT;

SSE = fval;
CT_new = interp1(kc58_day,kc58_membrane_co2,tspan,'pchip');
RMSE = sqrt(sum((CT_sim-CT_new).^2)./1000);
nrmse=RMSE/(kc58_membrane_co2(23,1)-kc58_membrane_co2(1,1));

plot(kc58_day,kc58_membrane_co2,'bo','LineWidth',2)
hold on
plot(tspan,CT_sim,'r-','LineWidth',2)
xlabel('Time (days)')
ylabel('Mass of CO2 evolved (mg)')
legend('Experimental (58°C)','Logistic (58°C)')
legend('Location','northwest')

fprintf('Sum of squares regression (SSE): %d\n',fval)
fprintf('Root Mean Squared Error (RMSE): %d\n',RMSE)
fprintf('Normalized Root Mean Squared Error (RMSE): %d',nrmse)
