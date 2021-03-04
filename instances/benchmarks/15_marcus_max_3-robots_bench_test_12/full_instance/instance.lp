%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Grid size X: 4
%Grid size Y: 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.
#const horizon=10.
%init
init(object(node, 6), value(at, (2, 2))).
init(object(node, 10), value(at, (2, 3))).
init(object(node, 3), value(at, (3, 1))).
init(object(node, 7), value(at, (3, 2))).
init(object(node, 11), value(at, (3, 3))).
init(object(node, 15), value(at, (3, 4))).
init(object(node, 8), value(at, (4, 2))).
init(object(node, 5), value(at, (1, 2))).
init(object(highway, 6), value(at, (2, 2))).
init(object(highway, 7), value(at, (3, 2))).
init(object(highway, 11), value(at, (3, 3))).
init(object(highway, 10), value(at, (2, 3))).
init(object(robot,1), value(at,(4,2))).
init(object(robot,2), value(at,(3,1))).
init(object(robot,3), value(at,(3,4))).
init(object(shelf,1), value(at,(1,2))).
init(object(product,1),value(on,(1,1))).
init(object(shelf,2), value(at,(3,4))).
init(object(product,2),value(on,(2,1))).
init(object(shelf,3), value(at,(3,1))).
init(object(product,3),value(on,(3,1))).
init(object(order,1),value(pickingStation,0)).
init(object(order,1),value(line,(1,1))).
init(object(order,2),value(pickingStation,0)).
init(object(order,2),value(line,(2,1))).
init(object(order,3),value(pickingStation,0)).
init(object(order,3),value(line,(3,1))).
