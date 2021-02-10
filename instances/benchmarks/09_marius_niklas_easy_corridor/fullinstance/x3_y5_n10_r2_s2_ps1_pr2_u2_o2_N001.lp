%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Grid size X: 3
%Grid size Y: 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.
#const horizon=11.
%init
init(object(node, 1), value(at, (1, 1))).
init(object(node, 2), value(at, (2, 1))).
init(object(node, 3), value(at, (3, 1))).
init(object(node, 4), value(at, (2, 2))).
init(object(node, 5), value(at, (1, 3))).
init(object(node, 6), value(at, (2, 3))).
init(object(node, 7), value(at, (2, 4))).
init(object(node, 8), value(at, (1, 5))).
init(object(node, 9), value(at, (2, 5))).
init(object(node, 10), value(at, (3, 5))).
init(object(highway, 1), value(at, (1, 1))).
init(object(highway, 2), value(at, (2, 1))).
init(object(highway, 3), value(at, (2, 2))).
init(object(highway, 4), value(at, (2, 3))).
init(object(highway, 5), value(at, (2, 4))).
init(object(highway, 6), value(at, (2, 5))).
init(object(highway, 7), value(at, (3, 5))).
init(object(pickingStation,1), value(at,(1,3))).
init(object(robot,1), value(at,(1,1))).
init(object(robot,2), value(at,(3,5))).
init(object(shelf,1), value(at,(1,5))).
init(object(product,1),value(on,(1,1))).
init(object(shelf,2), value(at,(3,1))).
init(object(product,2),value(on,(2,1))).
init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,(1,1))).
init(object(order,2),value(pickingStation,1)).
init(object(order,2),value(line,(2,1))).