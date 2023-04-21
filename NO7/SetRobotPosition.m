function SetRobotPosition(right_foot,left_foot,body)
    
% base_leftLeg_T = [1 0 0 left_X;
%                  0 1 0 Y+yy;
%                  0 0 1 0;
%                  0 0 0 1;];
%              
% right_foot = [1 0 0 right_X;
%                0 1 0 Y;
%              0 0 1 0;
%              0 0 0 1;];
    global Hand_LINK
    global Leg_LINK
    global init 
    if init
        SetupLegDH(right_foot,left_foot);
        SetupHandDH(Leg_LINK(7).T,Leg_LINK(13).T);
        ForwardKinematics();
        init = 0;
        disp("初始化成功");
        return
    end
    
    % Leg_LINK(7).T  当前右腿body在世界坐标系下的位形
    % Leg_LINK(13).T 当前左腿body在世界坐标系下的位形
    
    % Leg_LINK(14).T 右脚在世界坐标系下的位形
    % Leg_LINK(15).T 左脚在世界坐标系下的位形
    
    % Leg_LINK(16).T 为body在世界坐标系下的位形
    
    % Leg_LINK(14).T_inv * Leg_LINK(7).T    左乘上，就相当于在右脚坐标系下的右脚body位形
    Leg_LINK(14).T = right_foot;
    Leg_LINK(15).T = left_foot;
   
    Leg_LINK(14).T_inv= T_inv(Leg_LINK(14).T ); 
    Leg_LINK(15).T_inv= T_inv(Leg_LINK(15).T );   
    
    Leg_LINK(16).T = body;
    
    temp = Leg_LINK(16).A;
    temp(1:3,4) = -1*temp(1:3,4);
    
    % 相对变换
    body_desire_right = Leg_LINK(16).T*temp; 
    temp(1,4) = -1*temp(1,4);
    body_desire_left = Leg_LINK(16).T*temp;

%     % desire = Leg_LINK(14).T_inv*Leg_LINK(7).T
%     right_foot
    desire_right = Leg_LINK(14).T_inv*body_desire_right;
    desire_left = Leg_LINK(15).T_inv*body_desire_left;

    q_right = IK_leg(desire_right)
    q_left = IK_leg(desire_left)
    % 
    for i= 1:6
        if i == 5
            continue;
        end
        if size(q_right,2) == 2
            if q_right(2,1) > q_right(2,2) 
                Leg_LINK(i+1).th = q_right(i,1);
            else
                Leg_LINK(i+1).th = q_right(i,2);
            end
        else
            Leg_LINK(i+1).th = q_right(i);
        end
    end

    for i= 1:6
        if i == 5
            continue;
        end
        if size(q_left,2) == 2
            if q_left(2,1) > q_left(2,2) 
                Leg_LINK(i+7).th = q_left(i,1);
            else
                Leg_LINK(i+7).th = q_left(i,2);
            end
%             Leg_LINK(i+7).th = q_left(i,2);
        else
            Leg_LINK(i+7).th = q_left(i);
        end
    end
    ForwardKinematics();

end