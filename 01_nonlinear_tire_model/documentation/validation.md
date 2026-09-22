# Nonlinear Tire Model

## Why This Validation Is Limited

No tire test data was available for this project, since there is no
physical vehicle or physical tires involved because this is a simulation-only
project. Because of this, the model could not be validated by
comparing it against measured results, which would normally be the
preferred way to validate a tire model. Instead, a more limited check
was done by comparing this model's parameters to academic articles during research
throughout the project, to check that the model is at least in a reasonable
range and has a believable general shape.

## Reference Used

The reference used was a set of Magic Formula coefficients published
in MathWorks documentation for a generic dry tarmac surface:
B = 10, C = 1.9, D = 1, E = 0.97. It was used only as a rough point
of comparison.

## Comparison

| Parameter | This model | Reference (dry tarmac) |
|---|---|---|
| B | 6.0606 | 10 |
| C | 1.65 | 1.9 |
| E | 0 | 0.97 |
| Peak slip ratio | 0.2317 | 0.1802 (found through calculation) |

The peak slip ratio for the reference curve could not be calculated
using a simple formula, since E is not zero for the reference set.
Instead, it was found by calculating the reference curve at slip
values and identifying the highest point, using a short MATLAB script.

## Result

The model's peak slip ratio (0.2317) is approximately 29% higher than
the reference curve's peak slip ratio (0.1802). This percentage refers
to where the peak occurs along the slip axis. Both curves reach their 
own peak force value regardless of E, since that is a separate property 
of the Pacejka formula.

## Conclusion

This model is considered plausible in terms of general shape and order
of magnitude, but it should not be treated as representing any
specific real tire. A proper validation would require fitting B, C, D,
and E directly to measured data, which was not available for this project.
