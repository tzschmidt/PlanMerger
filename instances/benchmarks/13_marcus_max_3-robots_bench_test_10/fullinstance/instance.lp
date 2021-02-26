%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Grid size X: 5
%Grid size Y: 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.
#const horizon=10.
%init
init(object(node, 2), value(at, (2, 1))).
init(object(node, 7), value(at, (2, 2))).
init(object(node, 17), value(at, (2, 4))).
init(object(node, 3), value(at, (3, 1))).
init(object(node, 8), value(at, (3, 2))).
init(object(node, 13), value(at, (3, 3))).
init(object(node, 18), value(at, (3, 4))).
init(object(node, 23), value(at, (3, 5))).
init(object(node, 4), value(at, (4, 1))).
init(object(node, 9), value(at, (4, 2))).
init(object(node, 19), value(at, (4, 4))).
init(object(node, 20), value(at, (5, 4))).
init(object(node, 16), value(at, (1, 4))).
init(object(node, 28), value(at, (3, 6))).
init(object(highway, 17), value(at, (2, 4))).
init(object(highway, 18), value(at, (3, 4))).
init(object(highway, 23), value(at, (3, 5))).
init(object(highway, 19), value(at, (4, 4))).
init(object(highway, 13), value(at, (3, 3))).
init(object(highway, 7), value(at, (2, 2))).
init(object(highway, 8), value(at, (3, 2))).
init(object(highway, 9), value(at, (4, 2))).
init(object(highway, 2), value(at, (2, 1))).
init(object(highway, 3), value(at, (3, 1))).
init(object(highway, 4), value(at, (4, 1))).
init(object(robot,1), value(at,(1,4))).
init(object(robot,1), value(max_energy,0)).
init(object(robot,1), value(energy,0)).
init(object(robot,2), value(at,(3,6))).
init(object(robot,2), value(max_energy,0)).
init(object(robot,2), value(energy,0)).
init(object(robot,3), value(at,(5,4))).
init(object(robot,3), value(max_energy,0)).
init(object(robot,3), value(energy,0)).
init(object(shelf,1), value(at,(4,1))).
init(object(product,1),value(on,(1,1))).
init(object(shelf,2), value(at,(2,1))).
init(object(product,2),value(on,(2,1))).
init(object(shelf,3), value(at,(3,1))).
init(object(product,3),value(on,(3,1))).
init(object(order,1),value(pickingStation,0)).
init(object(order,1),value(line,(1,1))).
init(object(order,2),value(pickingStation,0)).
init(object(order,2),value(line,(2,1))).
init(object(order,3),value(pickingStation,0)).
init(object(order,3),value(line,(3,1))).
