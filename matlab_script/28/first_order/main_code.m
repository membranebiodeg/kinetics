clear all; clc; close all

load('kc_membrane_remaining') 

% number of parameters to be calibrated
nvars = 1;

% user defined variables
t_end = 180; % end time

% initial guess
varb(1) = 0.0097; % k1


% lower and upper bounds for each parameter
lb = 0;
ub = 1;


%% run Genetic Algorithm (GA)
tic;
init1 = varb'; %initial guess

% linear constraint
Aeq = [];
beq = [];

optionsga = gaoptimset('Display','iter','PopulationSize',10,'Generations',1000,'StallGenLimit',30,'InitialPopulation',init1','PlotFcns',@gaplotbestf);

[z,fval,exitFlag,Output,Population,Score] = ga(@(z) objf_calib(z,varb,kc_day,kc_membrane_remaining,t_end),nvars,[],[],Aeq,beq,lb,ub,[],optionsga);

time_calib = '\nTotal time elapsed for GA calibration is %.1f seconds.\n';

fprintf(time_calib,toc);

%% run model with calibrated parameters
k1 = z(1)

prm = z;

calib_CT;

SSE = fval;
CT_new = interp1(kc_day,kc_membrane_remaining,tspan,'pchip');
RMSE = sqrt(sum((CT_sim-CT_new).^2)./1000);
nrmse=RMSE/(kc_membrane_remaining(1,1)-kc_membrane_remaining(29,1));

plot(kc_day,kc_membrane_remaining,'bo','LineWidth',2)
hold on
plot(tspan,CT_sim,'r-','LineWidth',2)
xlabel('Time (days)')
ylabel('Mass of membrane remaining (mg)')
legend('Experimental (28°C)','First Order (28°C)')

fprintf('Sum of squares regression (SSE): %d\n',fval)
fprintf('Root Mean Squared Error (RMSE): %d\n',RMSE)
fprintf('Normalized Root Mean Squared Error (RMSE): %d',nrmse)
