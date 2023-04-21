function ForwardKinematics_Leg(j)
global Leg_LINK

if j == 0 
    return; 
end
if j ~= 1
    mom = Leg_LINK(j).mother;
%     if j == 8 
%         if sign(Leg_LINK(mom).T(1,4)) == 1
%             Leg_LINK(mom).T(1,4) = -1*Leg_LINK(mom).T(1,4);
%         end
%     end
%     if j == 2 
%         if sign(Leg_LINK(mom).T(1,4)) == -1
%             Leg_LINK(mom).T(1,4) = -1*Leg_LINK(mom).T(1,4);
%         end
%     end
    Leg_LINK(j).A = Homogeneous_Marix(Leg_LINK(j).th, Leg_LINK(j).dz,Leg_LINK(j).dx,Leg_LINK(j).alf);
    if j == 8 
        T = Leg_LINK(15).T*Leg_LINK(mom).T;
        Leg_LINK(j).T = T * Leg_LINK(j).A;
        Leg_LINK(j).axis =  T*Leg_LINK(1).axis;
        Leg_LINK(j).p = T*[0 0 0 1]';
    elseif j == 2 
        T = Leg_LINK(14).T*Leg_LINK(mom).T;
        Leg_LINK(j).T = T * Leg_LINK(j).A;
        Leg_LINK(j).axis =  T*Leg_LINK(1).axis;
        Leg_LINK(j).p = T*[0 0 0 1]';
    else
        
        Leg_LINK(j).T = Leg_LINK(mom).T * Leg_LINK(j).A;
        Leg_LINK(j).axis =  Leg_LINK(mom).T*Leg_LINK(1).axis;
        Leg_LINK(j).p = Leg_LINK(mom).T*[0 0 0 1]';
    end
%     Leg_LINK(j).A = Homogeneous_Marix(Leg_LINK(j).th, Leg_LINK(j).dz,Leg_LINK(j).dx,Leg_LINK(j).alf);
%     Leg_LINK(j).T = Leg_LINK(mom).T * Leg_LINK(j).A;
%     Leg_LINK(j).axis =  Leg_LINK(mom).T*Leg_LINK(1).axis;
%     
%     Leg_LINK(j).p = Leg_LINK(mom).T*[0 0 0 1]';
end
ForwardKinematics_Leg(Leg_LINK(j).sister);
ForwardKinematics_Leg(Leg_LINK(j).child);
