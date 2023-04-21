global Leg_LINK
global Hand_LINK

ForwardKinematics_Leg(1);
Leg_LINK(16).A = [1 0 0 -25;
                  0 1 0 0;
                  0 0 1 5;
                  0 0 0 1];
% 变换到body的基 相对变换
Leg_LINK(16).T = Leg_LINK(7).T *Leg_LINK(16).A;
% Leg_LINK(16).T = Leg_LINK(7).T;
% Leg_LINK(16).T(1:3,4) = Leg_LINK(16).T(1:3,4)- [25,0 -5]';


% 更新手部的基坐标系
T = [0 0 1 0;
     1 0 0 0;
     0 1 0 80;
     0 0 0 1;];
Hand_LINK(8).T = Leg_LINK(7).T*T;
Hand_LINK(9).T = Leg_LINK(13).T*T;
ForwardKinematics_Hand(1);

