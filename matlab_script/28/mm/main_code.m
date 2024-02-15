clear all; clc; close all

load('kc_membrane_remaining.mat')

B0 = [14, 850];

[B,Rsdnrm,Rsd,ExFlg,OptmInfo,Lmda,Jmat] = lsqcurvefit(@michaelismenten,B0,kc_day,kc_membrane_remaining);

mofit = michaelismenten(B,kc_day);

figure;
plot(kc_day,kc_membrane_remaining,'bo', 'LineWidth', 2)
hold on
plot(kc_day,mofit,'r-','LineWidth', 2)
xlabel('Time (days)')
ylabel('Mass of Membrane Remaining (mg)')
legend('Experimental (28°C)','Michaelis Menten (28°C)')

row_dat=size(kc_membrane_remaining);
rmse_mm=sqrt(sum((kc_membrane_remaining-mofit).^2)./row_dat(1));
nrmse_mm=rmse_mm/(kc_membrane_remaining(1,1)-kc_membrane_remaining(29,1));

fprintf('Root Mean Squared Error (RMSE): %d  \n',rmse_mm)
fprintf('Normalized Root Mean Squared Error (RMSE): %d',nrmse_mm)
