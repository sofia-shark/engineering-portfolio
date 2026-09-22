# Nonlinear Tire Model

This file lists the sources used in this project. Sources are grouped by what they were used for.

## Pacejka Magic Formula: Shape Factor C

The values C = 1.30 (lateral force), C = 1.65 (longitudinal force), and C = 2.40 (aligning moment) used in 
the nonlinear tire model came originally from:

- Bakker, E., Nyborg, L., and Pacejka, H. B., "Tyre Modelling for Use in Vehicle Dynamics Studies,"
  SAE Technical Paper, February 1987. Available at: 'https://www.jstor.org/stable/44470677'

The first published version of the Magic Formula, where C was set as a fixed constant depending on which force or moment curve was
being modelled. This project only used the longitudinal value (1.65), since it only models longitudinal force.

A more accessible source that reproduces the same three values and explains them clearly is:

- Blundell, M., and Harty, D., "Tyre Characteristics and Modelling,"
  Chapter 5 in *The Multibody Systems Approach to Vehicle Dynamics*,
  2nd ed., Butterworth-Heinemann/Elsevier, 2015.

This chapter was used as the main reference for understanding what C actually does.

Additional background:

- Pacejka, H. B., *Tire and Vehicle Dynamics*, 3rd ed.,
  Butterworth-Heinemann/Elsevier, Oxford, 2012. ISBN 978-0-08-097016-5.
  Chapter 4 covers the Magic Formula in detail, including how C
  affects the curve shape.

## Load Sensitivity

The idea that tire force does not scale directly with vertical load
(i.e., doubling the load does not double the grip) is discussed in
several standard vehicle dynamics textbooks, including:

- Milliken, W. F., and Milliken, D. L., *Race Car Vehicle Dynamics*,
  SAE International, Warrendale, PA, 1995. ISBN 978-1-56091-526-3.
  Chapter 2 shows this behaviour graphically (Figure 2.9), plotting
  the lateral force coefficient falling as vertical load increases.
- Pacejka, H. B., *Tire and Vehicle Dynamics*, 3rd ed.,
  Butterworth-Heinemann/Elsevier, 2012. Chapter 1, Figure 1.3, also
  shows peak force growing more slowly than load.
- Gillespie, T. D., *Fundamentals of Vehicle Dynamics*, SAE
  International, Warrendale, PA, 1992. ISBN 978-1-56091-199-9.

None of these three books gives a single exponent number for this
effect — they show it as a graph, not a formula with one fitted
constant. So for the actual numeric exponent (epsilon = 0.8) used in
Level 3, this project instead used:

- Yoo, S.-S., Kim, P.-A., and Lee, H.-S., "Load-Sensitive Tire-Road
  Friction Modeling and Dynamic Stability Analysis of Multi-Axle
  Trucks," *Applied Sciences*, vol. 15, no. 22, article 12269, 2025.
  DOI: 10.3390/app152212269.

This paper fits a power-law exponent to real tire data and reports a
value of 0.893 for passenger car tires and 0.821 for heavy-truck
tires. epsilon = 0.8 (used in this project) was chosen as a round
number close to these fitted values, sitting slightly below both.

The original experimental data behind that paper's fit traces back to:

- Segel, L., and Ervin, R. D., "The Measurement and Analysis of Tire
  Cornering Characteristics under Varying Loads," SAE Technical Paper
  810175, 1981.

## Note on Earlier Version of This File

An earlier version of this project cited Wikipedia's "Tire load
sensitivity" article for the 0.7-0.9 exponent range. That article's
own claim about the 0.7-0.9 range carries a "[citation needed]" tag on
Wikipedia itself, meaning even Wikipedia does not have a confirmed
source for that specific number. Because of this, the citation was
replaced with the Yoo, Kim & Lee (2025) source above, which is a
peer-reviewed paper with an actual fitted number behind it. This is
noted here rather than just quietly changed, to keep an honest record
of how the sourcing for this project improved over time.
