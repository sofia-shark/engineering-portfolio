%% Project 1: Load Sensitivity
% Author: Sofia Shark
% Date: 18.09.2026
% Purpose: Replace the linear force-load assumption (F = mu*N) used in
% other models within this project with a sub-linear power-law model, 
% reflecting the well-documented tendency of real tires to produce 
% diminishing grip per unit of added vertical load.

clear; clc;

%% Load reference vehicle parameters
run('../vehicle/reference_vehicle_parameters.m');

%% Recompute constant friction static loads and max forces
N_front = (m * g * Wf) / 2;
N_rear  = (m * g * Wr) / 2;

Fx_front_max_Cf = mu * N_front;   % constant friction result [N]
Fx_rear_max_Cf  = mu * N_rear;    % constant friction result [N]

%% Load sensitivity exponent
epsilon = 0.8;   % documented assumption, see assumptions.md

%% Calibrate k so the power-law model matches constant friction at the front load
k = Fx_front_max_Cf / (N_front ^ epsilon);

fprintf('Calibration constant k = %.4f\n', k);

%% Compare constant friction (linear) vs load sensitivity (power law) at both axles
Fx_front_max_Ls = k * N_front ^ epsilon;
Fx_rear_max_Ls  = k * N_rear  ^ epsilon;

fprintf('\n--- Front axle ---\n');
fprintf('Constant friction (linear):    %.1f N\n', Fx_front_max_Cf);
fprintf('Load sensitivity (power-law): %.1f N (should match, by calibration)\n', Fx_front_max_Ls);

fprintf('\n--- Rear axle ---\n');
fprintf('Constant friction (linear):    %.1f N\n', Fx_rear_max_Cf);
fprintf('Load sensitivity (power-law): %.1f N\n', Fx_rear_max_Ls);

pct_diff_rear = (Fx_rear_max_Ls - Fx_rear_max_Cf) / Fx_rear_max_Cf * 100;
fprintf('\nRear axle difference (Load Sensitivity vs Constant Friction): %.2f %%\n', pct_diff_rear);

%% Plot: force vs load, linear vs power-law, across a load sweep
N_sweep = linspace(200, 1200, 200);   % [N], covers below/above both corners

Fx_linear    = mu .* N_sweep;
Fx_powerlaw  = k .* N_sweep .^ epsilon;

figure;
hold on;
plot(N_sweep, Fx_linear, 'k--', 'LineWidth', 1.2, 'DisplayName', 'Linear (constant friction & linear model & nonlinear model assumption)');
plot(N_sweep, Fx_powerlaw, 'm-', 'LineWidth', 1.5, 'DisplayName', 'Power-law (load sensitivity)');
plot(N_front, Fx_front_max_Cf, 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b', 'DisplayName', 'Front axle (calibration point)');
plot(N_rear, Fx_rear_max_Cf, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'DisplayName', 'Rear axle');

xlabel('Vertical load, N [N]');
ylabel('Max longitudinal force, F_x [N]');
title('Load Sensitivity: Linear vs Power-Law Model');
legend('Location', 'northwest');
grid on;
hold off;

% Command Window results:
% Calibration constant k = 5.1550
% --- Front axle ---
% Constant friction (linear):    947.6 N
% Load sensitivity (power-law): 947.6 N (should match, by calibration)
% --- Rear axle ---
% Constant friction (linear):    1112.5 N
% Load sensitivity (power-law): 1077.3 N
% Rear axle difference (Load Sensitivity vs Constant Friction): -3.16 %
% To look at the graph, go here 01_nonlinear_tire_model/figures/loadsensitivity.png
