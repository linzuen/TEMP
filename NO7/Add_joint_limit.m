global Leg_LINK

%% JOINT1
Leg_LINK(2).positive_limit = deg2rad(180);
Leg_LINK(2).negetive_limit = deg2rad(-180);
%% JOINT2
Leg_LINK(3).positive_limit = deg2rad(360);
Leg_LINK(3).negetive_limit = deg2rad(-360); % -130
%% JOINT3
Leg_LINK(4).positive_limit = deg2rad(360);
Leg_LINK(4).negetive_limit = deg2rad(-360); % -160
%% JOINT4
Leg_LINK(5).positive_limit = deg2rad(360);%deg2rad(15+90);
Leg_LINK(5).negetive_limit = deg2rad(-360);%deg2rad(-140+90);
%% JOINT5
Leg_LINK(6).positive_limit = 20;
Leg_LINK(6).negetive_limit = 0;
%% JOINT6
Leg_LINK(7).positive_limit = deg2rad(20);
Leg_LINK(7).negetive_limit = deg2rad(-50);

