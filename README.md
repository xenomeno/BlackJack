# BlackJack

Lua implementation of Monte Carlo(Exploring Starts) for the Black Jack version described in the book Reinforcement Learning: An Introduction(Sutton & Barto)

Sample output from ZeroBrane Lua IDE:

Calculating estimate during 100000000 episodes for State 11[ACE,13,2]...
State 11[ACE,13,2] estimate: -0.274289
Weighted Importance Sampling min/max/avg squared error: 0.145148/1.371645/0.207131
State-value function for initial policy
State-value function for usable ace

{ +0.34 +0.56 +0.55 +0.56 +0.56 +0.57 +0.59 +0.60 +0.60 +0.54  }
{ -0.03 +0.37 +0.38 +0.40 +0.40 +0.42 +0.48 +0.49 +0.46 +0.20  }
{ -0.40 -0.13 -0.12 -0.10 -0.10 -0.08 -0.02 -0.04 -0.16 -0.31  }
{ -0.47 -0.21 -0.19 -0.18 -0.17 -0.13 -0.07 -0.19 -0.31 -0.37  }
{ -0.56 -0.29 -0.26 -0.25 -0.24 -0.21 -0.27 -0.37 -0.38 -0.45  }
{ -0.61 -0.33 -0.32 -0.29 -0.27 -0.26 -0.39 -0.40 -0.42 -0.47  }
{ -0.60 -0.31 -0.29 -0.27 -0.25 -0.24 -0.37 -0.39 -0.41 -0.46  }
{ -0.60 -0.30 -0.26 -0.26 -0.23 -0.22 -0.35 -0.38 -0.40 -0.45  }
{ -0.60 -0.27 -0.25 -0.23 -0.22 -0.21 -0.35 -0.37 -0.39 -0.45  }
{ -0.59 -0.26 -0.24 -0.22 -0.20 -0.18 -0.34 -0.35 -0.38 -0.45  }

State-value function for NON-usable ace

{ +0.22 +0.41 +0.42 +0.41 +0.42 +0.43 +0.44 +0.45 +0.46 +0.42  }
{ -0.11 +0.28 +0.27 +0.29 +0.29 +0.33 +0.37 +0.39 +0.35 +0.11  }
{ -0.62 -0.44 -0.45 -0.44 -0.43 -0.41 -0.38 -0.39 -0.47 -0.56  }
{ -0.67 -0.48 -0.48 -0.47 -0.47 -0.44 -0.41 -0.49 -0.57 -0.60  }
{ -0.72 -0.53 -0.53 -0.52 -0.51 -0.49 -0.51 -0.59 -0.60 -0.64  }
{ -0.75 -0.55 -0.54 -0.54 -0.52 -0.51 -0.60 -0.60 -0.62 -0.66  }
{ -0.73 -0.54 -0.52 -0.51 -0.50 -0.48 -0.57 -0.58 -0.60 -0.63  }
{ -0.72 -0.51 -0.50 -0.47 -0.48 -0.46 -0.55 -0.56 -0.57 -0.62  }
{ -0.70 -0.49 -0.48 -0.46 -0.44 -0.44 -0.53 -0.53 -0.55 -0.60  }
{ -0.68 -0.47 -0.43 -0.43 -0.42 -0.40 -0.50 -0.52 -0.53 -0.58  }


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
Init Policy Performance: 	-0.351515
Monte Carlo ES policy in 40997640 steps
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
Monte Carlo ES Policy Performance: 	-0.04172
Monte Carlo On-Policy: 0.100000 epsilon in 85384370 steps
Monte Carlo On-Policy Performance: 	-0.071159
Monte Carlo On-Policy: 0.010000 epsilon in 123016126 steps
Monte Carlo On-Policy Performance: 	-0.043552
Monte Carlo On-Policy: 0.001000 epsilon in 150000000 steps
Monte Carlo On-Policy Performance: 	-0.040122
Monte Carlo On-Policy: 0.000100 epsilon in 150000000 steps
Monte Carlo On-Policy Performance: 	-0.05101
Monte Carlo On-Policy: 0.000010 epsilon in 70049339 steps
Monte Carlo On-Policy Performance: 	-0.104646
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
Best Monte Carlo On-Policy Performance: 	-0.040122
Monte Carlo Off-Policy: 0.100000 epsilon in 85384370 steps
Monte Carlo Off-Policy Performance: 	-0.071159
Monte Carlo Off-Policy: 0.010000 epsilon in 123016126 steps
Monte Carlo Off-Policy Performance: 	-0.043552
Monte Carlo Off-Policy: 0.001000 epsilon in 150000000 steps
Monte Carlo Off-Policy Performance: 	-0.040122
Monte Carlo Off-Policy: 0.000100 epsilon in 150000000 steps
Monte Carlo Off-Policy Performance: 	-0.05101
Monte Carlo Off-Policy: 0.000010 epsilon in 70049339 steps
Monte Carlo Off-Policy Performance: 	-0.104646
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
           12    SSS    
           11
A2345678910   A2345678910
Best Monte Carlo Off-Policy Performance: 	-0.040122
State-value function for optimal policy
State-value function for usable ace
{ +0.64 +0.89 +0.89 +0.89 +0.89 +0.91 +0.93 +0.93 +0.94 +0.89  }
{ +0.15 +0.65 +0.66 +0.67 +0.68 +0.71 +0.78 +0.80 +0.76 +0.44  }
{ -0.12 +0.40 +0.42 +0.43 +0.45 +0.51 +0.63 +0.60 +0.29 -0.02  }
{ -0.34 +0.14 +0.17 +0.19 +0.22 +0.30 +0.41 +0.11 -0.10 -0.20  }
{ -0.40 +0.02 +0.04 +0.07 +0.10 +0.14 +0.06 -0.07 -0.15 -0.25  }
{ -0.38 -0.01 +0.02 +0.05 +0.08 +0.11 -0.00 -0.07 -0.15 -0.26  }
{ -0.35 +0.01 +0.04 +0.07 +0.10 +0.13 +0.04 -0.03 -0.11 -0.24  }
{ -0.32 +0.04 +0.07 +0.09 +0.12 +0.15 +0.08 +0.01 -0.08 -0.20  }
{ -0.30 +0.06 +0.09 +0.11 +0.14 +0.17 +0.13 +0.05 -0.04 -0.17  }
{ -0.27 +0.09 +0.12 +0.14 +0.17 +0.19 +0.17 +0.10 -0.00 -0.13  }
State-value function for NON-usable ace
{ +0.64 +0.89 +0.89 +0.89 +0.90 +0.91 +0.93 +0.93 +0.94 +0.89  }
{ +0.14 +0.65 +0.66 +0.67 +0.68 +0.71 +0.78 +0.80 +0.76 +0.43  }
{ -0.12 +0.40 +0.42 +0.43 +0.45 +0.51 +0.63 +0.60 +0.29 -0.02  }
{ -0.38 +0.14 +0.17 +0.19 +0.22 +0.30 +0.41 +0.11 -0.18 -0.24  }
{ -0.64 -0.13 -0.10 -0.07 -0.03 +0.02 -0.10 -0.38 -0.42 -0.46  }
{ -0.64 -0.27 -0.23 -0.20 -0.16 -0.15 -0.41 -0.46 -0.51 -0.57  }
{ -0.61 -0.27 -0.23 -0.20 -0.16 -0.15 -0.37 -0.41 -0.47 -0.54  }
{ -0.59 -0.27 -0.24 -0.20 -0.16 -0.15 -0.32 -0.37 -0.43 -0.50  }
{ -0.55 -0.27 -0.23 -0.20 -0.15 -0.15 -0.27 -0.32 -0.39 -0.46  }
{ -0.52 -0.24 -0.22 -0.20 -0.16 -0.15 -0.21 -0.27 -0.34 -0.42  }
Program completed in 11378.59 seconds (pid: 15832).
