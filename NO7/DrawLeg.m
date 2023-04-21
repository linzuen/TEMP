function DrawLeg(j)
global Leg_LINK
radius    = 5;
len       = 10;
joint_col = 0;
if j == 0 
    return; 
end
if j ~= 1
%     figure(1);
    mom = Leg_LINK(j).mother;
    if j == 8 
        Connect3D(Leg_LINK(15).T(1:3,4),Leg_LINK(j).p(1:3),'b',2); 
        plotcube([8 10 2],Leg_LINK(15).T(1:3,4)'-[4 5 0],1,[0 1 0]);
    elseif j == 2 
        Connect3D(Leg_LINK(14).T(1:3,4),Leg_LINK(j).p(1:3),'b',2);
        plotcube([8 10 2],Leg_LINK(14).T(1:3,4)'-[4 5 0],1,[0 1 0]);
    else
        Connect3D(Leg_LINK(mom).p(1:3),Leg_LINK(j).p(1:3),'b',2);
    end
   
    DrawCylinder(Leg_LINK(j).p, Leg_LINK(j).axis(1:3,4) - Leg_LINK(j).axis(1:3,1), radius,len, joint_col);  
%     drawnow;
end
DrawLeg(Leg_LINK(j).sister);
DrawLeg(Leg_LINK(j).child);

