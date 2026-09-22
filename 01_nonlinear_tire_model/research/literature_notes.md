# Nonlinear Tire Model

This file summarizes what was learned from the sources listed in `sources.md` and how each idea was used in the project.

## The Magic Formula

The Magic Formula is described as not derived from first principles of physics, but it is built to have a specific curve shape 
that matches how real tires are known to behave. The formula uses several constants (B, C, D, E) that each controls a different 
part of the curve's shape.

## The Shape Factor C

The original 1987 version of the Magic Formula (Bakker, Nyborg, and Pacejka) did not treat C as something you fit to data. It was fixed
at one of three values depending on what you were modelling: 1.30 for lateral (cornering) force, 1.65 for longitudinal (braking or driving)
force, and 2.40 for aligning moment. Since this project only works with longitudinal force, I used C = 1.65. Blundell & Harty's 
chapter also mentioned that later versions of the formula started treating C as another value you fit from data instead of a fixed 
constant. I decided to stick with the original fixed value since I do not have real data to fit.

## Load Sensitivity

All three of the main textbooks I looked at (Milliken & Milliken, Pacejka, Gillespie) agree that tire force does not scale with
load when load goes up, you still get more force, but not proportionally more.

None of these textbooks gave me one clean number to use as the exponent. So, I took a number to use from an academic article by
Yoo, Kim, and Lee (2025), which demonstrates exponents of 0.893 (cars) and 0.821 (trucks) from fitting real tire test data. 
I used epsilon = 0.8 in the model, which is close to both of these values.
