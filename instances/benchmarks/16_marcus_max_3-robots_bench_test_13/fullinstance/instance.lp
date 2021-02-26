%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Grid size X: 5
%Grid size Y: 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.
#const horizon=10.

%init
init(object(node, 7), value(at, (2, 2))).
init(object(node, 8), value(at, (3, 2))).
init(object(node, 4), value(at, (4, 1))).
init(object(node, 9), value(at, (4, 2))).
init(object(node, 14), value(at, (4, 3))).
init(object(node, 19), value(at, (4, 4))).
init(object(node, 10), value(at, (5, 2))).
init(object(node, 6), value(at, (1, 2))).
init(object(highway, 8), value(at, (3, 2))).
init(object(highway, 14), value(at, (4, 3))).
init(object(robot,1), value(at,(4,4))).
init(object(robot,1), value(max_energy,0)).
init(object(robot,1), value(energy,0)).
init(object(robot,2), value(at,(1,2))).
init(object(robot,2), value(max_energy,0)).
init(object(robot,2), value(energy,0)).
init(object(robot,3), value(at,(2,2))).
init(object(robot,3), value(max_energy,0)).
init(object(robot,3), value(energy,0)).
init(object(shelf,1), value(at,(4,1))).
init(object(product,1),value(on,(1,1))).
init(object(shelf,2), value(at,(4,2))).
init(object(product,2),value(on,(2,1))).
init(object(shelf,3), value(at,(5,2))).
init(object(product,3),value(on,(3,1))).
init(object(order,1),value(pickingStation,0)).
init(object(order,1),value(line,(1,1))).
init(object(order,2),value(pickingStation,0)).
init(object(order,2),value(line,(2,1))).
init(object(order,3),value(pickingStation,0)).
init(object(order,3),value(line,(3,1))).
