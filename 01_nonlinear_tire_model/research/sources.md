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

- Blundell, M., and Harty, D., "Tyre Characteristics and Modelling," Chapter 5 in *The Multibody Systems Approach to Vehicle Dynamics*, 2nd edition, 2015.
  Available at: 'https://www.researchgate.net/publication/289102231_The_Multibody_Systems_Approach_to_Vehicle_Dynamics'

This chapter was used as the main reference for understanding what C actually does.

## Load Sensitivity

The idea that tire force does not scale directly with vertical load is discussed in several standard vehicle dynamics textbooks:

- Milliken, W. F., and Milliken, D. L., *Race Car Vehicle Dynamics*, 1995.
  Available at: 'https://www.semanticscholar.org/paper/Race-Car-Vehicle-Dynamics-Milliken-Milliken/9d5d2cfab23a60fb29ea6ac001641538df06f311'.
- Pacejka, H. B., *Tire and Vehicle Dynamics*, 2nd edition, 2006.
  Available at: 'https://ftp.idu.ac.id/wp-content/uploads/ebook/tdg/TERRAMECHANICS%20AND%20MOBILITY/epdf.pub_tyre-and-vehicle-dynamics-second-edition.pdf'
- Gillespie, T. D., *Fundamentals of Vehicle Dynamics*, 1992.
  Available at: 'https://www.academia.edu/6733064/Thomas_D_Gillespie_Fundamentals_of_Vehicle_Dynamics_Society_of_Automotive_Engineers_Inc_1992_'

The number exponent (epsilon = 0.8) used in load sensitivity, I used:

- Yoo, Kim, and Lee, "Load-Sensitive Tire-Road Friction Modeling and Dynamic Stability Analysis of Multi-Axle Trucks,"
  Available at: 'https://www.mdpi.com/2076-3417/15/22/12269'

This academic paper shows a power-law exponent for real tire data and demonstrates a value of 0.893 for passenger car tires and 0.821 for heavy-truck
tires. Epsilon = 0.8 was chosen as a round number close to these values.
