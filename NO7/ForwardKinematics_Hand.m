function ForwardKinematics_Hand(j)

global Hand_LINK

if j == 0 
    return; 
end
if j ~= 1
    mom = Hand_LINK(j).mother;
    U = [[0 0 0 1]' [1 0 0 1]' [0 1 0 1]' [0 0 1 1]'];
    Hand_LINK(j).A = Homogeneous_Marix(Hand_LINK(j).th, Hand_LINK(j).dz,Hand_LINK(j).dx,Hand_LINK(j).alf);
    if j == 2 
        T = Hand_LINK(8).T*Hand_LINK(mom).T;
        Hand_LINK(j).T = T * Hand_LINK(j).A;
        Hand_LINK(j).axis =  T*U;
        Hand_LINK(j).p = T*[0 0 0 1]';
    elseif j == 5 
        T = Hand_LINK(9).T*Hand_LINK(mom).T;
        Hand_LINK(j).T = T * Hand_LINK(j).A;
        Hand_LINK(j).axis =  T*U;
        Hand_LINK(j).p = T*[0 0 0 1]';
    else
        
        Hand_LINK(j).T = Hand_LINK(mom).T * Hand_LINK(j).A;
        Hand_LINK(j).axis =  Hand_LINK(mom).T*U;
        Hand_LINK(j).p = Hand_LINK(mom).T*[0 0 0 1]';
    end

end
ForwardKinematics_Hand(Hand_LINK(j).sister);
ForwardKinematics_Hand(Hand_LINK(j).child);
