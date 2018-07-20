clear;
syms x;
ee=eval(solve('-x*3.14/(sqrt(1-x*x))-log(0.05)=0','x'));
wn=eval(solve('pi/(x*sqrt(1-ee*ee))-0.5=0','x'));
w = 0;
r1real = -ee*wn;
r1fail = wn*sqrt(1-ee*ee);
r2real = -ee*wn;
r2fail = -wn*sqrt(1-ee*ee);
Afarward = [-110.2424 0 200.9966 0;
    0 -110.2424 0 200.9966;
    107.1489 0 -206.7995 0;
    0 107.1489 0 -206.7995];
Anon = [0 17.0724 0 17.5653;
        -17.0724 0 -17.5653 0;
        0 -17.5653 0 -18.0742;
        17.5653 0 18.0742 0];
A = Afarward + Anon*w;
B = [253.4307 0;
    0 253.4307;
    -264.3194 0;
    0 -246.3194];
C = [1 0 0 0;
    0 1 0 0];
A1 = A';
C1 = C';
p = [-240 -180 6*(r1real+r1fail*i) 6*(r2real+r2fail*i)];
k = place(A,B,p);
G1 = place(A1,C1,p')
G = G1'

