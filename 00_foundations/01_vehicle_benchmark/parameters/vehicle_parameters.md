## Parameter: Vehicle Mass
- Dry vehicle mass: 230 kg
- Driver mass: 70 kg
- Total mass (m): 300 kg

**Justification:** Representative of FSAE-scale open-wheel vehicles,
which typically range from 250–320 kg ready-to-race.

**Uncertainty:** ±20 kg depending on final chassis/powertrain choice and
treated as a nominal baseline, which is refinable later without breaking the
model structure.

## Parameter: Weight Distribution
- Front: 46%
- Rear: 54%

**Justification:** Representative of a mid/rear-engine FSAE-style open-wheel
car, giving rear-biased grip for acceleration while retaining adequate
front-end grip for turn-in. Chosen as a defensible baseline rather than
a neutral 50/50 split.

**Derived static axle weights (at m = 300 kg, g = 9.81 m/s²):**
- Total weight: 2943 N
- Front axle weight: 1354 N
- Rear axle weight: 1589 N

**Uncertainty:** ±2–3% depending on final component packaging and treated
as adjustable baseline.

## Parameter: Center-of-Gravity Height
- CG height (h_cg): 0.30 m

**Justification:** Representative of a low, open-wheel FSAE-style car
with a seated driver and low-mounted powertrain/battery mass. Low CG
height minimizes load transfer under braking/cornering, consistent
with a performance-oriented design target.

**Uncertainty:** ±30-50 mm depending on final packaging (seat position,
battery/engine placement), it is treated as adjustable baseline used for
load-transfer calculations, such as braking, cornering, and lap simulation.

## Parameter: Wheelbase
- Wheelbase (L): 1.55 m

**Justification:** Representative of FSAE-scale open-wheel vehicles,
which typically use a 1.5-1.6 m wheelbase to balance agility on tight
circuits against straight-line stability and controlled load transfer.

**Uncertainty:** ±0.05 m depending on final chassis/suspension hardpoint
layout; treated as adjustable baseline.

## Parameter: Track Width
- Front track (t_f): 1.20 m
- Rear track (t_r): 1.15 m

**Justification:** Representative of FSAE-scale open-wheel vehicles,
typically 1.2-1.3 m. Slightly narrower rear track is a common packaging
choice (bodywork, diffuser clearance, drivetrain) and modestly increases
rear lateral load transfer relative to front.

**Uncertainty:** ±0.05 m. Actual values will be refined once double wishbone
suspension hardpoints are defined. Track width is a geometric output of
suspension design, not just an independent input, so this baseline may be
adjusted once real hardpoint coordinates exist.

## Parameter: Tire Dimensions
- Tire size notation: 6.0 / 18.0 x 10
- Overall diameter (D): 0.457 m
- Section width (w): 0.152 m
- Unloaded rolling radius (r): 0.229 m

**Justification:** Representative of common FSAE-class racing tires
Hoosier, which has tire dimensions of 18x6.0-10, chosen for high 
grip-to-mass ratio typical of small open-wheel formula cars.

**Note:** r = 0.229 m is the unloaded rolling radius. Under vertical
load, the tire deflects, and the loaded radius is slightly smaller, 
around 1-3% less. This distinction will be revisited once
load-sensitivity work begins in the tire model itself. For now, the
unloaded radius is used as the baseline geometric reference.

**Uncertainty:** Actual tire choice may change once a specific compound/
manufacturer is selected. Treated as adjustable baseline.

## Parameter: Static Tire Vertical Load (Per Corner)
- Static load per front tire (Fz_front): 677 N
- Static load per rear tire (Fz_rear): 795 N

**Derivation:** Fz_front = Wf / 2 = 1354 / 2 = 677 N
                Fz_rear  = Wr / 2 = 1589 / 2 = 795 N (rounded)

**Assumption:** Symmetric left-right mass distribution has no static
cross-weight, and each axle's weight splits evenly between left and right
tires.

**Uncertainty:** Assumes no static cross-weight/corner-weighting offset,
which is a simplification. Real vehicles are rarely symmetric. 
It can be refined later if corner-weighting becomes relevant.

## Parameter: Baseline Friction Coefficient
- Friction coefficient (mu): 1.4

**Justification:** Representative of racing slick tires on a dry,
high-grip surface. Racing slicks routinely exceed mu = 1.0 due to
compound adhesion and hysteresis effects, unlike typical road-car
tires, where mu ~ 0.7-1.0.

**Derived peak grip (F = mu * Fz):**
- Front tire: 1.4 x 677 = 948 N
- Rear tire: 1.4 x 795 = 1113 N

**Purpose:** This is the simplest possible tire model, which has constant friction,
no load sensitivity, and no slip dependency, and serves as a baseline reference 
to compare against.

**Limitation:**
This model assumes force scales linearly with load, which real tires
do not do. Grip-per-unit-load decreases as load increases (load sensitivity). 

## Parameter: Reference Operating Conditions
- Speed range: 0-25 m/s (0-90 km/h)
- Max longitudinal acceleration/deceleration: ±13.7 m/s^2 (~1.4g)
- Max lateral acceleration: 13.7 m/s^2 (~1.4g)
- Typical corner radius range: 9-36 m

**Derivation:** a_max = mu x g = 1.4 x 9.81 = 13.7 m/s^2, using the
baseline friction coefficient as the theoretical grip limit.
Lateral and longitudinal limits are treated as equal, which is a simplification. 
Combined-slip behavior, where the two limits interact, is addressed in further stages.

**Justification:** Representative of FSAE-style autocross/endurance
circuits, which favor tight, technical layouts over high top speed.

**Purpose:** Defines the valid operating envelope for the tire model
and all downstream simulations. Slip ratio/slip angle sweeps in the
tire model will be scoped to remain physically meaningful within this
envelope, and validation plots will be checked against these bounds.

**Uncertainty:** a_max/a_y,max are theoretical maxima assuming full
utilization of mu. Real achievable acceleration will be somewhat lower
due to suspension, weight transfer, and driver factors. This envelope
represents the upper bound.

# Units and Conventions (Throughout the Portfolio)

## Unit System
SI units throughout: kg, m, s, N, Pa, rad.
Any input naturally specified in imperial units is converted to SI immediately 
at the point of definition and never stored or calculated in non-SI units.

## Coordinate System
- x: longitudinal, positive forward (direction of travel)
- y: lateral, positive to the right (viewed from above, vehicle facing forward)
- z: vertical, positive downward for tire load (Fz is positive and downward force on tire).
  Note: this is a practical tire-modeling convention. It is stated explicitly
  to avoid ambiguity in later suspension or vehicle-dynamics work.

## Slip Conventions
- Slip ratio (kappa): when positive, then wheel speed exceeds ground speed.
  When negative, then braking.
- Slip angle (alpha): positive per SAE y-axis convention (positive y is right).

## Angle Units
- All internal calculations use radians.
- Degrees used only for plot axes/display.

## Rounding / Precision Convention
- Intermediate calculations: full floating-point precision.
- Documented/reported values: 3 significant figures unless otherwise noted.
- Validation checks: rounding differences up to ~1 unit in the last
  reported digit are expected.

## Reference
This document applies to the whole portfolio. Any project-specific
deviation from this convention must be explicitly noted in that case
project's own documentation/assumptions.md file.

## Parameter Summary & Confidence Table

| # | Parameter               | Value               | Source Type          | Confidence | Notes |
|---|-------------------------|---------------------|----------------------|------------|-------|
| 1 | Total mass (m)          | 300 kg              | Engineering judgment | Medium     | Typical FSAE range 250-320 kg |
| 2 | Weight distribution     | 46F / 54R           | Engineering judgment | Medium     | Mid/rear-engine layout assumption |
| 3 | CG height (h_cg)        | 0.30 m              | Engineering judgment | Medium     | Low, seated-driver layout |
| 4 | Wheelbase (L)           | 1.55 m              | Engineering judgment | Medium     | Typical FSAE range 1.5-1.6 m |
| 5 | Track width (t_f, t_r)  | 1.20 m / 1.15 m     | Engineering judgment | Medium     | To be refined once Case Study 2 suspension geometry exists |
| 6 | Tire size (D, w, r)     | 0.457/0.152/0.229 m | Known product family | High       | Based on common 18x6.0-10 FSAE tire spec |
| 7 | Static tire load (Fz)   | 677 N / 795 N       | Derived (calculated) | High       | Direct calculation from #1-2, not an assumption |
| 8 | Friction coefficient (μ)| 1.4                 | Engineering judgment | Medium     | Typical racing-slick range; compound-specific data would refine this |
| 9 | Operating envelope      | 0-25 m/s, ±13.7 m/s²| Derived + judgment   | Medium     | Derived from μ; track/speed assumptions from typical autocross layout |
|10 | Units/conventions       | SI, SAE-style       | Engineering standard | High       | Industry-standard convention, not a physical assumption |
