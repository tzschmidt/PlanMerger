%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grid Size X:                      7
% Grid Size Y:                      2
% Number of Nodes:                  9
% Number of Robots:                 2
% Number of Shelves:                2
% Number of Picking Stations:       1
% Number of Products:               2
% Number of Orders:                 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#const horizon=14.
#const c_nr=9.
#const rm=9.

% Nodes
%init(object(node,1),value(at,(1,1))).
%init(object(node,2),value(at,(2,1))).
%init(object(node,3),value(at,(3,1))).
%init(object(node,4),value(at,(4,1))).
%init(object(node,5),value(at,(5,1))).
init(object(node,6),value(at,(6,1))).
init(object(node,7),value(at,(7,1))).
init(object(node,8),value(at,(1,2))).
init(object(node,9),value(at,(2,2))).
init(object(node,10),value(at,(3,2))).
init(object(node,11),value(at,(4,2))).
init(object(node,12),value(at,(5,2))).
init(object(node,13),value(at,(6,2))).
init(object(node,14),value(at,(7,2))).

% Robot 1
init(object(robot,1),value(at,(6,2))).
init(object(shelf,1),value(at,(2,2))).
init(object(product,1),value(on,(1,1))).
init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,(1,2))).

% Robot 2
init(object(robot,2),value(at,(7,2))).
init(object(shelf,2),value(at,(1,2))).
init(object(product,2),value(on,(2,1))).
init(object(order,2),value(pickingStation,1)).
init(object(order,2),value(line,(2,2))).


% Picking Station
init(object(pickingStation,1),value(at,(7,1))).
