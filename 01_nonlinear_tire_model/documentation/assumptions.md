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


# Nonlinear Tire Model

This file discusses the main assumptions made at each stage of the tire
model. Assumptions are listed in the order they were introduced.

## Constant Friction Model

- The coefficient of friction (mu = 1.4) is assumed to be constant. It
  does not depend on slip, slip ratio, or vertical load.
- Only static wheel loads are used. Load transfer during braking or
  cornering is not included at this level.
- The value mu = 1.4 was chosen as a reasonable value for a racing
  slick tire, based on "Vehicle Dynamics on an Electric Formula SAE Racecar"
  article by Audrey Gaither. It is not measured for this vehicle's
  actual tires, since there are no actual tires. This is a simulation-only project.

## Linear Tire Model

- The tire force is assumed to increase in linear progression with slip ratio,
  kappa, up to an assumed value of kappa_sat = 0.10.
- kappa_sat = 0.10 is an assumed value for where the tire is assumed
  to stop behaving in a linear predictive progression. This value was not measured
  and was chosen based on figures seen in vehicle dynamics references for where
  linear tire behaviour starts to break down.
- The slip stiffness, Cx, is a dependent assumption. It is
  calculated from the constant friction result, so that the linear model
  reaches the same maximum force as constant friction at kappa_sat.
- Cx is calculated separately for the front and rear axles, since the
  static loads are different for each axle.

## Nonlinear Tire Model (Pacejka Magic Formula)

- The curvature factor, E, is set to 0. This is a simplification. A
  full Pacejka fit would calculate E from test data, but no
  test data is available for this project.
- The shape factor, C, is set to 1.65. It was taken from the first published
  implementation of the Magic Formula (Bakker et al., 1986), which set C as a constant
  for longitudinal tire force. It is not specific to this vehicle's tires.
- The peak factor, D, is taken directly from the constant friction result for
  each axle.
- The stiffness factor, B, is calculated so that the Pacejka curve has
  the same initial slope as the linear tire model. Because of calculations,
  B does not depend on D, which means B comes out the same for the front
  and rear axles even though their loads are different.

## Validation

- No tire test data was used for this vehicle, so validation was
  done by comparing model parameters to a published reference set of
  Magic Formula coefficients (MathWorks documentation, dry tarmac
  surface: B=10, C=1.9, D=1, E=0.97).
- This reference set is for a generic tire on a generic dry surface.

## Load Sensitivity

- Tire force is assumed to scale with vertical load according to a
  power law, Fx_max = k * N^epsilon, instead of scaling directly with
  load as in earlier levels.
- epsilon = 0.8 was the value taken from the middle of the range, such as 0.7 to 0.9.
  This range of values is from the "Load-Sensitive Tire–Road Friction Modeling and Dynamic
  Stability Analysis of Multi-Axle Trucks" article by Sung-Sic Yoo, Pyung-An Kim, and
  Heung-Shik Lee. This value is also backed up by the book "Race Car Vehicle Dynamics" by
  William F. Milliken Jr.
- The constant k is calculated so that this model matches the constant friction
  result at the front axle.
- k = 5.1550. An earlier hand-calculated value of k = 3.988 was incorrect and corrected later
  (see methodology.md for more detail on this).

## Unified Model (Nonlinear Tire Model + Load Sensitivity Merged)

- B and C are assumed to stay constant regardless of load. This
  follows from how B was derived in the nonlinear tire model (it does not depend
  on D).
- Because B and E do not depend on load in this model, the slip ratio
  at which peak force occurs (kappa = 0.2317) is the same at every
  load.
