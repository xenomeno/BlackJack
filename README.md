# BlackJack

Lua implementation of Monte Carlo(Exploring Starts), On-Policy and Off-Policy for the Black Jack version described in the book Reinforcement Learning: An Introduction(Sutton & Barto). Added support for single state value estimation via Off-Policy algorithm both using Ordinary and Weighted Sampling.

Sample output from ZeroBrane Lua IDE

Calculating estimate during 100000000 episodes for State 11[ACE,13,2]...
State 11[ACE,13,2] estimate: -0.277329
ordinary Importance Sampling min/max/avg squared error: 0.126738/8.277198/0.193476
weighted Importance Sampling min/max/avg squared error: 0.134094/1.298375/0.186918
State-value function for initial policy
State-value function for usable ace
{ +0.34 +0.56 +0.55 +0.56 +0.56 +0.57 +0.59 +0.60 +0.60 +0.54  }
{ -0.03 +0.35 +0.37 +0.38 +0.39 +0.41 +0.47 +0.48 +0.46 +0.20  }
{ -0.40 -0.14 -0.13 -0.12 -0.11 -0.09 -0.02 -0.04 -0.16 -0.31  }
{ -0.48 -0.21 -0.19 -0.19 -0.17 -0.14 -0.07 -0.19 -0.32 -0.37  }
{ -0.56 -0.30 -0.27 -0.26 -0.25 -0.22 -0.27 -0.37 -0.38 -0.44  }
{ -0.61 -0.34 -0.33 -0.29 -0.28 -0.26 -0.39 -0.40 -0.42 -0.47  }
{ -0.61 -0.33 -0.29 -0.28 -0.26 -0.25 -0.38 -0.39 -0.42 -0.46  }
{ -0.59 -0.31 -0.27 -0.27 -0.23 -0.23 -0.36 -0.39 -0.39 -0.45  }
{ -0.60 -0.29 -0.26 -0.25 -0.22 -0.21 -0.35 -0.37 -0.39 -0.44  }
{ -0.59 -0.27 -0.24 -0.24 -0.21 -0.19 -0.34 -0.35 -0.38 -0.45  }
State-value function for NON-usable ace
{ +0.23 +0.41 +0.42 +0.41 +0.42 +0.43 +0.44 +0.44 +0.45 +0.42  }
{ -0.11 +0.27 +0.27 +0.28 +0.28 +0.32 +0.36 +0.39 +0.35 +0.12  }
{ -0.62 -0.45 -0.45 -0.44 -0.43 -0.42 -0.38 -0.39 -0.47 -0.56  }
{ -0.67 -0.49 -0.48 -0.47 -0.47 -0.45 -0.41 -0.49 -0.57 -0.60  }
{ -0.72 -0.54 -0.53 -0.53 -0.52 -0.50 -0.52 -0.59 -0.60 -0.64  }
{ -0.74 -0.56 -0.55 -0.54 -0.52 -0.52 -0.60 -0.61 -0.62 -0.65  }
{ -0.73 -0.54 -0.52 -0.51 -0.50 -0.49 -0.57 -0.58 -0.60 -0.63  }
{ -0.72 -0.51 -0.50 -0.48 -0.48 -0.47 -0.55 -0.56 -0.57 -0.62  }
{ -0.70 -0.50 -0.48 -0.46 -0.45 -0.45 -0.52 -0.54 -0.55 -0.60  }
{ -0.68 -0.47 -0.45 -0.44 -0.42 -0.41 -0.50 -0.52 -0.53 -0.58  }

Player's Init policy
Usable ace    NON-usable ace
A2345678910   A2345678910
SSSSSSSSSS 21 SSSSSSSSSS
SSSSSSSSSS 20 SSSSSSSSSS
           19           
           18           
           17           
           16           
           15           
           14           
           13           
           12           
           11
A2345678910   A2345678910
Init Policy Performance: 	-0.351832
Monte Carlo ES policy in 49272280 steps
Usable ace    NON-usable ace
A2345678910   A2345678910
SSSSSSSSSS 21 SSSSSSSSSS
SSSSSSSSSS 20 SSSSSSSSSS
SSSSSSSSSS 19 SSSSSSSSSS
 SSSSSSS   18 SSSSSSSSSS
           17 SSSSSSSSSS
           16  SSSSS    
           15  SSSSS    
           14  SSSSS    
           13  SSSSS    
           12    SSS    
           11
A2345678910   A2345678910
Monte Carlo ES Policy Performance: 	-0.045849
Monte Carlo On-Policy: 0.100000 epsilon in 166487896 steps
Monte Carlo On-Policy Performance: 	-0.077226
Monte Carlo On-Policy: 0.010000 epsilon in 200000000 steps
Monte Carlo On-Policy Performance: 	-0.050049
Monte Carlo On-Policy: 0.001000 epsilon in 200000000 steps
Monte Carlo On-Policy Performance: 	-0.048336
Monte Carlo On-Policy: 0.000100 epsilon in 200000000 steps
Monte Carlo On-Policy Performance: 	-0.053653
Monte Carlo On-Policy: 0.000010 epsilon in 70202753 steps
Monte Carlo On-Policy Performance: 	-0.092937
Best On-Policy
Usable ace    NON-usable ace
A2345678910   A2345678910
SSSSSSSSSS 21 SSSSSSSSSS
SSSSSSSSSS 20 SSSSSSSSSS
SSSSSSSSSS 19 SSSSSSSSSS
 SSSSSSS   18 SSSSSSSSSS
           17 SSSSSSSSSS
           16  SSSSS    
           15  SSSSS    
           14  SSSSS    
           13  SSSSS    
           12    SSS    
           11
A2345678910   A2345678910
Best Monte Carlo On-Policy Performance: 	-0.048336
Monte Carlo Off-Policy: 0.100000 epsilon in 92914984 steps
Monte Carlo Off-Policy Performance: 	-0.047313
Monte Carlo Off-Policy: 0.010000 epsilon in 150000000 steps
Monte Carlo Off-Policy Performance: 	-0.049826
Monte Carlo Off-Policy: 0.001000 epsilon in 150000000 steps
Monte Carlo Off-Policy Performance: 	-0.060129
Monte Carlo Off-Policy: 0.000100 epsilon in 150000000 steps
Monte Carlo Off-Policy Performance: 	-0.09249
Monte Carlo Off-Policy: 0.000010 epsilon in 96822535 steps
Monte Carlo Off-Policy Performance: 	-0.069284
Best Off-Policy
Usable ace    NON-usable ace
A2345678910   A2345678910
SSSSSSSSSS 21 SSSSSSSSSS
SSSSSSSSSS 20 SSSSSSSSSS
SSSSSSSSSS 19 SSSSSSSSSS
 SSSSSSS   18 SSSSSSSSSS
           17 SSSSSSSSSS
           16  SSSSS    
           15  SSSSS    
           14  SSSSS    
           13  SSSSS    
           12     SS    
           11
A2345678910   A2345678910
Best Monte Carlo Off-Policy Performance: 	-0.047313
State-value function for optimal policy
State-value function for usable ace
{ +0.64 +0.88 +0.89 +0.89 +0.89 +0.90 +0.93 +0.93 +0.94 +0.89  }
{ +0.16 +0.64 +0.65 +0.66 +0.67 +0.71 +0.77 +0.78 +0.76 +0.43  }
{ -0.11 +0.39 +0.41 +0.42 +0.43 +0.50 +0.62 +0.60 +0.29 -0.01  }
{ -0.32 +0.12 +0.15 +0.18 +0.20 +0.29 +0.40 +0.10 -0.12 -0.22  }
{ -0.32 +0.03 +0.01 +0.10 +0.11 +0.09 +0.06 -0.10 -0.13 -0.26  }
{ -0.31 -0.01 +0.04 +0.03 +0.08 +0.09 -0.01 -0.09 -0.18 -0.31  }
{ -0.39 +0.02 +0.05 +0.01 +0.08 +0.12 +0.00 -0.06 -0.24 -0.25  }
{ -0.34 +0.10 +0.11 +0.08 +0.11 +0.20 +0.02 +0.05 -0.08 -0.23  }
{ -0.29 -0.02 +0.04 +0.07 +0.18 +0.12 +0.05 +0.09 +0.06 -0.19  }
{ -0.29 +0.09 +0.15 +0.12 +0.15 +0.21 +0.15 +0.11 +0.05 -0.14  }
State-value function for NON-usable ace
{ +0.64 +0.88 +0.89 +0.89 +0.89 +0.90 +0.92 +0.93 +0.94 +0.89  }
{ +0.14 +0.64 +0.65 +0.66 +0.67 +0.70 +0.77 +0.79 +0.76 +0.44  }
{ -0.12 +0.38 +0.41 +0.42 +0.44 +0.50 +0.62 +0.60 +0.28 -0.02  }
{ -0.37 +0.12 +0.15 +0.17 +0.19 +0.28 +0.40 +0.10 -0.18 -0.24  }
{ -0.64 -0.16 -0.12 -0.09 -0.05 +0.01 -0.11 -0.39 -0.42 -0.46  }
{ -0.66 -0.29 -0.26 -0.20 -0.17 -0.16 -0.40 -0.45 -0.52 -0.56  }
{ -0.64 -0.30 -0.25 -0.21 -0.16 -0.16 -0.39 -0.37 -0.48 -0.53  }
{ -0.58 -0.30 -0.25 -0.21 -0.16 -0.15 -0.34 -0.38 -0.44 -0.50  }
{ -0.54 -0.29 -0.25 -0.21 -0.16 -0.14 -0.29 -0.30 -0.38 -0.50  }
{ -0.55 -0.27 -0.24 -0.20 -0.16 -0.16 -0.21 -0.22 -0.32 -0.40  }
Program completed in 22769.16 seconds (pid: 2404).
