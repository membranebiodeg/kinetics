clear all; clc; close all

load('kc28_membrane_remaining')

% number of parameters to be calibrated
nvars = 3;

% user defined variables
t_end = 180; % end time

% initial guess
varb(1) = 0.999; % kr
varb(2) =  0.0097; % k1 
varb(3) = 0.0097 % k2 


% lower and upper bounds for each parameter
lb(1) = 0;
ub(1) = 1;

lb(2) = 1e-8;
ub(2) = 5;

lb(3) = 1e-8;
ub(3) = 5;


%% run GA
tic;
init1 = varb'; %initial guess

ConstraintFunc = @simple_constraint; % impose nonlinear constraint

% linear constraint
Aeq = [];
beq = [];

optionsga = gaoptimset('Display','iter','PopulationSize',10,'Generations',1000,'StallGenLimit',30,'InitialPopulation',init1','PlotFcns',@gaplotbestf);

[z,fval,exitFlag,Output,Population,Score] = ga(@(z) objf_calib(z,varb,kc_day,kc_membrane_remaining,t_end),nvars,[],[],Aeq,beq,lb,ub,ConstraintFunc,optionsga);

time_calib = '\nTotal time elapsed for GA calibration is %.1f seconds.\n';

fprintf(time_calib,toc);

%% run model with calibrated parameters
kr = z(1)
k1 = z(2)
k2 = z(3)

prm = z;

calib_CT;

SSE = fval;
CT_new = interp1(kc_day,kc_membrane_remaining,tspan,'pchip');
RMSE = sqrt(sum((CT_sim-CT_new).^2)./1000);
nrmse=RMSE/(kc_membrane_remaining(1,1)-kc_membrane_remaining(29,1));

plot(kc_day,kc_membrane_remaining,'bo','LineWidth',2)
hold on
plot(tspan,CT_sim,'r-','LineWidth',2)
ylim([0 1000])
xlabel('Time (days)')
ylabel('Mass of Membrane remaining (mg)')
legend('Experimental (28°C)','FOTC (28°C)')

fprintf('Sum of squares regression (SSE): %d\n',fval)
fprintf('Root Mean Squared Error (RMSE): %d',RMSE)
fprintf('Normalized Root Mean Squared Error (NRMSE): %d',nrmse)
