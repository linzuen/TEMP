function q = IK_hand(Target)
    
% global Leg_LINK
%     
    A = 80;
    B = 10;
    C = 50;
    D = 40;
      
    %目标位置姿态矩阵
    nx=Target(1,1);ox=Target(1,2);ax=Target(1,3);px=Target(1,4);
    ny=Target(2,1);oy=Target(2,2);ay=Target(2,3);py=Target(2,4);
    nz=Target(3,1);oz=Target(3,2);az=Target(3,3);pz=Target(3,4);

%     if az==0 && ay ==0 
%        disp("无解");
%        return
%     end
    
    q1 = atan2(ay,ax);
    q1 = -pi/2;
%     
% A1 = [cos(q1) 0 -sin(q1) 0;
%       sin(q1) 0 cos(q1) 0;
%       0 -1 0 B;
%       0 0 0 1;];    
% R1 = A1(1:3,1:3);
% A1_inv = [R1' -R1'*A1(1:3,4);
%           0 0 0 1];
% Target = A1_inv*Target;
      
    %目标位置姿态矩阵
% nx=Target(1,1);ox=Target(1,2);ax=Target(1,3);px=Target(1,4);
% ny=Target(2,1);oy=Target(2,2);ay=Target(2,3);py=Target(2,4);
% nz=Target(3,1);oz=Target(3,2);az=Target(3,3);pz=Target(3,4);
%     q1 = -pi/2;
%     
%     C2C3 = ny*cos(q1)+nz*sin(q1);
%     S2C3 = -nx;
%     q2 = atan2(py*cos(q1) - A*sin(q1) + pz*sin(q1) - D*C2C3,B-px-D*S2C3);
%     
%     q3 = atan2(nz*cos(q1)-ny*sin(q1),oz*cos(q1)-oy*sin(q1));
    q2 = atan2(ax*cos(q1) + ay*sin(q1),az);
    q3  = asin( (py*cos(q1) - px*sin(q1)) /D);

% &
    
%     E = sqrt((px^2 + py^2+ (pz - B)^2));
%     
%     q3_1 = pi - acos( (C^2+D^2 - E^2) / (2*C*D) );
%     q3_2 = -pi + acos( (C^2+D^2 - E^2) / (2*C*D) );
%     
%     q2 = atan2(py*cos(q1) - A*sin(q1) + pz*sin(q1) - D*C2C3,B-px-D*S2C3);
    

    
    q = [q1 q2 q3]';
    
%     q_2 = [q1 q2 q3_1]'

    disp('&&&&&&&&&&&&&&&手部逆解求解成功&&&&&&&&&&&&&&&&&&&&&&');

    disp(q);
end