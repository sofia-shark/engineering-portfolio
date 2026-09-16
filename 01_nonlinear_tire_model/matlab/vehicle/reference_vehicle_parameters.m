%% Reference Vehicle & Tire Parameters
% Project 1: Nonlinear Tire Model
% Purpose: Central, reusable definition of the reference vehicle.

%% Mass properties
m_dry    = 230;               % dry vehicle mass [kg]
m_driver = 70;                % driver mass [kg]
m        = m_dry + m_driver;  % total vehicle mass [kg]

%% Environment
g = 9.81;   % gravitational acceleration [m/s^2]

%% Weight distribution
Wf = 0.46;      % fraction of weight on front axle
Wr = 1 - Wf;    % fraction of weight on rear axle

%% Tire/friction assumption (Level 0 baseline)
mu = 1.4;   % constant coefficient of friction
