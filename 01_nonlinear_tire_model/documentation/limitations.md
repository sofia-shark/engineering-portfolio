## Linear Tire Model

- The model is only valid within the assumed linear region (kappa <= 0.10).
  It says nothing about tire behaviour beyond this point.
- Cx is a derived quantity. It inherits all of constant friction's limitations,
  such as no real load sensitivity and no combined slip.
- Real tires do not have a sharp transition from linear to saturated
  behaviour at one exact kappa value.

## Nonlinear Tire Model: Pacejka Magic Formula

- **E = 0** is a simplification. Real tires in real environments have an E value
  different from zero.
- **C = 1.65** is a value that is taken from the "Tire and Vehicle Dynamics" book
  by Hans B. Pacejka.
- **B value** is the same for front and rear. It is an artifact of how B was derived
  (see methodology.md).
- This model only represents pure longitudinal slip. It does not show cornering behaviour
  and combined-slip interaction between braking and cornering.
- After the peak, this model's force asymptotically approaches D*sin(C*pi/2). Real tire
  behaviour at very high slip is more complex than the simplified curve captures.

## Validation

- No measured tire test data exists for this vehicle. All validation
  is against generic published reference coefficients.
- E = 0 is the single largest identified gap versus the reference
  curve shape (reference E = 0.97). This model cannot represent
  curve asymmetry that a real tire likely demonstrates.
- The peak-slip discrepancy (0.2317 against ~0.18 reference).
