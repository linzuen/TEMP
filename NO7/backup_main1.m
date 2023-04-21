
clear;
global Hand_LINK
global Leg_LINK

global test_coordinate
test_coordinate =0;

hip_lenth = 25;

left_X = 10;
right_X = left_X + 2* hip_lenth;
Y = 10 ;

yy = 40;
base_leftLeg_T = [1 0 0 left_X;
                 0 1 0 Y+yy;
                 0 0 1 0;
                 0 0 0 1;];
             
base_rightLeg_T = [1 0 0 right_X;
                 0 1 0 Y;
                 0 0 1 0;
                 0 0 0 1;];
SetupLegDH(base_rightLeg_T,base_leftLeg_T);
% Leg_LINK(7).T
% Leg_LINK(13).T
SetupHandDH(Leg_LINK(7).T,Leg_LINK(13).T);

figure(1)
ForwardKinematics();
DrawBody(0);
grid on;
axis equal;
view(170,20);
pause
cla;

hand_desire_right = Hand_LINK(4).T;
% hand_desire_right(3,4) = Hand_LINK(4).T(3,4) +20;
handdesire_right = Hand_LINK(8).T_inv*hand_desire_right;

qhand_right = IK_hand(handdesire_right)
for i= 1:3
%     if i == 5
%         continue;
%     end
    Leg_LINK(i+1).th = qhand_right(i);
end

body_desire_right = Leg_LINK(7).T;
body_desire_right(3,4) = Leg_LINK(7).T(3,4) -30;

body_desire_left = Leg_LINK(13).T;
body_desire_left(2,4) = Leg_LINK(13).T(2,4) - yy;
body_desire_left(3,4) = Leg_LINK(13).T(3,4) -30;

% desire = Leg_LINK(14).T_inv*Leg_LINK(7).T
desire_right = Leg_LINK(14).T_inv*body_desire_right;
desire_left = Leg_LINK(15).T_inv*body_desire_left;

q_right = IK_leg(desire_right)
q_left = IK_leg(desire_left)
% 
for i= 1:6
    if i == 5
        continue;
    end
    Leg_LINK(i+1).th = q_right(i);
end

for i= 1:6
    if i == 5
        continue;
    end
    Leg_LINK(i+7).th = q_left(i);
end
ForwardKinematics();
% 
figure(1)
DrawBody(0);

tmp = Leg_LINK(14).T_inv* Leg_LINK(7).T;
error_p = desire_right(1:3,4) -tmp(1:3,4);
error_r = tmp(1:3,1:3)'*desire_right(1:3,1:3);

tmp = Leg_LINK(15).T_inv* Leg_LINK(13).T;
error_p = desire_left(1:3,4) -tmp(1:3,4);
error_r = tmp(1:3,1:3)'*desire_left(1:3,1:3);

% R = Leg_LINK(7).T(1:3,1:3);
% rpy  = RotMatToRPY(R);


grid on;
axis equal;
view(170,20);

test_DH();