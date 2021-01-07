
#const horizon=10.
time(1..horizon).

% not needed atm
dir(1,0). dir(-1,0). dir(0,1). dir(0,-1).

% TODO replace init... with robot(R)
robot(R) :- init(object(robot,R),value(at,(X,Y))).

% get roboter positions
position(R,(X,Y),0) :- init(object(robot,R),value(at,(X,Y))).
position(R,(X+DX,Y+DY),T+1) :- occurs1(object(robot,R),action(move,(DX,DY)),T+1), position(R,(X,Y),T).
position(R,(X,Y),T2) :- position(R,(X,Y),T1), T2=T1+1, T2<=horizon, T1>=horizon-L, tlimit(R,L).

% detect collisions
collision(R1,R2,T) :- position(R1,(X,Y),T), position(R2,(X,Y),T), R1<R2.

% determine availible time
tlimit(R,L) :- L = horizon - N,  N == #sum{1,T:occurs1(object(robot,R),action(move,(DX,DY)),T)}, robot(R). 

% generate wait times
count(R,0..L) :- tlimit(R,L).
1{wait(R,T,N) : count(R,N)}1 :- init(object(robot,R),value(at,(X,Y))),time(T). 

% remove invalid order
:- wait(R,T1,N1), wait(R,T2,N2), T1<T2, N1>N2.

% other idea
% newpos(R,(X,Y),T) :- position(R,(X,Y),T-W) , wait(R,T,W).

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
%#show position/3.
