% moved to benchmarks
%#const horizon=10.
time(1..horizon).
nulltime(0..horizon).

% directions 
dir(1,0). dir(-1,0). dir(0,1). dir(0,-1).

% TODO replace init... with robot(R)
robot(R) :- init(object(robot,R),value(at,(X,Y))).
node(X,Y) :- init(object(node,N),value(at,(X,Y))).

% get roboter positions
position(R,(X,Y),0) :- init(object(robot,R),value(at,(X,Y))).
position(R,(X+DX,Y+DY),T+1) :- occurs1(object(robot,R),action(move,(DX,DY)),T+1), position(R,(X,Y),T).
position(R,(X,Y),T2) :- position(R,(X,Y),T1), T2=T1+1, T2<=horizon, T1>=horizon-L, tlimit(R,L).
% maybe needed
% position(R,(X,Y),T2) :- position(R,(X,Y),T1), T2=T1-1, T2>=-L,T1<=0, tlimit(R,L).

% determine availible time
tlimit(R,L) :- L = horizon - N,  N == #sum{1,T:occurs1(object(robot,R),action(move,(DX,DY)),T)}, robot(R). 

% generate wait times
count(R,0..L) :- tlimit(R,L).
1{wait(R,T,N) : count(R,N)}1 :- robot(R), nulltime(T). 

% generate dodge times/delay
dcount(R,0) :- robot(R).
dcount(R,N) :- tlimit(R,L), dcount(R,N-2), N<=L.
dodget(R,0,0) :- robot(R).
1{dodget(R,T,N) : dcount(R,N)}1 :- robot(R), time(T).

% remove invalid order
:- wait(R,T1,N1), wait(R,T2,N2), T1<T2, N1>N2.
:- dodget(R,T1,N1), dodget(R,T2,N2), T1<T2, N1>N2.

% remove exceeding timelimit
:- wait(R,T1,N1), dodget(R,T2,N2), tlimit(R,L), (N1+N2)>L, robot(R).

% generate dodge move before dodge delay
1{dodgem(R,T,(DX,DY)) : dir(DX,DY)}1 :- dodget(R,T,N1), dodget(R,T+1,N2), N1<N2, nulltime(T), robot(R).

dodgem(R,T,(0,0)) :- dodget(R,T,N1), dodget(R,T+1,N2), N1>=N2, nulltime(T), robot(R).

% remove invalid direction
:- position(R,(X,Y),T), nulltime(T), dodgem(R,T,(DX,DY)), not node(X+DY,Y+DY). 

%###############################################
% old idea, to complex, hard maintenance
%############################################### 
% remove plans with new collisions
%:- time(T), robot(R1), robot(R2), R1<R2, wait(R1,T,W1), wait(R2,T,W2), dodget(R1,T,W3), dodget(R2,T,W4), dodgem(R1,T,(DX1,DY1)), dodgem(R2,T,(DX2,DY2)), position(R1,(X1,Y1),T-W1-W3), position(R2,(X2,Y2),T-W2-W4), X1+DX1=X2+DX2, Y1+DY1=Y2+DY2.
%
% remove edge collisions
%:- time(T), robot(R1), robot(R2), R1<R2, wait(R1,T,W1), wait(R2,T,W2), dodget(R1,T,W3), dodget(R2,T,W4), dodgem(R1,T,(DX1,DY1)), dodgem(R2,T,(DX2,DY2)), dodgem(R1,T+1,(DX3,DY3)), dodgem(R2,T+1,(DX4,DY4)), position(R1,(X1,Y1),T-W1-W3), position(R2,(X2,Y2),T-W2-W4), position(R1,(X3,Y3),T-W1-W3+1), position(R2,(X4,Y4),T-W2-W4+1), X1+DX1=X4+DX4, Y1+DY1=Y4+DY4, X2+DX2=X3+DX3, Y2+DY2=Y3+DY3.
%###############################################

% get new positions
newpos(R,(X,Y),0) :- robot(R), position(R,(X,Y),0).
newpos(R,(X,Y),T+W1+W2) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodget(R,T,W2).

% add new dodge positions
newpos(R,(X+DX,Y+DY),T+W1+W2+1) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodget(R,T,W2), dodgem(R,T,(DX,DY)), 1{DX!=0; DY!=0}1.
newpos(R,(X,Y),T+W1+W2+2) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodget(R,T,W2), dodgem(R,T,(DX,DY)), 1{DX!=0; DY!=0}1.

% fill pos
newpos(R,(X,Y),T) :- newpos(R,(X,Y),T-1), not newpos(R,(X+1,Y),T), not newpos(R,(X-1,Y),T), not newpos(R,(X,Y+1),T), not newpos(R,(X,Y-1),T), robot(R), nulltime(T).

% vertex constraint 
:- newpos(R1,(X,Y),T), newpos(R2,(X,Y),T), nulltime(T), robot(R1), robot(R2), R1!=R2.
% edge constraint
:- newpos(R1,(X1,Y1),T), newpos(R2,(X2,Y2),T), nulltime(T), robot(R1), robot(R2), R1!=R2, newpos(R1,(X2,Y2),T-1), newpos(R2,(X1,Y1),T-1).
% out of bounds
:- newpos(R,(X,Y),T), robot(R), nulltime(T), not node(X,Y).

%##########################################
% output (maybe move to extra file)
% 
% transform output if no dodge
%occurs(object(robot,R),action(move,(DX,DY)),T+W1+W2) :- occurs1(object(robot,R),action(move,(DX,DY)),T), wait(R,T,W1), robot(R), dodget(R,T,W2), dodgem(R,T,(0,0)).
%
%add new actions for dodge
%occurs(object(robot,R),action(move,(DX,DY)),T+W1+W2+1) :- dodgem(R,T,(DX,DY)), 1{DX!=0; DY!=0}1, wait(R,T,W1), dodget(R,T,W2), robot(R).
%occurs(object(robot,R),action(move,(-DX,-DY)),T+W1+W2+2) :- dodgem(R,T,(DX,DY)), 1{DX!=0; DY!=0}1, wait(R,T,W1), dodget(R,T,W2), robot(R).

% transform new positions into output
occurs(object(robot,R),action(move,(DX,DY)),T) :- time(T), newpos(R,(X1,Y1),T), newpos(R,(X2,Y2),T-1), DX=X1-X2, DY=Y1-Y2, 1{X1!=X2; Y1!=Y2}1.

%#show check/1.
%#show tlimit/2.
%#show collision/3.
%#show wait/3.
%#show count/2.
%#show dodget/3.
%#show dcount/2.
%#show dodgem/3.
%#show newpos/3.
%#show position/3.
#show occurs/3.
