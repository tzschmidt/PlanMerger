%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grid Size X:                      8
% Grid Size Y:                      8
% Number of Nodes:                  64
% Number of Robots:                 8
% Number of Shelves:                8
% Number of Picking Stations:       1
% Number of Products:               8
% Number of Orders:                 8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#const horizon=10.
#const c_nr=3.
#const rm=10.

% Nodes
init(object(node,1),value(at,(1,1))).
init(object(node,2),value(at,(2,1))).
init(object(node,3),value(at,(3,1))).
init(object(node,4),value(at,(4,1))).
init(object(node,5),value(at,(5,1))).
init(object(node,6),value(at,(6,1))).
init(object(node,7),value(at,(7,1))).
init(object(node,8),value(at,(8,1))).
init(object(node,9),value(at,(1,2))).
init(object(node,10),value(at,(2,2))).
init(object(node,11),value(at,(3,2))).
init(object(node,12),value(at,(4,2))).
init(object(node,13),value(at,(5,2))).
init(object(node,14),value(at,(6,2))).
init(object(node,15),value(at,(7,2))).
init(object(node,16),value(at,(8,2))).
init(object(node,17),value(at,(1,3))).
init(object(node,18),value(at,(2,3))).
init(object(node,19),value(at,(3,3))).
init(object(node,20),value(at,(4,3))).
init(object(node,21),value(at,(5,3))).
init(object(node,22),value(at,(6,3))).
init(object(node,23),value(at,(7,3))).
init(object(node,24),value(at,(8,3))).
init(object(node,25),value(at,(1,4))).
init(object(node,26),value(at,(2,4))).
init(object(node,27),value(at,(3,4))).
init(object(node,28),value(at,(4,4))).
init(object(node,29),value(at,(5,4))).
init(object(node,30),value(at,(6,4))).
init(object(node,31),value(at,(7,4))).
init(object(node,32),value(at,(8,4))).
init(object(node,33),value(at,(1,5))).
init(object(node,34),value(at,(2,5))).
init(object(node,35),value(at,(3,5))).
init(object(node,36),value(at,(4,5))).
init(object(node,37),value(at,(5,5))).
init(object(node,38),value(at,(6,5))).
init(object(node,39),value(at,(7,5))).
init(object(node,40),value(at,(8,5))).
init(object(node,41),value(at,(1,6))).
init(object(node,42),value(at,(2,6))).
init(object(node,43),value(at,(3,6))).
init(object(node,44),value(at,(4,6))).
init(object(node,45),value(at,(5,6))).
init(object(node,46),value(at,(6,6))).
init(object(node,47),value(at,(7,6))).
init(object(node,48),value(at,(8,6))).
init(object(node,49),value(at,(1,7))).
init(object(node,50),value(at,(2,7))).
init(object(node,51),value(at,(3,7))).
init(object(node,52),value(at,(4,7))).
init(object(node,53),value(at,(5,7))).
init(object(node,54),value(at,(6,7))).
init(object(node,55),value(at,(7,7))).
init(object(node,56),value(at,(8,7))).
init(object(node,57),value(at,(1,8))).
init(object(node,58),value(at,(2,8))).
init(object(node,59),value(at,(3,8))).
init(object(node,60),value(at,(4,8))).
init(object(node,61),value(at,(5,8))).
init(object(node,62),value(at,(6,8))).
init(object(node,63),value(at,(7,8))).
init(object(node,64),value(at,(8,8))).

% Robot 1
init(object(robot,1),value(at,(5,7))).
init(object(shelf,1),value(at,(2,3))).
init(object(product,1),value(on,(1,1))).
init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,(1,2))).

% Robot 2
init(object(robot,2),value(at,(2,3))).
init(object(shelf,2),value(at,(1,7))).
init(object(product,2),value(on,(2,1))).
init(object(order,2),value(pickingStation,1)).
init(object(order,2),value(line,(2,2))).

% Robot 3
init(object(robot,3),value(at,(1,1))).
init(object(shelf,3),value(at,(5,5))).
init(object(product,3),value(on,(3,1))).
init(object(order,3),value(pickingStation,1)).
init(object(order,3),value(line,(3,2))).

% Robot 4
init(object(robot,4),value(at,(2,5))).
init(object(shelf,4),value(at,(3,6))).
init(object(product,4),value(on,(4,1))).
init(object(order,4),value(pickingStation,1)).
init(object(order,4),value(line,(4,2))).

% Robot 5
init(object(robot,5),value(at,(7,3))).
init(object(shelf,5),value(at,(2,1))).
init(object(product,5),value(on,(5,1))).
init(object(order,5),value(pickingStation,1)).
init(object(order,5),value(line,(5,2))).

% Robot 6
init(object(robot,6),value(at,(1,4))).
init(object(shelf,6),value(at,(4,1))).
init(object(product,6),value(on,(6,1))).
init(object(order,6),value(pickingStation,1)).
init(object(order,6),value(line,(6,2))).

% Robot 7
init(object(robot,7),value(at,(3,5))).
init(object(shelf,7),value(at,(8,1))).
init(object(product,7),value(on,(7,1))).
init(object(order,7),value(pickingStation,1)).
init(object(order,7),value(line,(7,2))).

% Robot 8
init(object(robot,8),value(at,(4,3))).
init(object(shelf,8),value(at,(6,5))).
init(object(product,8),value(on,(8,1))).
init(object(order,8),value(pickingStation,1)).
init(object(order,8),value(line,(8,2))).

% Picking Station
init(object(pickingStation,1),value(at,(1,1))).
