function A = Homogeneous_Marix(th,dz,dx,alf)

    C=cos(th);
    S=sin(th);
    Ca=cos(alf);
    Sa=sin(alf);
    
    A=[C,-1*S*Ca,S*Sa,dx*C;
       S,C*Ca,-1*C*Sa,dx*S;
       0,Sa,Ca, dz;
       0 0 0 1];