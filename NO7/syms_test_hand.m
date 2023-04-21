clear;

% syms cos3 sin3 cos4 sin4;
% 
% syms Ry Rx;
% Ry = [cos3 0 sin3;
%      0 1 0;
%      -sin3 0 cos3]
%  
%  Rx = [1 0 0;
%       0 cos4 -sin4;
%       0 sin4 cos4]
%   
%  Ry*Rx
 
 syms A B C D;
 
 syms C1 C2 C3 C4 C5 C6 C7;
 syms S1 S2 S3 S4 S5 S6 S7;
 
 syms q1 q2 q3 q4 q5 q6;


 syms T1 T2 T3 T4 T5 T6 T7
 
 UX=[1 0 0 1]';
 UY=[0 1 0 1]';
 UZ=[0 0 1 1]';
 
A0 = [1 0 0 0;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1;];
  
A1 = [C1 0 -S1 0;
      S1 0 C1 0;
      0 -1 0 B;
      0 0 0 1;];
 
A2 =[C2  0 S2  C*C2;
     S2  0 -C2  C*S2;
     0 1 0 0;
     0 0 0 1;];

A3 =[C3 -S3 0 D*C3;
     S3 C3 0 D*S3;
     0 0 1 0;
     0 0 0 1;];
   
   
T_e = A0*A1*A2*A3;

syms n_x n_y n_z o_x o_y o_z  a_x a_y a_z 
syms p_x p_y p_z

% n_x = T_e(1,1);
% n_y = T_e(2,1);
% n_z = T_e(3,1);
% 
% o_x = T_e(1,2);
% o_y = T_e(2,2);
% o_z = T_e(3,2);
% 
% a_x = T_e(1,3);
% a_y = T_e(2,3);
% a_z = T_e(3,3);
% 
% p_x = T_e(1,4);
% p_y = T_e(2,4);
% p_z = T_e(3,4);

T_ea = [n_x o_x a_x p_x;
       n_y o_y a_y p_y;
       n_z o_z a_z p_z;
       0 0 0 1];

%% 

R0 = A0(1:3,1:3);
A0_inv = [R0' -R0'*A0(1:3,4);
          0 0 0 1];
R1 = A1(1:3,1:3);
A1_inv = [R1' -R1'*A1(1:3,4);
          0 0 0 1];
R2 = A2(1:3,1:3);
A2_inv = [R2' -R2'*A2(1:3,4);
          0 0 0 1];

R3 = A3(1:3,1:3);
A3_inv = [R3' -R3'*A3(1:3,4);
          0 0 0 1];
      
% TEMP = A0_inv*T_ea
% 
% right = A1*A2*A3*A4*A5*A6

TEMP = A1_inv*A0_inv*T_ea

right = A2*A3

      
% TEMP = A2_inv*A1_inv*A0_inv*T_ea
% 
% right = A3*A4*A5*A6
% 
% gg = A0*A1*A2

      
% TEMP = A0_inv*T_ea*A6_inv
% 
% right = A1*A2*A3*A4*A5


% TEMP = A3_inv*A2_inv*A1_inv*A0_inv*T_ea
% 
% right = A4*A5*A6



% grid on;
% axis equal;
% view(170,20);

