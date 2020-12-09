%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% = BENCHMARK 1 = [ EDGE CONSTRAINT - MULTI ROBOT ] ========
%
% = Instance Statistics ====================================
% Grid Size X:                      6
% Grid Size Y:                      3
% Number of Nodes:                  12
% Number of Highway Nodes:          8
% Number of Robots:                 4
% Number of Shelves:                4
% Number of Picking Stations:       1
% Number of Products:               4
% Number of Product Units in Total: 4
% Number of Orders:                 4
% Number of Orders Lines:           0
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#program base.

% init

% HIGHWAYS
init(object(highway,1),value(at,(2,2))).
init(object(highway,2),value(at,(3,2))).
init(object(highway,3),value(at,(4,2))).
init(object(highway,4),value(at,(5,2))).
init(object(highway,5),value(at,(2,3))).
init(object(highway,6),value(at,(3,3))).
init(object(highway,7),value(at,(4,3))).
init(object(highway,8),value(at,(5,3))).

%NODES
init(object(node,1),value(at,(1,2))).
init(object(node,2),value(at,(2,2))).
init(object(node,3),value(at,(3,2))).
init(object(node,4),value(at,(4,2))).
init(object(node,5),value(at,(5,2))).
init(object(node,6),value(at,(6,2))).
init(object(node,7),value(at,(1,3))).
init(object(node,8),value(at,(2,3))).
init(object(node,9),value(at,(3,3))).
init(object(node,10),value(at,(4,3))).
init(object(node,11),value(at,(5,3))).
init(object(node,12),value(at,(6,3))).

% PICKING STATION
init(object(pickingStation,1),value(at,(3,1))).

% ROBOTS
init(object(robot,1),value(at,(3,2))).
init(object(robot,2),value(at,(4,2))).
init(object(robot,3),value(at,(3,3))).
init(object(robot,4),value(at,(4,3))).

% SHELVES
init(object(shelf,1),value(at,(1,2))).
init(object(shelf,2),value(at,(6,2))).
init(object(shelf,3),value(at,(1,3))).
init(object(shelf,4),value(at,(6,3))).

% PRODUCTS
init(object(product,1),value(on,(1,1))).
init(object(product,2),value(on,(2,1))).
init(object(product,3),value(on,(3,1))).
init(object(product,4),value(on,(4,1))).


% ORDERS
init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,(1,1))).
init(object(order,2),value(pickingStation,1)).
init(object(order,2),value(line,(2,1))).
init(object(order,3),value(pickingStation,1)).
init(object(order,3),value(line,(3,1))).
init(object(order,4),value(pickingStation,1)).
init(object(order,4),value(line,(4,1))).
