%% Project 1: Linear Tire Model
% Author: Sofia Shark
% Date: 17.09.2026
% Purpose: Introduce slip-dependent tire force using a linear model.
% Slip stiffness (Cx) is derived from the constant friction max-force 
% result, anchored at an assumed saturation slip ratio kappa_sat.

clear; clc;

%% Load reference vehicle parameters
run('../vehicle/reference_vehicle_parameters.m');

%% Recompute constant friction static loads and max forces
N_front = (m * g * Wf) / 2;   % [N]
N_rear  = (m * g * Wr) / 2;   % [N]

Fx_front_max = mu * N_front;  % Constant friction max force, front [N]
Fx_rear_max  = mu * N_rear;   % Constant friction max force, rear [N]

%% Assumption: slip ratio at which linear region ends
kappa_sat = 0.10;   % documented assumption, see assumptions.md in GitHub

%% Derive slip stiffness per axle from constant friction anchor point
Cx_front = Fx_front_max / kappa_sat;   % [N]
Cx_rear  = Fx_rear_max  / kappa_sat;   % [N]

fprintf('Derived front slip stiffness Cx_front: %.1f N\n', Cx_front);
fprintf('Derived rear slip stiffness Cx_rear:   %.1f N\n', Cx_rear);

%% Sweep slip ratio through the linear region
kappa = linspace(0, kappa_sat, 100);

Fx_front_linear = Cx_front .* kappa;   % [N]
Fx_rear_linear  = Cx_rear  .* kappa;   % [N]

%% Plot: Linear model vs constant-friction reference
figure;
hold on;
plot(kappa, Fx_front_linear, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Front - Linear Model');
plot(kappa, Fx_rear_linear, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Rear - Linear Model');
yline(Fx_front_max, 'b--', 'DisplayName', 'Front - Constant Friction (max)');
yline(Fx_rear_max, 'r--', 'DisplayName', 'Rear - Constant Friction (max)');

xlabel('Slip ratio, \kappa');
ylabel('Longitudinal force, F_x [N]');
title('Linear Tire Model vs Constant Friction');
legend('Location', 'southeast');
grid on;
hold off;
