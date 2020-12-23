global A B L
A=  1;
B= -1;
L=[0.7 0.5 0.3 0.2 0.5]';
xy = [0.2 0.4 0.6 0.8 ...
      -1.0 -1.5 -1.5 -1.3 ]';

lm= [0.5077 0.4223 ...
0.5190 0.6156 0.8774]';      


v=[0.01 0.01];
options.tol=v;
options.maxit=14; 

[xy,lm,info] = optimiseur('simulateur',xy,lm,options);
