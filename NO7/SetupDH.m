clear;
UX=[1 0 0 1]';
UY=[0 1 0 1]';
UZ=[0 0 1 1]';

global test_coordinate
test_coordinate =0;

global Leg_LINK

hip_lenth = 25;

thigh_lengh = 58;
shank_lengh = 40;
ankle_lengh = 10;

left_X = 10;
right_X = left_X + 2* hip_lenth;
Y = 10 ;

Leg_LINK   = struct('name','BODY' ,'th',  0, 'dz', 0, 'dx', 0, 'alf',0,'mother',0,'sister', 0, 'child', 2);

Leg_LINK(2)   = struct('name','RLEG_J1' ,'th',  deg2rad(90), 'dz', 0, 'dx', 0, 'alf',deg2rad(-90),'mother',1,'sister', 8, 'child', 3);
Leg_LINK(3)   = struct('name','RLEG_J2' ,'th',  deg2rad(-90), 'dz', 0, 'dx', shank_lengh, 'alf',deg2rad(0),'mother',2,'sister', 0, 'child', 4);
Leg_LINK(4)   = struct('name','RLEG_J3' ,'th',  deg2rad(0), 'dz', 0, 'dx', thigh_lengh, 'alf',0,'mother',3,'sister', 0, 'child', 5);
Leg_LINK(5)   = struct('name','RLEG_J4' ,'th',  deg2rad(90), 'dz', 0, 'dx', 0, 'alf',deg2rad(90),'mother',4,'sister', 0, 'child', 6);
Leg_LINK(6)   = struct('name','RLEG_J5' ,'th',  deg2rad(-90), 'dz', 0, 'dx',  0, 'alf',deg2rad(-90),'mother',5,'sister', 0, 'child', 7);
Leg_LINK(7)   = struct('name','RLEG_J6' ,'th',  0, 'dz',0, 'dx', 0, 'alf',deg2rad(90),'mother',6,'sister', 0, 'child', 0);


Leg_LINK(8)    = struct('name','LLEG_J1' ,'th',  deg2rad(90), 'dz', 0, 'dx', 0, 'alf',deg2rad(-90),'mother',1,'sister', 0, 'child', 9);
Leg_LINK(9)    = struct('name','LLEG_J2' ,'th',  deg2rad(-90), 'dz', 0, 'dx', shank_lengh, 'alf',deg2rad(0),'mother',8,'sister', 0, 'child', 10);
Leg_LINK(10)   = struct('name','LLEG_J3' ,'th',  deg2rad(0), 'dz', 0, 'dx', thigh_lengh, 'alf',0,'mother',9,'sister', 0, 'child', 11);
Leg_LINK(11)   = struct('name','LLEG_J4' ,'th',  deg2rad(90), 'dz', 0, 'dx', 0, 'alf',deg2rad(90),'mother',10,'sister', 0, 'child', 12);
Leg_LINK(12)   = struct('name','LLEG_J5' ,'th',  deg2rad(-90), 'dz', 0, 'dx', 0, 'alf',deg2rad(-90),'mother',11,'sister', 0, 'child', 13);
Leg_LINK(13)   = struct('name','LLEG_J6' ,'th',  0, 'dz', 0, 'dx', 0, 'alf',deg2rad(90),'mother',12,'sister', 0, 'child', 0);

Leg_LINK(14)    = struct('name','right_base' ,'th',  0, 'dz', 0, 'dx', 0, 'alf',0,'mother',0,'sister', 0, 'child', 0);
Leg_LINK(15)    = struct('name','left_base' ,'th',  0, 'dz', 0, 'dx', 0, 'alf',0,'mother',0,'sister', 0, 'child', 0);

% 
Leg_LINK(14).T = [1 0 0 right_X;
                 0 1 0 Y;
                 0 0 1 0;
                 0 0 0 1;];
temp = Leg_LINK(14).T(1:3,1:3);
yy = 40;

Leg_LINK(14).T_inv= [temp' -temp'*Leg_LINK(14).T(1:3,4);
          0 0 0 1];             
Leg_LINK(15).T = [1 0 0 left_X;
                 0 1 0 Y+yy;
                 0 0 1 0;
                 0 0 0 1;];
temp = Leg_LINK(15).T(1:3,1:3);
Leg_LINK(15).T_inv= [temp' -temp'*Leg_LINK(15).T(1:3,4);
          0 0 0 1];       

Leg_LINK(1).T = [1 0 0 0;
                 0 1 0 0;
                 0 0 1 ankle_lengh;
                 0 0 0 1;];
% Leg_LINK(1).T =   T_word_right*Leg_LINK(1).T;     
             
Leg_LINK(1).A = Leg_LINK(1).T;             
Leg_LINK(1).p = Leg_LINK(14).T(:,4);
U = [[0 0 0 1]' UX UY UZ];

% U = Leg_LINK(1).T*U;
Leg_LINK(1).axis = U;

Add_joint_limit;

ForwardKinematics(1);
figure(1)

%% 测试通过
test;

%%
% DrawBody(0);
% DrawRobot(1);
% Connect3D(Leg_LINK(7).T(1:3,4),Leg_LINK(7).T(1:3,4)- [hip_lenth,0 0]','R',2); hold on;

% plotcube([8 10 2],Leg_LINK(7).T(1:3,4)'-[4 5 0],1,[0 1 0]);

% Connect3D(Leg_LINK(13).p(1:3),Leg_LINK(13).T(1:3,4),'R',2); hold on;
% plotcube([8 10 2],Leg_LINK(13).T(1:3,4)'-[4 5 0],1,[0 1 0]);

% for i= 2:7
%     p_origin(i-1) = Leg_LINK(i).th;
% end
% p_origin =  p_origin'
% origin = Leg_LINK(7).T

% 
% qf = [pi/2 -pi/2 0 pi/2 -pi/2 0]'
% % qf = [pi/2 -pi/3 0 pi/6 -pi/5 pi/4]'
% for i= 2:7
%     if i == 6
%         continue;
%     end
%     Leg_LINK(i).th = qf(i-1);
% end
% ForwardKinematics(1);
% 
% 
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
ForwardKinematics(1);
% 
DrawBody(0);

% Connect3D(Leg_LINK(7).p(1:3),Leg_LINK(7).T(1:3,4),'R',2); hold on;
% 
tmp = Leg_LINK(14).T_inv* Leg_LINK(7).T;
error_p = desire_right(1:3,4) -tmp(1:3,4)
error_r = tmp(1:3,1:3)'*desire_right(1:3,1:3)

tmp = Leg_LINK(15).T_inv* Leg_LINK(13).T;
error_p = desire_left(1:3,4) -tmp(1:3,4)
error_r = tmp(1:3,1:3)'*desire_left(1:3,1:3)

R = Leg_LINK(7).T(1:3,1:3);
rpy  = RotMatToRPY(R);
% test_coordinate =1;
% figure(2);
% test;
% 
% Leg_LINK(3).p(1:3)
% Leg_LINK(6).T(1:3,4)

% Connect3D(Leg_LINK(3).p(1:3),Leg_LINK(6).T(1:3,4),'g',2); hold on;
%     U = Leg_LINK(3).axis;
%     Connect3D(U(:,1),U(:,2),'r',2);hold on;
%     Connect3D(U(:,1),U(:,3),'g',2);hold on;
%     Connect3D(U(:,1),U(:,4),'b',2);hold on;
% plotcube([8 10 2],Leg_LINK(7).T(1:3,4)'-[4 5 0],1,[0 1 0]);

% Connect3D(Leg_LINK(13).p(1:3),Leg_LINK(13).T(1:3,4),'R',2); hold on;
% plotcube([8 10 2],Leg_LINK(13).T(1:3,4)'-[4 5 0],1,[0 1 0]);

grid on;
axis equal;
view(170,20);
