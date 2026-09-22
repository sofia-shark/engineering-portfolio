%% Project 1 Non-linear Tire Model: Constant Friction Tire Model
% Author: Sofia Shark
% Date: 16.09.2026
% Purpose: Establish naive baseline tire force model using static
% loads and a constant friction coefficient.

clear; clc;

%% Load reference vehicle parameters
run('../vehicle/reference_vehicle_parameters.m');

%% Static corner loads
N_front = (m * g * Wf) / 2;   % load per front tire [N]
N_rear  = (m * g * Wr) / 2;   % load per rear tire [N]

%% Calculations check
total_check = 2*N_front + 2*N_rear;
fprintf('Total weight: %.2f N\n', m*g);

%% Max longitudinal force per tire
Fx_front_max = mu * N_front;   % [N]
Fx_rear_max  = mu * N_rear;    % [N]

fprintf('Front tire static load: %.1f N\n', N_front);
fprintf('Rear tire static load:  %.1f N\n', N_rear);
fprintf('Max force per front tire: %.1f N\n', Fx_front_max);
fprintf('Max force per rear tire:  %.1f N\n', Fx_rear_max);

%% Whole car max theoretical deceleration (all 4 tires)
Fx_total_max = 2*Fx_front_max + 2*Fx_rear_max;
a_max   = Fx_total_max / m;   % [m/s^2]
a_max_g = a_max / g;          % [g]

fprintf('Theoretical max deceleration: %.2f m/s^2 (%.2f g)\n', a_max, a_max_g);

% Command window results:
% Total weight: 2943.00 N
% Front tire static load: 676.9 N
% Rear tire static load:  794.6 N
% Max force per front tire: 947.6 N
% Max force per rear tire:  1112.5 N
% Theoretical max deceleration: 13.73 m/s^2 (1.40 g)
