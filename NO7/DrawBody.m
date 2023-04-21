
function DrawBody(fcla)

    global Leg_LINK
% 
%     figure(1)
    DrawLeg(1);
    DrawHand(1);
    body_base = Leg_LINK(16).T;
    temp_t =[1 0 0 -5;
           0 1 0 -5;
           0 0 1 5;
           0 0 0 1];
    temp_t =   Leg_LINK(13).T*temp_t;
    plotcube([60 11 82],temp_t(1:3,4)',0.8,[1,0.8,0.58]); 
    
    temp = Leg_LINK(1).axis*10;
    temp(4,:) = [1 1 1 1];
    U = body_base*(temp);
    
    Connect3D(U(:,1),U(:,2),'r',2);
    Connect3D(U(:,1),U(:,3),'g',2);
    Connect3D(U(:,1),U(:,4),'b',2);
    view(170,20);
    drawnow 
    if fcla
       cla;
    end
    
    
end 