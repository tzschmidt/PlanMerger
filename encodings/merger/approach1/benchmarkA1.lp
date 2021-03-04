#const horizon=17.
adomain.

% HW
init(object(highway,1),value(at,(1,1))).
init(object(highway,2),value(at,(2,1))).
init(object(highway,3),value(at,(3,1))).
init(object(highway,4),value(at,(4,1))).
init(object(highway,5),value(at,(5,1))).
init(object(highway,6),value(at,(2,2))).
init(object(highway,7),value(at,(4,2))).
init(object(highway,8),value(at,(1,3))).
init(object(highway,9),value(at,(2,3))).
init(object(highway,10),value(at,(4,3))).
init(object(highway,11),value(at,(5,3))).

% NODE
init(object(node,1),value(at,(1,1))).
init(object(node,2),value(at,(2,1))).
init(object(node,3),value(at,(3,1))).
init(object(node,4),value(at,(4,1))).
init(object(node,5),value(at,(5,1))).
init(object(node,6),value(at,(1,2))).
init(object(node,7),value(at,(2,2))).
init(object(node,8),value(at,(3,2))).
init(object(node,9),value(at,(4,2))).
init(object(node,10),value(at,(5,2))).
init(object(node,11),value(at,(1,3))).
init(object(node,12),value(at,(2,3))).
init(object(node,13),value(at,(3,3))).
init(object(node,14),value(at,(4,3))).
init(object(node,15),value(at,(5,3))).

% PICK
init(object(pickingStation,1),value(at,(3,1))).

% ROBOT
init(object(robot,1),value(at,(1,2))).
init(object(robot,2),value(at,(3,3))).

% SHELF
init(object(shelf,1),value(at,(3,2))).
init(object(shelf,2),value(at,(5,2))).

% PROD
init(object(product,1),value(on,(1,1))).
init(object(product,2),value(on,(2,1))).

% ORDER
init(object(order,1),value(pickingStation,1)).
init(object(order,2),value(pickingStation,1)).
init(object(order,1),value(line,(1,1))).
init(object(order,2),value(line,(2,1))).
