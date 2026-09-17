## Constant Friction Model

**Purpose:** Establish a baseline before introducing slip-dependent
tire behaviour.

**Assumptions:**
- Constant coefficient of friction (mu = 1.4), independent of slip,
  slip ratio, or vertical load.
- Static corner loads only. There is no longitudinal or lateral load transfer.
- No distinction between tire behaviour under braking and cornering.

**Reference vehicle:** m = 300 kg (230 kg dry + 70 kg driver), Wf = 0.46.

**Result:** Front static load = 676.9 N/tire, rear = 794.6 N/tire.
Theoretical max deceleration = 13.73 m/s^2 (1.40 g).

**Key finding:** Whole car maximum deceleration under this model equals
mu (in g's), independent of mass and weight distribution. Weight
distribution only determines the front/rear split of that total force.

**Why this model is inadequate:**
- Real tires generate zero force at zero slip and need some slip
  angle/ratio to build up force. The model has no slip variable.
- Real tire force does not scale linearly with load. Grip per unit
  load decreases as load increases, so the model overestimates rear grip
  relative to front grip whenever loads are unequal, since both corners
  are scaled by the same mu.
- 1.40 g is a physically implausible sustained deceleration for most
  race tires in practice. It assumes the entire theoretical friction
  circle is usable simultaneously with no losses, which real
  contact patch behaviour never achieves.


## Linear Tire Model

**Purpose:** Introduce slip-ratio dependency, replacing constant friction's
instant, slip-independent force assumption.

**Method:** Cx derived per axle as Fx_max(constant friction) / kappa_sat,
with kappa_sat = 0.10.

**Result:** Cx_front = 9476 N, Cx_rear = 11125 N.

**Key finding:** Force now builds progressively with slip rather than
being instantly available. Because the rear axle has a higher constant
friction max force and a higher derived slip stiffness, means the
rear tire is modelled to reach its grip limit faster at lower
slip in absolute force terms, though both axles saturate at the same
kappa_sat by construction.


## Nonlinear Tire Model: Pacejka Magic Formula

**Purpose:** Replace linear tire model's artificial linear cutoff with a smooth
curve exhibiting rise-peak falloff behaviour.

**Method:** Simplified Magic Formula, where E = 0, D taken directly from
constant friction and B derived to match linear tire model's initial slope, 
given shape factor of C = 1.65. The value is taken from the "Tire and Vehicle Dynamics"
book by Hans B. Pacejka.

**Result:** B_front = B_rear = 6.0606. D_front = 947.6 N, D_rear = 1112.5 N. 
Peak force occurs at kappa ~0.231 for both axles.

**Peak location:** At the Pacejka curve's peak,
C*atan(B*kappa_M) = pi/2 exactly, so sin = 1 and peak force always equals D 
regardless of B or C. Peak slip ratio is kappa_M = tan(pi/(2C)) / B. 
For this model, kappa_M = 0.2317 for both axles, with peak force = D_front = 947.6 N 
and D_rear = 1112.5 N respectively.

**Key finding:** Because B was derived as Cx/(C*D), and Cx itself was
defined as Fx_max/kappa_sat in linear tire model, the Fx_max terms cancel
algebraically, so B depends only on C and kappa_sat.
It means front and rear end up with identical B despite different
loads.
