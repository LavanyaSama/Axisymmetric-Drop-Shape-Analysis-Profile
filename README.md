# Axisymmetric-Drop-Shape-Analysis-Profile
This project consists of an in-house Matlab code for calculating contact angle of a droplet. 
## 1. Drop profile detection
I did Image processing of a droplet in which drop profile coordinates were found by edge detection tehniques. We will transform the coordinate system so that apex of the drop coincides with origin to facilitate easy comparision of experimenal data with theoretical data. 
## 2. Numerical Solution
The theoretical data is obtained by solving Laplace-Young equation by varying parameters. The solution is found using the built-in ordinary differential equation solver in MATLAB®, ode45, which is based on a fourth order Runga-Kutta method.  This data will be transformed to pixels by using scale factor. Plotting theoretical data
coordinates develops theoretical profile. Thus the physical and theoretical profiles at origin will be developed.
## 3. Curve Fitting
The distance between two profiles is calculated and mimimised by varying the parameters of Laplace-Young equation until the best fit is obtained. Then, the contact angle is calculated by substituting these parameters where best fit is obtained in Laplace-Young equation.
