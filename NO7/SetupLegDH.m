

function SetupLegDH(base_right_T,base_left_T)
UX=[1 0 0 1]';
UY=[0 1 0 1]';
UZ=[0 0 1 1]';

global Leg_LINK

% hip_lenth = 25;
thigh_lengh = 40;
shank_lengh = 32;
ankle_lengh = 10;

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

Leg_LINK(16)    = struct('name','body_base' ,'th',  0, 'dz', 0, 'dx', 0, 'alf',0,'mother',0,'sister', 0, 'child', 0);
%     body_base = Leg_LINK(7).T;
%     body_base(1:3,4) = body_base(1:3,4)- [25,0 0]';

% 
Leg_LINK(14).T = base_right_T;
Leg_LINK(14).T_inv= T_inv(Leg_LINK(14).T ); 
      
Leg_LINK(15).T = base_left_T;
Leg_LINK(15).T_inv= T_inv(Leg_LINK(15).T );   

Leg_LINK(1).T = [1 0 0 0;
                 0 1 0 0;
                 0 0 1 ankle_lengh;
                 0 0 0 1;];
Leg_LINK(1).A = Leg_LINK(1).T;             
Leg_LINK(1).p = Leg_LINK(14).T(:,4);
U = [[0 0 0 1]' UX UY UZ];
Leg_LINK(1).axis = U;

Add_joint_limit();

ForwardKinematics_Leg(1);
end
