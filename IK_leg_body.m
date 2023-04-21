function q = IK_leg_body (Target)
    
global Leg_LINK
%     D = 25;
%     A = 58;
%     B = 40;
%     C = 10;
%     
    A = 40;
    B = 32;
    C = 10;

    %目标位置姿态矩阵
    nx=Target(1,1);ox=Target(1,2);ax=Target(1,3);px=Target(1,4);
    ny=Target(2,1);oy=Target(2,2);ay=Target(2,3);py=Target(2,4);
    nz=Target(3,1);oz=Target(3,2);az=Target(3,3);pz=Target(3,4);

%     if oy==0 && ox ==0 && py == 0&& px == 0
%        disp("无解");
%        return
%     end
    

     q1 = atan2(az,ax); 


%     q1 =  pi/2;

%     q6 = atan2((oy*cos(q1)-ox*sin(q1)),-(ny*cos(q1)-nx*sin(q1)));
% 
% 
%     q234 = atan2(-az,ax*cos(q1)+ay*sin(q1));

    q6 = atan2(nx*cos(q1)-nz*sin(q1),ox*cos(q1) -oz*sin(q1));


    solve_fail = 0;
    success = 0;
    iter_q2 = 1;
    q2 = 0;
    n = 0;
    
    
    
    H1 = -ay;
    G1 = C*H1-py;
    
    H2 = az*cos(q1) - ax*sin(q1);
    
    while  success == 0 
        disp("**************计算第n次******************");
        n = n + 1;
        disp(n);
        solution = 0;

        G2 = C*H2-D*sin(q1)-pz*cos(q1)-px*sin(q1)-q2;

        Phi = atan2(G1,G2);

        eta = sqrt(G1^2+G2^2);

        temp = ( G1^2+G2^2+A^2-B^2 )/(2*A*eta);

        q3_1 = atan2(temp,-sqrt(1-temp^2)) - Phi;
        q3_2 = atan2(temp,sqrt(1-temp^2)) - Phi;
        
 
        if q3_1 ~= q3_2
      
            if q3_1 <=  Leg_LINK(3).positive_limit && q3_1 >= Leg_LINK(3).negetive_limit
                q3 = q3_1;
                solution = solution + 1;
            else
                disp("q3_1 不满足");
            end
 
            if q3_2 <=  Leg_LINK(3).positive_limit && q3_2 >= Leg_LINK(3).negetive_limit
                solution = solution  + 1;
                q3 = q3_2;
            else
                disp("q2_2 不满足");
            end
        
        else
            q3 = q3_1;
            if q3 <=  Leg_LINK(3).positive_limit && q3 >= Leg_LINK(3).negetive_limit
                solution = solution + 1;
            else
                disp("q2 不满足");
            end
        end

        if solution  == 0
            solve_fail = 1;
        elseif solution == 1
            disp('只有1组解');
            q34 = atan2(-G2 +A*sin(q3),G1-A*cos(q3)); 
            q4 = q34 -q3;
%             q4 = q234 - q23;
%             if q3 <=  Leg_LINK(4).positive_limit && q3 >= Leg_LINK(4).negetive_limit
%                 if q4 <=  Leg_LINK(5).positive_limit && q4 >= Leg_LINK(5).negetive_limit
%                         q = [q1, q2,q3,q4,q5,q6]';
%                         success = 1;
%                 else
%                     solve_fail = 1;
%                     disp("q4 不满足");
%                 end   
%             else
%                 solve_fail = 1;
%                 disp("q3 不满足");
%             end
        elseif solution == 2
            disp('有2组解');
            solution1 = 1;
            q34_1 = atan2(-G2 +A*sin(q3_1),G1-A*cos(q3_1));   
            q4_1 = q34_1 -q3_1;
            q4_1 = q234 - q23_1;
            if q3_1 <=  Leg_LINK(4).positive_limit && q3_1 >= Leg_LINK(4).negetive_limit
                if q4_1 <=  Leg_LINK(5).positive_limit && q4_1 >= Leg_LINK(5).negetive_limit
                    q_1 = [q1, q2_1,q3_1,q4_1,q5,q6]';
                else
                    solution1 = 0;
                    disp("q4_1 不满足");
                end 
            else
                    solution1 = 0;
                    disp("q3_1 不满足");
            end

            solution2 = 1;
            q23_2 = atan2(H2 -B*sin(q3_2),H1-B*cos(q3_2));

            q3_2 = q23_2 -q3_2;
            q4_2 = q234 - q23_2;
            if q3_2 <=  Leg_LINK(4).positive_limit && q3_2 >= Leg_LINK(4).negetive_limit
                if q4_2 <=  Leg_LINK(5).positive_limit && q4_2 >= Leg_LINK(5).negetive_limit
                    q_2 = [q1, q3_2,q3_2,q4_2,q5,q6]';
                else
                    solution2 = 0;
                    disp("q4_2 不满足");
                end
            else
                    solution2 = 0;
                    disp("q3_2 不满足");
            end 

            if solution1 || solution2
                if solution1 == 1 && solution2 ==1
                    disp('@ 2组解可行');
                    q = [q_1 q_2];
                    success = 1;
                elseif solution1 == 1
                    disp('@ q_1组解可行');
                    q = q_1;
                    success = 1;
                else
                    disp('@ q_2组解可行');
                    q = q_2;
                    success = 1;
                end
            else
                 solve_fail = 1;
            end          
        end

        if solve_fail == 1
           if q5 <  Leg_LINK(6).positive_limit
                q5 = q5 + iter_q5;
                solve_fail = 0;
           else
                success = -1;
           end
        end


    end

    if success == -1
        q = -1;
        disp('求解出错,无解');
    else
        disp('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
        disp('求解成功');
        disp(q);
    end
end