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
