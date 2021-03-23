%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Grid size X: 9
%Grid size Y: 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.

#const horizon=16.
#const c_nr=4.
#const rm=8.

%init
init(object(node, 11), value(at, (2, 2))).
init(object(node, 12), value(at, (3, 2))).
init(object(node, 13), value(at, (4, 2))).
init(object(node, 14), value(at, (5, 2))).
init(object(node, 15), value(at, (6, 2))).
init(object(node, 16), value(at, (7, 2))).
init(object(node, 17), value(at, (8, 2))).
init(object(node, 9), value(at, (9, 1))).
init(object(node, 18), value(at, (9, 2))).
init(object(node, 10), value(at, (1, 2))).
init(object(node, 1), value(at, (1, 1))).
init(object(node, 2), value(at, (2, 1))).
init(object(node, 8), value(at, (8, 1))).
init(object(highway, 11), value(at, (2, 2))).
init(object(highway, 12), value(at, (3, 2))).
init(object(highway, 13), value(at, (4, 2))).
init(object(highway, 14), value(at, (5, 2))).
init(object(highway, 15), value(at, (6, 2))).
init(object(highway, 16), value(at, (7, 2))).
init(object(highway, 17), value(at, (8, 2))).
init(object(robot,1), value(at,(2,1))).
init(object(robot,2), value(at,(8,1))).
init(object(shelf,1), value(at,(9,2))).
init(object(product,1),value(on,(1,4))).
init(object(shelf,2), value(at,(1,2))).
init(object(product,2),value(on,(2,3))).
init(object(pickingStation,1), value(at,(1,1))).
init(object(pickingStation,2), value(at,(9,1))).
init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,(1,4))).
init(object(order,2),value(pickingStation,2)).
init(object(order,2),value(line,(2,2))).
