# Nonlinear Tire Model

This file lists the known limitations of the tire model developed in
this project.

## Constant Friction

- The model does not include slip ratio. It assumes force is
  available instantly, up to the maximum, with no dependence on how
  much the tire is actually slipping.
- The model assumes force scales with load, which is not
  accurate for real tires (see load sensitivity).

## Linear Tire Model

- The model is only valid up to kappa_sat = 0.10. It does not describe
  what happens to tire force beyond this point.
- The transition at kappa_sat is a cutoff, which is not
  realistic. Real tires are expected to transition more smoothly.

## Nonlinear Tire Model

- E = 0 is a simplification. Real tires are expected to have an E value that
  is not equal to zero, which affects the shape of the curve, specifically past
  the peak.
- C = 1.65 is taken from the first published implementation of the Magic Formula
  (Bakker et al., 1986), which set C as a constant for longitudinal tire force.
- B comes out identical for the front and rear axles. This is a result
  of how B was calculated, and it does not depend on D.
- The model only describes longitudinal force. It does not include
  cornering (lateral) force and combined slip (braking and cornering
  happening at the same time).

## Validation Limitations

- No measured tire test data exists for this vehicle model. The validation
  is a comparison to a published reference set for a generic tire.
- The reference set used (dry tarmac, generic) may not represent
  racing tire behaviour specifically.

## Load Sensitivity

- epsilon = 0.8 is a value taken from the middle of the range, such as 0.7
- to 0.9. This range of values is from the "Load-Sensitive Tire–Road Friction
  Modeling and Dynamic Stability Analysis of Multi-Axle Trucks" article by Sung-Sic Yoo,
  Pyung-An Kim, and Heung-Shik Lee. The value is also backed up by the book "Race Car
  Vehicle Dynamics" by William F. Milliken Jr.
- The constant k was calculated using the front axle as the reference
  point. Using the rear axle instead would have produced a different
  k value and slightly different results, even though the general trend,
  such as less force than the linear model predicts, would
  stay the same.

## Unified Model

- The slip ratio at which peak force occurs (kappa = 0.2317) does not
  change with load in the model. This is not realistic, since
  real tires are generally expected to show some change in this value
  as load changes. To fix this, it would require B or E to depend on load
  as well.
- This model is longitudinal-only. Combined slip (see nonlinear tire model
  limitations) has not been added.

## Overall

The main limitation of the project is that none of the parameters
used (kappa_sat, C, epsilon) were measured from real tire test data.
All of them are either derived from earlier stages of this same model
or taken from academic articles.
