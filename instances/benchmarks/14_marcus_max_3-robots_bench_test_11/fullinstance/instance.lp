%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Grid size X: 9
%Grid size Y: 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.
#const horizon=10.
%init
init(object(node, 11), value(at, (2, 2))).
init(object(node, 12), value(at, (3, 2))).
init(object(node, 4), value(at, (4, 1))).
init(object(node, 13), value(at, (4, 2))).
init(object(node, 22), value(at, (4, 3))).
init(object(node, 5), value(at, (5, 1))).
init(object(node, 14), value(at, (5, 2))).
init(object(node, 23), value(at, (5, 3))).
init(object(node, 6), value(at, (6, 1))).
init(object(node, 15), value(at, (6, 2))).
init(object(node, 24), value(at, (6, 3))).
init(object(node, 16), value(at, (7, 2))).
init(object(node, 8), value(at, (8, 1))).
init(object(node, 17), value(at, (8, 2))).
init(object(node, 26), value(at, (8, 3))).
init(object(node, 9), value(at, (9, 1))).
init(object(node, 18), value(at, (9, 2))).
init(object(node, 27), value(at, (9, 3))).
init(object(node, 10), value(at, (1, 2))).
init(object(node, 25), value(at, (7, 3))).
init(object(node, 7), value(at, (7, 1))).
init(object(highway, 13), value(at, (4, 2))).
init(object(highway, 4), value(at, (4, 1))).
init(object(highway, 5), value(at, (5, 1))).
init(object(highway, 14), value(at, (5, 2))).
init(object(highway, 22), value(at, (4, 3))).
init(object(highway, 23), value(at, (5, 3))).
init(object(highway, 24), value(at, (6, 3))).
init(object(highway, 15), value(at, (6, 2))).
init(object(highway, 6), value(at, (6, 1))).
init(object(highway, 16), value(at, (7, 2))).
init(object(highway, 26), value(at, (8, 3))).
init(object(highway, 8), value(at, (8, 1))).
init(object(highway, 9), value(at, (9, 1))).
init(object(highway, 27), value(at, (9, 3))).
init(object(highway, 12), value(at, (3, 2))).
init(object(highway, 7), value(at, (7, 1))).
init(object(highway, 25), value(at, (7, 3))).
init(object(shelf,1), value(at,(9,2))).
init(object(product,1),value(on,(1,1))).
init(object(shelf,2), value(at,(8,2))).
init(object(product,2),value(on,(2,1))).
init(object(shelf,3), value(at,(1,2))).
init(object(product,3),value(on,(3,1))).
init(object(robot,1), value(at,(4,2))).
init(object(robot,1), value(max_energy,0)).
init(object(robot,1), value(energy,0)).
init(object(robot,2), value(at,(2,2))).
init(object(robot,2), value(max_energy,0)).
init(object(robot,2), value(energy,0)).
init(object(robot,3), value(at,(9,2))).
init(object(robot,3), value(max_energy,0)).
init(object(robot,3), value(energy,0)).
init(object(order,1),value(pickingStation,0)).
init(object(order,1),value(line,(1,1))).
init(object(order,2),value(pickingStation,0)).
init(object(order,2),value(line,(2,1))).
init(object(order,3),value(pickingStation,0)).
init(object(order,3),value(line,(3,1))).
