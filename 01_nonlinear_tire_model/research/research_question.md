# Nonlinear Tire Model

## Main Research Question

How accurately can a progressively refined tire model represent the relationship between slip, vertical load, and tire force, and how does
model fidelity affect predicted vehicle behaviour?

## Supporting Questions

The following supporting questions were used to guide the project.
Each one is answered below based on what was actually found.

**How useful is a constant-friction model?**
It produced a maximum deceleration result equal to mu (1.40 g) that turned out not to depend on the vehicle's mass or weight distribution
at all. Its main practical use in this project was producing the static wheel loads used by every later stage of the model.

**What does slip stiffness tell us about tire behaviour?**
Slip stiffness describes how quickly force builds up as slip increases, in the region before the tire starts to saturate. In this
project, it was calculated from the constant-friction result.

**How does a nonlinear tire model represent tire saturation?**
Using the Pacejka Magic Formula, the model rises, reaches a peak, and then decreases as slip increases further, instead of simply reaching a
maximum and stopping. In the nonlinear tire model, the peak occurred later at a higher slip ratio than the earlier, simpler model was assuming.

**How does vertical load affect tire performance?**
Tire force does not increase in direct proportion to load. Using a power-law relationship, it was shown that the rear axle, 
which carries more static load, produces slightly less force than a simple proportional model would predict. This difference was small for
the vehicle's static loads but is expected to become more significant later in the portfolio, once aerodynamic downforce and load transfer
are introduced.

**How does combined braking and cornering affect available tireforce?**
This question was not answered in this project. Answering it would require a lateral cornering tire model, which has not been developed
yet. This has been left as a limitation and is expected to be addressed.

**How does increasing tire-model fidelity change vehicle-level predictions?**
Adding the Pacejka model showed that the earlier linear model had assumed the tire reached its maximum force too early. This suggests 
that model fidelity does matter for the specific predictions made.

**What are the limitations of the developed model?**
These are listed in `documentation/limitations.md`. The main limitations are: no real tire test data was used anywhere in this project, 
no combined slip is modelled, and the slip ratio at which peak force occurs does not change with load, which is not realistic.

## Reflection on the Original Objective

The original objective was to develop and validate a progressively refined tire model, starting with simple approximations and building
toward a model suitable for later use in vehicle-dynamics simulation. This was mostly achieved. The model was developed in four stages, and
a merged final version was created, and it was validated as far as possible with no real test data available. The final model has limitations, 
which are documented.
