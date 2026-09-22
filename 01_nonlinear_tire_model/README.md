# Nonlinear Tire Model

## Objective

The objective of this project is to develop a tire model that can
predict the longitudinal force produced by a tire under different
slip and load conditions. The model is built up in stages, starting
from a very simple assumption and adding complexity at each stage, in
order to understand what each added assumption actually contributes
to the prediction.

This model is necessary to build for the portfolio because later projects
(suspension, braking, aerodynamics, and eventually a full lap simulation) 
all require some way of estimating tire force. The model is derived and tested 
independently, rather than using an existing tire model without understanding how it works.

## Reference Vehicle Parameters

The following reference vehicle was used for all calculations in this project:

| Parameter | Value |
|---|---|
| Total mass | 300 kg (230 kg dry mass + 70 kg driver) |
| Front weight distribution | 46% |
| Rear weight distribution | 54% |
| Assumed coefficient of friction | 1.4 |

These values are assumed for a small formula-style vehicle and are
not measured from a real car. They are documented in
`vehicle/reference_vehicle_parameters.m` and used consistently
throughout the project.

## Model Development

### Constant Friction Model

File: `matlab/models/constant_friction.m`

This is the model that could be used: `Fx = mu * N`. It does
not include any dependence on slip ratio.

Using the reference vehicle, the model predicts a maximum theoretical
deceleration of 1.40 g. T value is equal to mu regardless of the vehicle's mass 
or weight distribution, since the mass terms cancel out when using this model. 
The project produced the static wheel loads (676.9 N front, 794.6 N rear) 
that are reused in every project later.

**Limitations:** This model does not include slip, and it assumes
tire force is exactly proportional to load. Neither of these is
accurate for a real tire.

### Linear Tire Model

File: `matlab/models/linear_tire_model.m`

This level introduces slip ratio (kappa) into the model. Force is assumed 
to increase with slip in linear progression to an assumed value, that is 
kappa_sat = 0.10, at which point the model reaches the same maximum force 
calculated in constant friction. The slip stiffness (Cx) was calculated 
from the constant friction result.

**Limitations:** The model has a cutoff at kappa_sat, and
provides no information about tire behaviour beyond that point. Based
on general tire theory, real tires do not have such a sudden
transition.

### Nonlinear Tire Model (Pacejka Magic Formula)

File: `matlab/models/nonlinear_tire_model.m`

This project stage replaces the cutoff in the linear tire model with 
the Pacejka Magic Formula. It is a formula with the curvature factor E set to 0.
It produces a curve that increases, reaches a peak, and then decreases, which is 
closer to how real tires are described to behave. The peak factor D was taken from 
constant friction results, the stiffness factor B was calculated to match the slope 
from the linear tire model, and the shape factor C = 1.65 was taken from the 
first published implementation of the Magic Formula (Bakker et al., 1986), 
which set C as a constant for longitudinal tire force.

The peak of the curve occurs at kappa = 0.2317, which is later than the kappa_sat = 0.10 value 
assumed in the linear tire model. It suggests that the assumption made in the linear tire model 
was underestimating the model, since the modelled tire continues to produce more force past the
point where the linear tire model assumed it had already reached its maximum.

### Validation

Since no tire test data was available for this project, the model
could not be validated against measured results. Instead, it was
compared to a set of published reference coefficients for a generic
dry tarmac tire (B=10, C=1.9, D=1, E=0.97), found in MathWorks vehicle
dynamics documentation. This is described in more detail in
`documentation/validation.md`.

The comparison showed that this model's peak slip ratio (0.2317) is
approximately 29% higher than the reference curve's peak slip ratio,
which was found to be approximately 0.1802 by calculating the maximum of 
the reference curve. This difference can come from the kappa_sat 
assumption that was made in the linear tire model, because it is not 
an unexplained error.

### Load Sensitivity

File: `matlab/models/load_sensitivity.m`

All previous project stages assumed that tire force is directly proportional
to vertical load. Based on the book "Race Car Vehicle Dynamics" by William F. Milliken Jr., 
it is not accurate because real tires produce less additional force as load increases. This
project stage models that behaviour using a power law, `Fx_max = k * N^epsilon`, with epsilon = 0.8, 
a value taken from the middle of the range, such as 0.7 to 0.9. This range of values is from "Load-Sensitive 
Tire–Road Friction Modeling and Dynamic Stability Analysis of Multi-Axle Trucks" article by Sung-Sic Yoo, 
Pyung-An Kim, and Heung-Shik Lee.

The rear axle, which carries a higher static load, produces approximately 3.15% less force 
under this model than it did under the linear constant friction model. It is a small
difference for this vehicle because the front and rear loads only differ by about 18%. 
However, it is expected that this effect will become more significant in future projects, 
where aerodynamic downforce and load transfer during braking or cornering are likely to
create much larger differences in load between individual tires.

Note: an error was initially made when calculating k by hand. As a result, 
an incorrect value of 3.988 was calculated. The correct value,
verified using MATLAB, is 5.1550. This error was discovered while
completing the next project stage (merging nonlinear tire model and load sensitivity) 
and was corrected.

### Unified Model (Merging nonlinear tire model and load sensitivity)

File: `matlab/models/unified_tire_model.m`

Nonlinear tire model only worked at a single fixed load for each axle. 
Load sensitivity showed that peak force should depend on load. 
This section combines the two by making the peak factor D a function of load,
D(N) = k * N^epsilon, and substituting this into the Pacejka formula
from the nonlinear tire model. Here, B and C do not depend on load, since B was 
originally derived without D appearing in the final expression.

This combined model was checked against the original nonlinear tire model result
at the front axle and produced an identical value (947.6 N), confirming that 
the merge did not introduce an error.

## Limitations Not Yet Addressed

- **Combined slip** (braking and cornering occurring at the same
  time) is not included in the model. It would require a lateral
  tire model, which has not yet been developed in the portfolio.
- **Peak slip ratio does not change with load** in the model, which
  is not realistic. Addressing this, it would require B or E to
  depend on load as well, which was judged to require real test data.
- **No real tire test data was used yet.**
  All parameters (kappa_sat, C, epsilon) are either derived from
  earlier stages of this same model or taken from values in the academic articles.


## Relevance to Later Case Studies

The unified tire model developed here will be used in several future projects:

- **Double Wishbone Suspension** will use it to determine what wheel loads the
  suspension needs to be designed to handle.
- **Brake Thermal Structural** will use the load-sensitivity behaviour to help
  size the braking system correctly under weight transfer.
- **Rear Wing CFD and Ground Effect Aero** will use it to show that aerodynamic
  downforce produces diminishing returns in grip.
- **Lap Time Simulator** will use this model as part of the full lap-time simulation,
  since load will be changing constantly throughout a simulated lap.

## Summary

This project developed a tire model in four stages, checked each stage's results against 
the previous stage, and compared the final result against a published reference where
possible. One calculation error was made and later corrected, and this is left visible 
in the documentation. The resulting model is not validated against real test data and has
known limitations, which are listed above and are intended to be addressed as the portfolio 
develops further.
