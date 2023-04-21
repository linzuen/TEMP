function rpy = RotMatToRPY(R)

    rpy(1) = atan2(R(3,2),R(3,3));
    rpy(2) = asin(-R(3,1));
    rpy(3) = atan2(R(2,1),R(1,1));

end