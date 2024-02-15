clear all; clc; close all

load('kc58_membrane_remaining.mat')

B0 = [2000, 9000];

[B,Rsdnrm,Rsd,ExFlg,OptmInfo,Lmda,Jmat] = lsqcurvefit(@michaelismenten,B0,kc58_day,kc58_membrane_remaining);

mofit = michaelismenten(B,kc58_day);

figure;
plot(kc58_day,kc58_membrane_remaining,'bo', 'LineWidth', 2)
hold on
plot(kc58_day,mofit,'r-','LineWidth', 2)
xlabel('Time (days)')
ylabel('Mass of Membrane Remaining (mg)')
legend('Experimental (58°C)','Michaelis Menten (58°C)')

row_dat=size(kc58_membrane_remaining);
rmse_mm=sqrt(sum((kc58_membrane_remaining-mofit).^2)./row_dat(1));
nrmse_mm=rmse_mm/(kc58_membrane_remaining(1,1)-kc58_membrane_remaining(23,1));

fprintf('Root Mean Squared Error (RMSE): %d  \n',rmse_mm)
fprintf('Normalized Root Mean Squared Error (RMSE): %d',nrmse_mm)
