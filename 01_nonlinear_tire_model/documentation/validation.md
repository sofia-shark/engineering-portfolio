## Validation of Constant Friction, Linear Tire Model & Nonlinear Tire Model

**Method:** There is no measured tire test data available for the vehicle's
tires. Validation is a check against published reference Magic Formula coefficients, 
such as MathWorks vehicle dynamics documentation, dry tarmac surface: B = 10, C = 1.9, 
D = 1, E = 0.97.

**Comparison:**
- B (stiffness): the model = 6.0606, reference = 10. The curve
  rises to a peak more gradually than the reference.
- C (shape): the model = 1.65, reference = 1.9. Both have the same order
  of magnitude.
- E (curvature): the model = 0 (it is assumed), reference = 0.97.
  The model cannot represent the asymmetric curve shape that E not
  equal to zero produces.
- Peak slip ratio: the model = 0.2317, reference = ~0.18. The reference is solved
  through Pacejka's Magic Formula: Fx​(κ)=Dsin(C arctan(Bκ−E(Bκ−arctan(Bκ))))
  The model says that peak grip occurs at around 29% higher slip than the
  reference. 

**Interpretation:** The peak-slip discrepancy traces directly back to
the kappa_sat = 0.10 assumption made in the linear tire model (see assumptions.md),
which set this model's B value.

**Conclusion:** The model is acceptable in order of magnitude and
general shape.
