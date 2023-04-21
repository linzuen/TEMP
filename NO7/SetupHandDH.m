function SetupHandDH(base_rightT,base_leftT)

    global Hand_LINK

    upperlimb_lenth = 80; % A
    shoulder_lengh = 10;  % B
    arm_lengh = 50;       % C
    hand_lengh = 40;      % D

    % 手臂的左右分布，通过shoulder_lengh的正负确定，与腿部不一样，因为可以通过腿的坐标推导
    Hand_LINK   = struct('name','BODY' ,'th',  0, 'dz', 0, 'dx', 0, 'alf',0,'mother',0,'sister', 0, 'child', 2);

    Hand_LINK(2)   = struct('name','RHAND_J1' ,'th',  deg2rad(-90), 'dz', shoulder_lengh, 'dx', 0, 'alf',deg2rad(-90),'mother',1,'sister', 5, 'child', 3);
    Hand_LINK(3)   = struct('name','RHAND_J2' ,'th',  deg2rad(0), 'dz', 0, 'dx', arm_lengh, 'alf',deg2rad(90),'mother',2,'sister', 0, 'child', 4);
    Hand_LINK(4)   = struct('name','RHAND_J3' ,'th',  deg2rad(0), 'dz', 0, 'dx', hand_lengh, 'alf',0,'mother',3,'sister', 0, 'child', 0);

    Hand_LINK(5)    = struct('name','LHAND_J1' ,'th',  deg2rad(-90), 'dz', -shoulder_lengh, 'dx', 0, 'alf',deg2rad(-90),'mother',1,'sister', 0, 'child', 6);
    Hand_LINK(6)    = struct('name','LHAND_J2' ,'th',  deg2rad(0), 'dz', 0, 'dx', arm_lengh, 'alf',deg2rad(0),'mother',5,'sister', 0, 'child', 7);
    Hand_LINK(7)   = struct('name','LHAND_J3' ,'th',  deg2rad(0), 'dz', 0, 'dx', hand_lengh, 'alf',0,'mother',6,'sister', 0, 'child', 0);

    Hand_LINK(8)    = struct('name','HAND_right_base' ,'th',  0, 'dz', 0, 'dx', 0, 'alf',0,'mother',0,'sister', 0, 'child', 0);
    Hand_LINK(9)    = struct('name','HAND_left_base' ,'th',  0, 'dz', 0, 'dx', 0, 'alf',0,'mother',0,'sister', 0, 'child', 0);
    
    T = [0 0 1 0;
          1 0 0 0;
          0 1 0 upperlimb_lenth;
          0 0 0 1;];

    Hand_LINK(8).T = base_rightT*T;
    temp = Hand_LINK(8).T(1:3,1:3);
    Hand_LINK(8).T_inv= [temp' -temp'*Hand_LINK(8).T(1:3,4);
              0 0 0 1];      
          
    Hand_LINK(9).T = base_leftT*T;
    temp = Hand_LINK(9).T(1:3,1:3);
    Hand_LINK(9).T_inv= [temp' -temp'*Hand_LINK(9).T(1:3,4);
              0 0 0 1];     

    Hand_LINK(1).T = [1 0 0 0;
                      0 1 0 0;
                      0 0 1 0;
                      0 0 0 1;];

    Hand_LINK(1).A = Hand_LINK(1).T;             
    Hand_LINK(1).p = Hand_LINK(8).T(:,4);
    U = [[0 0 0 1]' [1 0 0 1]' [0 1 0 1]' [0 0 1 1]'];

    Hand_LINK(1).axis = Hand_LINK(8).T *U;
    
    Hand_LINK(1).p = Hand_LINK(8).T(:,4);
    U = [[0 0 0 1]' [1 0 0 1]' [0 1 0 1]' [0 0 1 1]'];

    Hand_LINK(1).axis = Hand_LINK(8).T *U;
    
    ForwardKinematics_Hand(1);
    % Add_joint_limit;

end
