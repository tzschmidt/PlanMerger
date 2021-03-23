%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Grid size X: 7
%Grid size Y: 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.
#const horizon=19.
#const c_nr=10.
#const rm=16.

%init
init(object(node, 1), value(at, (1, 1))).
init(object(node, 2), value(at, (2, 1))).
init(object(node, 3), value(at, (3, 1))).
init(object(node, 4), value(at, (4, 1))).
init(object(node, 5), value(at, (5, 1))).
init(object(node, 6), value(at, (6, 1))).
init(object(node, 27), value(at, (6, 4))).
init(object(node, 35), value(at, (7, 5))).
init(object(node, 28), value(at, (7, 4))).
init(object(node, 21), value(at, (7, 3))).
init(object(node, 7), value(at, (7, 1))).
init(object(node, 14), value(at, (7, 2))).
init(object(highway, 2), value(at, (2, 1))).
init(object(highway, 3), value(at, (3, 1))).
init(object(highway, 4), value(at, (4, 1))).
init(object(highway, 5), value(at, (5, 1))).
init(object(highway, 6), value(at, (6, 1))).
init(object(highway, 14), value(at, (7, 2))).
init(object(highway, 21), value(at, (7, 3))).
init(object(highway, 28), value(at, (7, 4))).
init(object(highway, 35), value(at, (7, 5))).
init(object(highway, 27), value(at, (6, 4))).
init(object(shelf,1), value(at,(1,1))).
init(object(product,1),value(on,(1,1))).
init(object(shelf,2), value(at,(7,1))).
init(object(product,2),value(on,(2,1))).
init(object(robot,1), value(at,(7,1))).
init(object(robot,2), value(at,(1,1))).
init(object(pickingStation,1), value(at,(6,4))).
init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,(1,1))).
init(object(order,2),value(pickingStation,1)).
init(object(order,2),value(line,(2,1))).
