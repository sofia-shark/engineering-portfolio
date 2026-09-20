## Linear Tire Model

- **Slip stiffness (Cx)** is derived by anchoring the linear model to
  the constant friction max-force result, assuming the linear region
  extends to kappa_sat = 0.10.
- This specific value of **kappa_sat** is a cited rough estimate for
  where linear tire behaviour begins breaking down on a racing tire.
- **Cx** is calculated separately per axle (front/rear) since constant
  friction max force differs by axle due to static load distribution.

## Nonlinear Tire Model (Pacejka Magic Formula)

- **Curvature factor E** is set to 0 as a simplifying assumption. Full
  Pacejka fitting would derive E from real test data. E = 0 still
  produces rise-peak falloff behavior but does not precisely match
  any specific real tire's curve shape.
- **Shape factor C = 1.65** is taken from the book " Tire and Vehicle Dynamics " by
  Hans. B. Pacejka as a value for longitudinal force. It is not derived
  from the vehicle's own data.
- **Peak factor D** and **stiffness factor B** are derived from constant friction
  model and linear tire model results, respectively.

## Load Sensitivity

- **Load sensitivity** is modelled as Fx_max = k * N^epsilon, with
  epsilon = 0.8 for the exponent relating peak tire force to vertical load.
- **k** is calibrated so the power-law model exactly matches the constant friction
  (linear) result at the front axle's static load. If it were calibrated at
  the rear axle instead, it would shift all power-law predictions, since
  the two models only agree at whichever single point is chosen for calibration.
- The model does not attempt to represent why load sensitivity occurs
  (contact patch pressure distribution, rubber hysteresis). It is a
  curve-fit representation of the documented effect.

## Unified Tire Model (Nonlinear Tire Model + Load Sensitivity merge)

- B and C are treated as constant with respect to load. This is a
  direct mathematical consequence of how B was originally derived
  (B = 1/(C*kappa_sat), independent of D).
- Because B and E are independent of load in the model, the peak slip ratio
  (kappa ~ 0.2317) is the same at each load.
