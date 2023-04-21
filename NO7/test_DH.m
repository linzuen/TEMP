
global Hand_LINK
global Leg_LINK
global test_coordinate

if test_coordinate == 1
    
    disp("#########手部DH")
    figure(2)
    % r 红色 = x轴
    % g 绿色 = y轴
    % b 蓝色 = z轴
    for n=1:7
        U = Hand_LINK(n).axis;
        Connect3D(U(:,1),U(:,2),'r',2);hold on;
        Connect3D(U(:,1),U(:,3),'g',2);hold on;
        Connect3D(U(:,1),U(:,4),'b',2);hold on;
%       U(:,1)

        grid on;
        axis equal;
        view(170,20);
        pause
    end
    disp("#########腿部DH")
    figure(3)
    for n=1:13
        U = Leg_LINK(n).axis;
        Connect3D(U(:,1),U(:,2),'r',2);hold on;
        Connect3D(U(:,1),U(:,3),'g',2);hold on;
        Connect3D(U(:,1),U(:,4),'b',2);hold on;
%       U(:,1)
        grid on;
        axis equal;
        view(170,20);
        pause
    end

    
end