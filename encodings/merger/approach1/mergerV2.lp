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

#const horizon=10.
time(1..horizon).

% not needed atm
dir(1,0). dir(-1,0). dir(0,1). dir(0,-1).

% TODO replace init... with robot(R)
robot(R) :- init(object(robot,R),value(at,(X,Y))).

% get roboter positions
position(R,(X,Y),0) :- init(object(robot,R),value(at,(X,Y))).
position(R,(X+DX,Y+DY),T+1) :- occurs1(object(robot,R),action(move,(DX,DY)),T+1), position(R,(X,Y),T).

% detect collisions
collision(R1,R2,T) :- position(R1,(X,Y),T), position(R2,(X,Y),T), R1<R2.

% determin availible time
tlimit(R,L) :- L = horizon - N, N == #sum{1,T:position(R,(X2,Y2),T)}, init(object(robot,R),value(at,(X,Y))). 

% generate wait times
count(R,0..L) :- tlimit(R,L).
1{wait(R,T,N) : count(R,N)}1 :- init(object(robot,R),value(at,(X,Y))),time(T). 

% remove invalid order
:- wait(R,T1,N1), wait(R,T2,N2), T1<T2, N1>N2.

% remove plans with new collisions
check(T) :- time(T), position(R1,(X,Y),T-W1), position(R2,(X,Y),T-W2), R1<R2, wait(R1,T,W1), wait(R2,T,W2).
:- check(T), time(T).

% transform output (maybe move to extra file)
occurs(object(robot,R),action(move,(DX,DY)),T+W) :- occurs1(object(robot,R),action(move,(DX,DY)),T), wait(R,T,W), robot(R).


%#show check/1.
%#show tlimit/2.
%#show collision/3.
%#show wait/3.
%#show count/2.
#show occurs/3.
