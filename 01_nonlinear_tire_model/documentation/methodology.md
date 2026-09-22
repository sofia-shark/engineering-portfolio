# Nonlinear Tire Model

This file describes how each stage of the tire model was built and
what was found at each stage.

## Constant Friction Model

**Method:** Static front and rear wheel loads were calculated from
the reference vehicle mass and weight distribution. Maximum tire
force was then calculated as Fx = mu * N for each axle.

**Result:** Front load = 676.9 N, rear load = 794.6 N. Maximum
theoretical deceleration = 13.73 m/s^2, or 1.40 g.

**Finding:** The deceleration result (1.40 g) turned out to be equal
to mu exactly, regardless of vehicle mass or weight distribution. The mass 
terms cancel out when the model is used for the whole vehicle.

## Linear Tire Model

**Method:** Slip stiffness (Cx) was calculated for each axle by
dividing the constant friction maximum force by the assumed saturation slip
ratio, kappa_sat = 0.10. Force was modelled as increasing in linear progression 
with slip ratio up to this point.

**Result:** Cx_front = 9476.5 N, Cx_rear = 11124.5 N.

**Finding:** Because the rear axle has a higher constant friction force, it also
has a higher calculated stiffness. This means the model predicts the rear tire 
reaches its maximum force over less slip or just faster, but it is a direct result 
of the calculation method used and has not been checked against any real tire behaviour.

## Nonlinear Tire Model (Pacejka Magic Formula)

**Method:** The simplified Pacejka Magic Formula with E = 0 was
used, with D taken from the constant friction stage and B calculated to 
match the slope used in the linear tire model, given a shape factor of C = 1.65.

**Result:** B_front = B_rear = 6.0606. D_front = 947.6 N, D_rear =
1112.5 N.

**Finding:** The peak of the Pacejka curve occurs at kappa = 0.2317
for both axles. This is later than the kappa_sat = 0.10 value assumed
in the linear tire model, which suggests that the linear tire model assumption
was underestimating.

## Validation

**Method:** The peak slip ratio of the reference curve was
found by evaluating the Pacejka formula at many slip
values and finding the maximum.

**Result:** The reference curve was found to peak at kappa =
0.1802. This project's model peaks at kappa = 0.2317, which is
approximately 29% higher.

**Finding:** The difference come from the kappa_sat = 0.10 assumption 
made in the linear tire model, which directly sets the value of B used from 
the nonlinear tire model onward.

## Load Sensitivity

**Method:** A power law, Fx_max = k * N^epsilon, was used in place of
the linear Fx_max = mu*N relationship used in earlier stages, with
epsilon = 0.8. The constant k was calculated so the model
matches the constant friction result at the front axle.

**Result:** k = 5.1550. At the rear axle, this model predicts Fx_max =
1077.5 N, compared to 1112.5 N from the linear constant friction model, 
a reduction of approximately 3.15%.

**Finding:** The difference between the linear and power-law
predictions is small, about 3.15%, because the front and
rear static loads are only about 18% apart. It is expected that this
difference will matter more in later projects, where sources like
aerodynamic downforce or load transfer during braking and cornering
are expected to create much larger differences in load between
individual tires.

## Unified Model (Merging Nonlinear Tire Model and Load Sensitivity)

**Method:** The fixed value of D used in the nonlinear tire model was replaced 
with the load-dependent expression from load sensitivity, D(N) = k * N^epsilon, and
substituted into the Pacejka formula. B, C, and E were kept the same as in the nonlinear 
tire model, since B does not depend on D or on load.

**Result:** The combined model was checked against the original nonlinear tire model 
result at the front axle and produced the same value (947.6 N),
which was taken as confirmation that the merge was done correctly.

**Finding:** The combined model can be used to estimate tire
force at any load.
