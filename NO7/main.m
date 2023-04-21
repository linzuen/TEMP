
clear;
global Hand_LINK
global Leg_LINK

global test_coordinate
global init 
init = 1;
test_coordinate =0;

hip_lenth = 25;

left_X = 10;
right_X = left_X + 2* hip_lenth;
Y = 10 ;

yy = 0;
base_leftLeg_T = [1 0 0 left_X;
                 0 1 0 Y;
                 0 0 1 0;
                 0 0 0 1;];
             
base_rightLeg_T = [1 0 0 right_X;
                 0 1 0 Y;
                 0 0 1 0;
                 0 0 0 1;];
SetRobotPosition(base_rightLeg_T,base_leftLeg_T,"初始化");

% 
% hand_desire_right = Hand_LINK(4).T;
% hand_desire_right(3,4) = Hand_LINK(4).T(3,4) +20;
% handdesire_right = Hand_LINK(8).T_inv*hand_desire_right;
% 
% qhand_right = IK_hand(handdesire_right)
% for i= 1:3
% %     if i == 5
% %         continue;
% %     end
%     Hand_LINK(i+1).th = qhand_right(i);
% end
cla;
base_leftLeg_T_2 = [1 0 0 left_X;
                 0 1 0 Y+yy;
                 0 0 1 0;
                 0 0 0 1;];

base_rightLeg_T_2 = base_rightLeg_T;

temp = Leg_LINK(16).T;  
temp(3,4) = temp(3,4) - 20; %10

body = temp;

figure(1)
grid on;
hold on;
view(170,20);
axis([-50 350 -50 350 0 300]);
DrawBody(0);

gait = GenerateGait();

% body_Y = gait(:,2);
% Rright_leg_Y  = gait(:,4);
% Left_leg_Y  = gait(:,7);
% 
% Rright_leg_Z = gait(:,6);
% Left_leg_Z = gait(:,9);
body_X = round(gait(:,3));
body_Y = round(gait(:,2)) + 8*ones(size(gait,1),1);
Rright_leg_Y  = round(gait(:,4));
Left_leg_Y  = round(gait(:,7));

Rright_leg_Z = round(gait(:,6));
Left_leg_Z = round(gait(:,9));
body_Y = Rright_leg_Y+ 2*ones(size(gait,1),1);
%     SetRobotPosition(base_rightLeg_T_2,base_leftLeg_T_2,temp); 
% DrawBody(0);
% pause;
for i = 1:length(gait(:,1))
    temp(2,4) = body(2,4) + body_Y(i);
    temp(1,4) = body(1,4)+ body_X(i);
    base_rightLeg_T_2(2,4) = base_rightLeg_T(2,4) + Rright_leg_Y(i);
    base_rightLeg_T_2(3,4) = base_rightLeg_T(3,4) + Rright_leg_Z(i);
    
    base_leftLeg_T_2(2,4) = base_leftLeg_T(2,4) + Left_leg_Y(i);
    base_leftLeg_T_2(3,4) = base_leftLeg_T(3,4) + Left_leg_Z(i);
    
    SetRobotPosition(base_rightLeg_T_2,base_leftLeg_T_2,temp); 
    cla;
    DrawBody(0);
end

%     temp(3,4) = temp(3,4) -30        
%     SetRobotPosition(base_rightLeg_T,base_leftLeg_T_2,temp);
% DrawBody(0);
% tmp = Leg_LINK(14).T_inv* Leg_LINK(7).T;
% error_p = desire_right(1:3,4) -tmp(1:3,4);
% error_r = tmp(1:3,1:3)'*desire_right(1:3,1:3);
% 
% tmp = Leg_LINK(15).T_inv* Leg_LINK(13).T;
% error_p = desire_left(1:3,4) -tmp(1:3,4);
% error_r = tmp(1:3,1:3)'*desire_left(1:3,1:3);

% R = Leg_LINK(7).T(1:3,1:3);
% rpy  = RotMatToRPY(R);


test_DH();