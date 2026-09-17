## Linear Tire Model

- Model is only valid within the assumed linear region (kappa <= 0.10).
  It says nothing about tire behaviour beyond this point.
- Cx is a derived quantity. It inherits all of constant friction's limitations,
  such as no real load sensitivity and no combined slip.
- Real tires do not have a sharp transition from linear to saturated
  behaviour at one exact kappa value.

## Nonlinear Tire Model: Pacejka Magic Formula

- **E = 0** is a simplification. Real tires in real environment have E value
  different from zero.
- **C = 1.65** is a value, which is take from the "Tire and Vehicle Dynamics" book
  by Hans B. Pacejka.
- **B value** is same for front and rear. It is an artifact of how B was derived
  (see methodology.md).
- This model only represents pure longitudinal slip. It does not show cornering behaviour
  and combined-slip interaction between braking and cornering.
- After the peak, this model's force asymptotically approaches D*sin(C*pi/2). Real tire
  behaviour at very high slip is more complex than simplified curve captures.
