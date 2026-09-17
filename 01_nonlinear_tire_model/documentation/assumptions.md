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
- **Shape factor C = 1.65** is taken from "Tire and Vehicle Dynamics" book by
  Hans. B. Pacejka as a value for longitudinal force. It is not derived
  from the vehicle's own data.
- **Peak factor D** and **stiffness factor B** are derived from constant friction
  model and linear tire model results respectively.
