function DrawHand(j)
global Hand_LINK
radius    = 5;
len       = 10;
joint_col = 0;
if j == 0 
    return; 
end
if j ~= 1
     mom = Hand_LINK(j).mother;
     
     if j == 2 
        
     elseif j == 5
         
     else
         Connect3D(Hand_LINK(mom).p(1:3),Hand_LINK(j).p(1:3),'b',2);
     end
    if j == 4 
%         Connect3D(Hand_LINK(8).T(1:3,4),Hand_LINK(j).p(1:3),'b',2); hold on;
        p = Hand_LINK(j).T(1:3,4);
        Connect3D(Hand_LINK(j).T(1:3,4),Hand_LINK(j).p(1:3),'b',2);
        [x,y,z]  = ellipsoid(p(1),p(2),p(3),4,4,4);
        surf(x,y,z);
%         plotcube([8 10 2],Leg_LINK(15).T(1:3,4)'-[4 5 0],1,[0 1 0]);
    elseif j == 7 
        p = Hand_LINK(j).T(1:3,4);
        [x,y,z]  = ellipsoid(p(1),p(2),p(3),4,4,4);
        surf(x,y,z);
        Connect3D(Hand_LINK(j).T(1:3,4),Hand_LINK(j).p(1:3),'b',2);
        
    end
%     Connect3D(Hand_LINK(mom).p(1:3),Hand_LINK(j).p(1:3),'b',2); hold on;
    DrawCylinder(Hand_LINK(j).p, Hand_LINK(j).axis(1:3,4) - Hand_LINK(j).axis(1:3,1), radius,len, joint_col);

end
DrawHand(Hand_LINK(j).sister);
DrawHand(Hand_LINK(j).child);

