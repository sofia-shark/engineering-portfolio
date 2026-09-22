%% Test and demonstrate the unified tire model (Nonlinear Tire Model + Load Sensitivity merged)

clear; clc;

run('../vehicle/reference_vehicle_parameters.m');

N_front = (m * g * Wf) / 2;
N_rear  = (m * g * Wr) / 2;

Fx_front_max_Cf = mu * N_front;
kappa_sat = 0.10;
C_shape = 1.65;
B_val = 1 / (C_shape * kappa_sat);        % constant, derived once
k_val = Fx_front_max_Cf / (N_front ^ 0.8);   % same calibration as load sensitivity
epsilon_val = 0.8;

fprintf('B = %.4f (should match nonlinear tire model: 6.0606)\n', B_val);
fprintf('k = %.4f (should match load sensitivity: 3.988)\n', k_val);

%% Regression check: does this reproduce nonlinear tire model's original numbers?
kappa_test = linspace(0, 0.4, 200);

Fx_front_check = unified_tire_model(N_front, kappa_test, k_val, epsilon_val, B_val, C_shape);
Fx_rear_check  = unified_tire_model(N_rear,  kappa_test, k_val, epsilon_val, B_val, C_shape);

fprintf('\nPeak front force (unified): %.1f N (nonlinear tire model front D was %.1f N)\n', max(Fx_front_check), Fx_front_max_Cf);

%% New capability: full load sweep, showing the whole curve family
N_range = [400, N_front, N_rear, 1000];   % several representative loads
colors = {'g', 'b', 'r', 'm'};

figure;
hold on;
for i = 1:length(N_range)
    Fx_curve = unified_tire_model(N_range(i), kappa_test, k_val, epsilon_val, B_val, C_shape);
    plot(kappa_test, Fx_curve, colors{i}, 'LineWidth', 1.5, 'DisplayName', sprintf('N = %.0f N', N_range(i)));
end

xlabel('Slip ratio, \kappa [-]');
ylabel('Longitudinal force, F_x [N]');
title('Unified Tire Model: Force Curves Across a Range of Loads');
legend('Location', 'southeast');
grid on;
hold off;

% Command Window results
% B = 6.0606 (should match nonlinear tire model: 6.0606)
% k = 5.1550 (should match load sensitivity: 3.988)
% Peak front force (unified): 947.6 N (nonlinear tire model front D was 947.6 N)
% To look at the graph, go here 01_nonlinear_tire_model/figures/unifiedtiremodel.png
