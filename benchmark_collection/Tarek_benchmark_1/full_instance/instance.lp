%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GridsizeX:3
%GridsizeY:3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.
#const horizon=5.
#const c_nr=8.
#const rm=4.

%init
init(object(node,2),value(at,(2,1))).
init(object(node,8),value(at,(2,3))).
init(object(node,3),value(at,(3,1))).
init(object(node,6),value(at,(3,2))).
init(object(node,9),value(at,(3,3))).
init(object(node,4),value(at,(1,2))).
init(object(node,7),value(at,(1,3))).
init(object(node,1),value(at,(1,1))).
init(object(robot,1),value(at,(1,3))).
init(object(robot,2),value(at,(1,1))).
init(object(robot,3),value(at,(3,3))).
init(object(shelf,1),value(at,(2,1))).
init(object(product,1),value(on,(1,1))).
init(object(shelf,2),value(at,(2,3))).
init(object(product,2),value(on,(2,1))).
init(object(shelf,3),value(at,(1,2))).
init(object(product,3),value(on,(3,1))).
init(object(pickingStation,1),value(at,(3,1))).
init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,(1,1))).
init(object(order,2),value(pickingStation,1)).
init(object(order,2),value(line,(2,1))).
init(object(order,3),value(pickingStation,1)).
init(object(order,3),value(line,(3,1))).
