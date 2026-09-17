%% Project 1: Nonlinear Tire Model (Pacejka Magic Formula)
% Author: Sofia Shark
% Date: 17.09.2026
% Purpose: Introduce full nonlinear rise-peak-falloff tire behavior
% using a simplified Pacejka Magic Formula, where E = 0. Parameters D and B
% are derived from constant friction and linear tire model results. 
% C is taken from published literature as a longitudinal shape factor.

clear; clc;

%% Load reference vehicle parameters
run('../vehicle/reference_vehicle_parameters.m');

%% Recompute constant friction static loads and max forces
N_front = (m * g * Wf) / 2;
N_rear  = (m * g * Wr) / 2;

Fx_front_max = mu * N_front;   % = D_front [N]
Fx_rear_max  = mu * N_rear;    % = D_rear [N]

%% Recompute linear tire model slip stiffness
kappa_sat = 0.10;

Cx_front = Fx_front_max / kappa_sat;
Cx_rear  = Fx_rear_max  / kappa_sat;

%% Pacejka parameters
D_front = Fx_front_max;   % [N] peak factor
D_rear  = Fx_rear_max;    % [N]

C_shape = 1.65;   % shape factor for Fx
E_curv  = 0;      % simplifying assumption, see assumptions.md

B_front = Cx_front / (C_shape * D_front);
B_rear  = Cx_rear  / (C_shape * D_rear);

fprintf('B_front = %.4f, B_rear = %.4f (expected to be equal)\n', B_front, B_rear);
fprintf('D_front = %.1f N, D_rear = %.1f N\n', D_front, D_rear);

%% Sweep slip ratio through and past the linear region
kappa = linspace(0, 0.4, 200);

Fx_front_pacejka = D_front .* sin(C_shape .* atan(B_front .* kappa));
Fx_rear_pacejka  = D_rear  .* sin(C_shape .* atan(B_rear  .* kappa));

%% Also compute linear tire model for comparison (valid only to kappa_sat)
kappa_lin = linspace(0, kappa_sat, 50);
Fx_front_linear = Cx_front .* kappa_lin;
Fx_rear_linear  = Cx_rear  .* kappa_lin;

%% Plot: Nonlinear vs Linear vs Constant Friction
figure;
hold on;
plot(kappa, Fx_front_pacejka, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Front - Nonlinear');
plot(kappa, Fx_rear_pacejka, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Rear - Nonlinear');
plot(kappa_lin, Fx_front_linear, 'b:', 'LineWidth', 1.2, 'DisplayName', 'Front - Linear');
plot(kappa_lin, Fx_rear_linear, 'r:', 'LineWidth', 1.2, 'DisplayName', 'Rear - Linear');
yline(Fx_front_max, 'b--', 'DisplayName', 'Front - Constant Friction (max)');
yline(Fx_rear_max, 'r--', 'DisplayName', 'Rear - Constant Friction (max)');

xlabel('Slip ratio, \kappa');
ylabel('Longitudinal force, F_x');
title('Nonlinear (Pacejka) vs Linear vs Constant Friction');
legend('Location', 'southeast');
grid on;
hold off;
