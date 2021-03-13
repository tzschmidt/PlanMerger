


% Time limit
time(0..horizon).
% Collision depth limit
depth(0..4).


% No moevement is allowed after time horizon
:-position(R,(X1,Y1),T,C), position(R,(X2,Y2),T-1,C), (X1,Y1)!=(X2,Y2), not time(T).

% No two robots occupie the same space at the same time
:-position(R1,(X,Y),T,C1),position(R2,(X,Y),T,C2),R1<R2,max_conflict_depth(R1,C1),max_conflict_depth(R2,C2).


% Initializing absolute positions of the robots
position(R,(X,Y),0,0) :- init(object(robot,R),value(at,(X,Y))).
position(R,(X+DX,Y+DY),T,0) :- occurs1(object(robot,R),action(move,(DX,DY)),T), position(R,(X,Y),T-1,0).


%--------------------------------------------
% Our porgramm creates a variable amount of wait statements depending on how manny robots collide
{wait(R1,T,C1);wait(R2,T,C2)}<=1:-
{position(R,(X,Y),T,C)}=2,position(R1,(X,Y),T,C1),position(R2,(X,Y),T,C2),R1<R2,time(T),depth(C),depth(C1),depth(C2).

{wait(R1,T,C1);wait(R2,T,C2);wait(R3,T,C3)}<=2:-
{position(R,(X,Y),T,C)}=3,position(R1,(X,Y),T,C1),position(R2,(X,Y),T,C2),position(R3,(X,Y),T,C3),R1<R2,R2<R3,time(T),depth(C),depth(C1),depth(C2),depth(C3).

{wait(R1,T,C1);wait(R2,T,C2);wait(R3,T,C3);wait(R4,T,C4)}<=3:-
{position(R,(X,Y),T,C)}=4,position(R1,(X,Y),T,C1),position(R2,(X,Y),T,C2),position(R3,(X,Y),T,C3),position(R4,(X,Y),T,C4),R1<R2,R2<R3,R3<R4,time(T),depth(C),depth(C1),depth(C2),depth(C3),depth(C4).



% Generate a full new position map with one of the robots waiting before the conflict occurs
position(R,(X,Y),T,CONFLICT_DEPTH+1) :- position(R,(X,Y),T,CONFLICT_DEPTH), wait(R,T_WAIT,CONFLICT_DEPTH), T<T_WAIT.
position(R,(X,Y),T+1,CONFLICT_DEPTH+1) :- position(R,(X,Y),T,CONFLICT_DEPTH),wait(R,T+1,CONFLICT_DEPTH).
position(R,(X,Y),T+1,CONFLICT_DEPTH+1) :- position(R,(X,Y),T,CONFLICT_DEPTH), wait(R,T_WAIT,CONFLICT_DEPTH), T>=T_WAIT.


%possible dodge directions
dir(1,0).dir(-1,0).dir(0,1).dir(0,-1).

%chose one of 4 possible edge statements if two robots try to switch places at the same time
%the 4 possible edge statements differ only in which of the 2 robots dodges and in which direction
{edge(R1,(X2-X,Y2-Y),T+1,CONFLICT_DEPTH_1);edge(R2,(X2-X,Y2-Y),T+1,CONFLICT_DEPTH_2);
edge(R1,(-(X2-X),-(Y2-Y)),T+1,CONFLICT_DEPTH_1);edge(R2,(-(X2-X),-(Y2-Y)),T+1,CONFLICT_DEPTH_2)} =1 :- 
position(R1,(X2,Y2),T,CONFLICT_DEPTH_1),position(R2,(X,Y),T,CONFLICT_DEPTH_2),
position(R1,(X,Y),T+1,CONFLICT_DEPTH_1), position(R2,(X2,Y2),T+1,CONFLICT_DEPTH_2),
R1<R2,dir(X2-X,Y2-Y),time(T),depth(CONFLICT_DEPTH_1),depth(CONFLICT_DEPTH_2).

% It is also possible that a robot that waits in place dodges out of the way if another robot trys to get through
{edge(R2,(X2-X,Y2-Y),T+1,CONFLICT_DEPTH_2);edge(R2,(-(X2-X),-(Y2-Y)),T+1,CONFLICT_DEPTH_2)} <=1 :- 
position(R1,(X2,Y2),T,CONFLICT_DEPTH_1), position(R2,(X,Y),T,CONFLICT_DEPTH_2),
position(R1,(X,Y),T+1,CONFLICT_DEPTH_1), position(R2,(X,Y),T+1,CONFLICT_DEPTH_2),
R1!=R2,dir(X2-X,Y2-Y),time(T),depth(CONFLICT_DEPTH_1),depth(CONFLICT_DEPTH_2).

% Originaly the code that generates the new path based on the edge-statements was located here, but
% again for what ever reason moving it under the "#show occurs/3." statement allows this programm to solve a few more Benchmarks

% Generate a full new position map where one of the robots does a dodge maneuver
%path before the edge conflict
%position(R,(X,Y),T,CONFLICT_DEPTH+1) :- position(R,(X,Y),T,CONFLICT_DEPTH), edge(R,(I,J),T2,CONFLICT_DEPTH), T<T2.
%dodge maneuver
%position(R,(X+J,Y+I),T,CONFLICT_DEPTH+1):- position(R,(X,Y),T-1,CONFLICT_DEPTH), edge(R,(I,J),T2,CONFLICT_DEPTH), T=T2.
%position(R,(X,Y),T+1,CONFLICT_DEPTH+1) :- position(R,(X,Y),T-1,CONFLICT_DEPTH), edge(R,(I,J),T2,CONFLICT_DEPTH), T=T2.
%path after the edge conflict
%position(R,(X,Y),T+2,CONFLICT_DEPTH+1) :- position(R,(X,Y),T,CONFLICT_DEPTH), edge(R,(I,J),T2,CONFLICT_DEPTH), T>=T2.


%a robot can't move to a space without a node
:-position(R,(X,Y),T,CONFLICKT_DEPTH), not init(object(node,_),value(at,(X,Y))).


%-------------------------------------------
% OUTPUT
% calculate the max conflict depth for each robot 
max_conflict_depth(R,MAX_D-1) :- init(object(robot,R),value(at,(X,Y))), MAX_D == #sum{1,D:position(R,(X_TMP,Y_TMP),T,D)}.
% get the absolute positions of the last confict depth for each robot  
final_position(R,(X,Y),T) :- position(R,(X,Y),T,D), max_conflict_depth(R,D).

% CONVERT
% generate relative movements
out(R,(X_2-X_1,Y_2-Y_1),T) :- final_position(R,(X_2,Y_2),T), final_position(R,(X_1,Y_1),T-1), T>0.

%generate output in the "occurs" format
occurs(object(robot,R),action(move,(X,Y)),T) :- out(R,(X,Y),T).


%#show out/3.
%#show position/4.
%#show wait/3.
%#show edge/4.
%#show max_conflict_depth/2.

#show occurs/3.



% Generate a full new position map where one of the robots does a dodge maneuver
%path before the edge conflict
position(R,(X,Y),T,CONFLICT_DEPTH+1) :- position(R,(X,Y),T,CONFLICT_DEPTH), edge(R,(I,J),T2,CONFLICT_DEPTH), T<T2.
%dodge maneuver
position(R,(X+J,Y+I),T,CONFLICT_DEPTH+1):- position(R,(X,Y),T-1,CONFLICT_DEPTH), edge(R,(I,J),T2,CONFLICT_DEPTH), T=T2.
position(R,(X,Y),T+1,CONFLICT_DEPTH+1) :- position(R,(X,Y),T-1,CONFLICT_DEPTH), edge(R,(I,J),T2,CONFLICT_DEPTH), T=T2.
%path after the edge conflict
position(R,(X,Y),T+2,CONFLICT_DEPTH+1) :- position(R,(X,Y),T,CONFLICT_DEPTH), edge(R,(I,J),T2,CONFLICT_DEPTH), T>=T2.
