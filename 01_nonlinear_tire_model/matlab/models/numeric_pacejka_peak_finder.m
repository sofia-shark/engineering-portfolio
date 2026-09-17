%% Numeric Pacejka peak-finder (for E != 0 cases)
% Finds the slip ratio at which the full Magic Formula peaks,
% since the closed-form shortcut only works when E = 0.

B_ref = 10; C_ref = 1.9; D_ref = 1; E_ref = 0.97;   % reference (dry tarmac)

pacejka = @(k) D_ref .* sin(C_ref .* atan(B_ref.*k - E_ref.*(B_ref.*k - atan(B_ref.*k))));

k_sweep = linspace(0, 0.5, 1000);
Fx_sweep = pacejka(k_sweep);

[Fx_peak, idx] = max(Fx_sweep);
kappa_peak = k_sweep(idx);

fprintf('Reference curve peaks at kappa = %.4f, Fx = %.4f\n', kappa_peak, Fx_peak);
