
global Leg_LINK
global test_coordinate

if test_coordinate == 1 
    % r 红色 = x轴
    % g 绿色 = y轴
    % b 蓝色 = z轴
    for n=1:7
        U = Leg_LINK(n).axis;
        Connect3D(U(:,1),U(:,2),'r',2);hold on;
        Connect3D(U(:,1),U(:,3),'g',2);hold on;
        Connect3D(U(:,1),U(:,4),'b',2);hold on;
%         U(:,1)

        grid on;
        axis equal;
        view(170,20);
        pause
    end
end
% % for i=2:7
% %       Connect3D(Leg_link(i-1).p,Leg_link(i).p,'b',2); hold on;
% %       if i > 2
% %         DrawCylinder(Leg_link(i-1).p, Leg_link(i-1).R * Leg_link(i).az, radius,len, joint_col); hold on;
% %       end
% % end
% % for i=8:14
% %       Connect3D(Leg_link(i-1).p,Leg_link(i).p,'b',2); hold on;
% %       if i > 2
% %         DrawCylinder(Leg_link(i-1).p, Leg_link(i-1).R * Leg_link(i).az, radius,len, joint_col); hold on;
% %       end
% % end
% 
% % DrawCylinder([0 10 0]', [0 1 0]', radius,len, joint_col); hold on;
% plotcube([1 1 3],[ 2  2  2],1,[1 0 0]);
% plotcube([5 5 5],[10 10 10],1,[0 1 0]);
% plotcube([2 5 3],[20 20 20],1,[0 0 1]);
% 
% 
% grid on;
% axis equal;
% view(170,20);