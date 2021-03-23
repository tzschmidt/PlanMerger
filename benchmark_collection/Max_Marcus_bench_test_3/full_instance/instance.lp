%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Grid size X: 4
%Grid size Y: 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.
#const horizon=4.
#const c_nr=1.
#const rm=3.

%init
init(object(node,2),value(at, (2,1))).
init(object(node,6),value(at, (2,2))).
init(object(node,10),value(at, (2,3))).
init(object(node,14),value(at, (2,4))).
init(object(node,18),value(at, (2,5))).
init(object(node,3),value(at, (3,1))).
init(object(node,7),value(at, (3,2))).
init(object(node,11),value(at, (3,3))).
init(object(node,15),value(at, (3,4))).
init(object(node,19),value(at, (3,5))).
init(object(node,4),value(at, (4,1))).
init(object(node,8),value(at, (4,2))).
init(object(node,12),value(at, (4,3))).
init(object(node,16),value(at, (4,4))).
init(object(node,20),value(at, (4,5))).
init(object(highway,2),value(at, (2,1))).
init(object(highway,6),value(at, (2,2))).
init(object(highway,7),value(at, (3,2))).
init(object(highway,10),value(at, (2,3))).
init(object(highway,14),value(at, (2,4))).
init(object(highway,11),value(at, (3,3))).
init(object(highway,4),value(at, (4,1))).
init(object(highway,8),value(at, (4,2))).
init(object(highway,12),value(at, (4,3))).
init(object(highway,16),value(at, (4,4))).
init(object(highway,20),value(at, (4,5))).
init(object(robot,1),value(at,(2,5))).
init(object(robot,2),value(at,(3,1))).
init(object(shelf,1),value(at,(3,4))).
init(object(product,1),value(on,(1,1))).
init(object(shelf,2), value(at,(3,5))).
init(object(product,2),value(on,(2,1))).
init(object(order,1),value(pickingStation,0)).
init(object(order,1),value(line,(1,1))).
init(object(order,2),value(pickingStation,0)).
init(object(order,2),value(line,(2,1))).
