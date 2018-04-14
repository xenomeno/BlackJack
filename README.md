# BlackJack

Lua implementation of Monte Carlo(Exploring Starts) for the Black Jack version described in the book Reinforcement Learning: An Introduction(Sutton & Barto)

Sample output from ZeroBrane Lua IDE:

Calculating estimate during 100000000 episodes for State 11[ACE,13,2]...
State 11[ACE,13,2] estimate: -0.274137
ordinary Importance Sampling min/max/avg squared error: 0.127950/28.904553/0.205249
weighted Importance Sampling min/max/avg squared error: 0.134244/1.349724/0.188245
State-value function for initial policy
State-value function for usable ace
{ +0.34 +0.56 +0.56 +0.56 +0.57 +0.57 +0.59 +0.60 +0.60 +0.54  }
{ -0.03 +0.36 +0.38 +0.39 +0.40 +0.41 +0.48 +0.49 +0.46 +0.20  }
{ -0.40 -0.13 -0.12 -0.11 -0.11 -0.09 -0.02 -0.04 -0.16 -0.30  }
{ -0.48 -0.21 -0.19 -0.18 -0.17 -0.13 -0.08 -0.18 -0.32 -0.37  }
{ -0.57 -0.29 -0.27 -0.25 -0.25 -0.21 -0.27 -0.37 -0.39 -0.44  }
{ -0.61 -0.34 -0.32 -0.29 -0.28 -0.26 -0.39 -0.40 -0.42 -0.47  }
{ -0.61 -0.32 -0.29 -0.28 -0.26 -0.25 -0.37 -0.39 -0.41 -0.46  }
{ -0.60 -0.31 -0.26 -0.26 -0.23 -0.23 -0.36 -0.38 -0.39 -0.45  }
{ -0.60 -0.29 -0.26 -0.24 -0.22 -0.21 -0.35 -0.37 -0.39 -0.44  }
{ -0.59 -0.27 -0.24 -0.23 -0.20 -0.19 -0.34 -0.35 -0.38 -0.45  }
State-value function for NON-usable ace
{ +0.23 +0.41 +0.42 +0.42 +0.42 +0.43 +0.44 +0.45 +0.45 +0.42  }
{ -0.11 +0.28 +0.27 +0.28 +0.29 +0.32 +0.37 +0.39 +0.35 +0.12  }
{ -0.62 -0.45 -0.45 -0.44 -0.43 -0.42 -0.38 -0.40 -0.47 -0.56  }
{ -0.67 -0.49 -0.48 -0.47 -0.47 -0.45 -0.41 -0.49 -0.57 -0.60  }
{ -0.72 -0.54 -0.53 -0.53 -0.52 -0.50 -0.51 -0.59 -0.60 -0.64  }
{ -0.75 -0.56 -0.55 -0.54 -0.51 -0.52 -0.60 -0.61 -0.62 -0.65  }
{ -0.73 -0.54 -0.52 -0.51 -0.50 -0.48 -0.57 -0.58 -0.60 -0.63  }
{ -0.72 -0.51 -0.50 -0.48 -0.48 -0.46 -0.55 -0.56 -0.57 -0.62  }
{ -0.70 -0.50 -0.48 -0.46 -0.44 -0.44 -0.52 -0.53 -0.55 -0.60  }
{ -0.68 -0.47 -0.44 -0.44 -0.42 -0.41 -0.50 -0.52 -0.53 -0.58  }


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
Init Policy Performance: 	-0.352947
Monte Carlo ES policy in 50000000 steps
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
Monte Carlo ES Policy Performance: 	-0.043705
Monte Carlo On-Policy: 0.100000 epsilon in 89635435 steps
Monte Carlo On-Policy Performance: 	-0.077251
Monte Carlo On-Policy: 0.010000 epsilon in 200000000 steps
Monte Carlo On-Policy Performance: 	-0.048406
Monte Carlo On-Policy: 0.001000 epsilon in 200000000 steps
Monte Carlo On-Policy Performance: 	-0.045561
Monte Carlo On-Policy: 0.000100 epsilon in 200000000 steps
Monte Carlo On-Policy Performance: 	-0.051488
Monte Carlo On-Policy: 0.000010 epsilon in 70519780 steps
Monte Carlo On-Policy Performance: 	-0.097492
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
           12    S S    
           11
A2345678910   A2345678910
Best Monte Carlo On-Policy Performance: 	-0.045561
Monte Carlo Off-Policy: 0.100000 epsilon in 50597083 steps
Monte Carlo Off-Policy Performance: 	-0.043497
Monte Carlo Off-Policy: 0.010000 epsilon in 60000000 steps
Monte Carlo Off-Policy Performance: 	-0.047788
Monte Carlo Off-Policy: 0.001000 epsilon in 60000000 steps
Monte Carlo Off-Policy Performance: 	-0.047788
Monte Carlo Off-Policy: 0.000100 epsilon in 60000000 steps
Monte Carlo Off-Policy Performance: 	-0.094014
Monte Carlo Off-Policy: 0.000010 epsilon in 60000000 steps
Monte Carlo Off-Policy Performance: 	-0.066712
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
Best Monte Carlo Off-Policy Performance: 	-0.043497
State-value function for optimal policy
State-value function for usable ace
{ +0.64 +0.89 +0.89 +0.89 +0.90 +0.91 +0.93 +0.93 +0.94 +0.89  }
{ +0.14 +0.65 +0.66 +0.67 +0.67 +0.71 +0.78 +0.80 +0.76 +0.44  }
{ -0.12 +0.40 +0.41 +0.43 +0.44 +0.50 +0.62 +0.60 +0.29 -0.02  }
{ -0.35 +0.13 +0.14 +0.18 +0.21 +0.29 +0.40 +0.11 -0.11 -0.20  }
{ -0.36 +0.02 +0.03 +0.09 +0.09 +0.13 +0.02 -0.07 -0.15 -0.27  }
{ -0.32 -0.02 +0.01 +0.03 +0.09 +0.09 -0.05 -0.06 -0.22 -0.35  }
{ -0.35 +0.03 +0.07 -0.04 +0.05 +0.15 -0.00 -0.04 -0.20 -0.28  }
{ -0.26 +0.02 +0.09 +0.06 +0.11 +0.19 +0.02 +0.05 -0.09 -0.11  }
{ -0.25 +0.04 +0.08 +0.12 +0.19 +0.15 +0.10 +0.06 +0.08 -0.20  }
{ -0.27 +0.10 +0.12 +0.12 +0.16 +0.16 +0.21 +0.07 +0.01 -0.15  }
State-value function for NON-usable ace
{ +0.64 +0.89 +0.89 +0.89 +0.90 +0.91 +0.93 +0.93 +0.94 +0.89  }
{ +0.14 +0.65 +0.66 +0.68 +0.68 +0.71 +0.78 +0.79 +0.76 +0.43  }
{ -0.12 +0.39 +0.42 +0.43 +0.45 +0.50 +0.63 +0.60 +0.29 -0.02  }
{ -0.37 +0.12 +0.15 +0.18 +0.21 +0.29 +0.40 +0.11 -0.18 -0.24  }
{ -0.64 -0.15 -0.12 -0.08 -0.04 +0.02 -0.11 -0.38 -0.43 -0.46  }
{ -0.65 -0.29 -0.26 -0.20 -0.16 -0.16 -0.41 -0.46 -0.50 -0.55  }
{ -0.63 -0.28 -0.25 -0.21 -0.16 -0.15 -0.36 -0.38 -0.48 -0.55  }
{ -0.58 -0.30 -0.24 -0.20 -0.16 -0.15 -0.33 -0.38 -0.45 -0.48  }
{ -0.53 -0.29 -0.25 -0.21 -0.16 -0.14 -0.28 -0.29 -0.36 -0.48  }
{ -0.56 -0.25 -0.23 -0.19 -0.16 -0.15 -0.21 -0.25 -0.32 -0.40  }
Program completed in 12229.80 seconds (pid: 6000).
