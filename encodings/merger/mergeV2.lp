occurs1(object(robot,1),action(move,(0,-1)),1).
occurs1(object(robot,1),action(move,(0,-1)),2).
occurs1(object(robot,1),action(move,(0,-1)),3).
occurs1(object(robot,1),action(move,(0,-1)),4).

occurs1(object(robot,2),action(move,(1,0)),1).
occurs1(object(robot,2),action(move,(1,0)),2).
occurs1(object(robot,2),action(move,(1,0)),3).
occurs1(object(robot,2),action(move,(1,0)),4).

% init

% HIGHWAYS
init(object(highway,1),value(at,(3,2))).
init(object(highway,2),value(at,(2,3))).
init(object(highway,3),value(at,(3,3))).
init(object(highway,4),value(at,(4,3))).
init(object(highway,5),value(at,(3,4))).

% NODES
init(object(node,1),value(at,(3,1))).
init(object(node,2),value(at,(3,2))).
init(object(node,3),value(at,(1,3))).
init(object(node,4),value(at,(2,3))).
init(object(node,5),value(at,(3,3))).
init(object(node,6),value(at,(4,3))).
init(object(node,7),value(at,(5,3))).
init(object(node,8),value(at,(3,4))).
init(object(node,9),value(at,(3,5))).

% PICKING STATION
init(object(pickingStation,1),value(at,(1,1))).

% ROBOTS
init(object(robot,1),value(at,(3,5))).
init(object(robot,2),value(at,(1,3))).

% SHELVES
init(object(shelf,1),value(at,(5,3))).
init(object(shelf,2),value(at,(3,1))).

% PRODUCTS
init(object(product,2),value(on,(1,1))).
init(object(product,1),value(on,(2,1))).

% ORDERS
init(object(order,1),value(pickingStation,1)).
init(object(order,1),value(line,(1,1))).
init(object(order,3),value(pickingStation,1)).
init(object(order,3),value(line,(2,1))).

% PROGRAMM ----------------------------------------------------------------------------------------------------------------

%---------------------------------------------
% Initializing absolute positions of the robots
position(R,(X,Y),0,0) :- init(object(robot,R),value(at,(X,Y))).
position(R,(X+DX,Y+DY),T,0) :- occurs1(object(robot,R),action(move,(DX,DY)),T), position(R,(X,Y),T-1,0).

%--------------------------------------------
% Add a wait statement if two robots are at the same node at the same time
wait(R1,T,CONFLICT_DEPTH_1) :- position(R1,(X,Y),T,CONFLICT_DEPTH_1), position(R2,(X,Y),T,CONFLICT_DEPTH_2), R1<R2.
% could maybe be problematic
% possible fix : not position(R,(X,Y),T,CONFLICT_DEPTH_2+1)

% Generate a full new position map with one of the robots waiting before the conflict occurs
position(R,(X,Y),T,CONFLICT_DEPTH+1) :- position(R,(X,Y),T,CONFLICT_DEPTH), wait(R,T_WAIT,CONFLICT_DEPTH), T<T_WAIT.
position(R,(X,Y),T+1,CONFLICT_DEPTH+1) :- wait(R,T+1,CONFLICT_DEPTH), position(R,(X,Y),T,CONFLICT_DEPTH).
position(R,(X,Y),T+1,CONFLICT_DEPTH+1) :- position(R,(X,Y),T,CONFLICT_DEPTH), wait(R,T_WAIT,CONFLICT_DEPTH), T>=T_WAIT.


%-------------------------------------------
% OUTPUT
% calculate the max conflict depth for each robot 
max_conflict_depth(R,MAX_D-1) :- init(object(robot,R),value(at,(X,Y))), MAX_D == #sum{1,D:position(R,(X_TMP,Y_TMP),T,D)}.
% get the absolute positions of the last confict depth for each robot  
final_position(R,(X,Y),T) :- position(R,(X,Y),T,D), max_conflict_depth(R,D).

% CONVERT
% generate relative movements
out(R,(X_2-X_1,Y_2-Y_1),T) :- final_position(R,(X_2,Y_2),T), final_position(R,(X_1,Y_1),T-1), T>0.

%---------------------------------------------------------------------------------------------------------------------------

% edge_conflict(R1,R2,T) :- Neben einander, positionen tauschen
%1{}1 :- edge_conflict(R1,R2,T), node() in andere achsen richtung vorhanden

% R1:
% C_D=0 : (3,5,1) -> (3,4,2) -> (3,3,3) -> (3,2,4) -> (3,1,5)
% C_D=1 : (3,5,1) -> (3,4,2) -> (3,4,3) -> (3,3,4) -> (3,2,5) -> (3,1,6)

%#show position/4.
%#show wait/3.
%#show max_conflict_depth/2.
%#show final_position/3.
#show out/3.


% position(1,(3,5),0,1)
% position(1,(3,4),1,1)
% position(1,(3,4),2,1)
% position(1,(3,3),3,1)
% position(1,(3,2),4,1)
% position(1,(3,1),5,1)


% max_conflict_depth(1,1)
% max_conflict_depth(2,0)

% final_position(1,(3,5),0)
% final_position(1,(3,4),1)
% final_position(1,(3,4),2)
% final_position(1,(3,3),3)
% final_position(1,(3,2),4)
% final_position(1,(3,1),5)

% final_position(2,(1,3),0)
% final_position(2,(2,3),1)
% final_position(2,(3,3),2)
% final_position(2,(4,3),3)
% final_position(2,(5,3),4)


% out(1,(0,-1),1)
% out(1,(0,0),2)
% out(1,(0,-1),3)
% out(1,(0,-1),4)
% out(1,(0,-1),5)

% out(2,(1,0),1)
% out(2,(1,0),2)
% out(2,(1,0),3)
% out(2,(1,0),4)

