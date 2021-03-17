%############# Authors #############
% Tom Schmidt
% Hannes Weichelt
% Julian Bruns

%############# SETUP #############
time(1..horizon).
nulltime(0..horizon).

% directions for robot dodges
dir(1,0). dir(-1,0). dir(0,1). dir(0,-1).

robot(R) :- init(object(robot,R),value(at,(X,Y))).
node(X,Y) :- init(object(node,N),value(at,(X,Y))).

% get robot positions
position(R,(X,Y),0) :- init(object(robot,R),value(at,(X,Y))).
position(R,(X+DX,Y+DY),T+1) :- occurs1(object(robot,R),action(move,(DX,DY)),T+1), position(R,(X,Y),T).
position(R,(X,Y),T2) :- position(R,(X,Y),T1), T2=T1+1, T2<=horizon, T1>=horizon-L, tlimit(R,L).

%############# MOVE GENERATOR #############
% determine available time
tlimit(R,L) :- L = horizon - N,  N == #sum{1,T:occurs1(object(robot,R),_,T)}, robot(R). 

% generate wait times
count(R,0..L) :- tlimit(R,L).
1{wait(R,T,N) : count(R,N)}1 :- robot(R), nulltime(T). 

% generate time delay for dodge moves
dcount(R,0) :- robot(R).
dcount(R,N) :- tlimit(R,L), dcount(R,N-2), N<=L.
dodge_t(R,0,0) :- robot(R).
1{dodge_t(R,T,N) : dcount(R,N)}1 :- robot(R), time(T).

% remove invalid order
:- wait(R,T1,N1), wait(R,T2,N2), T1<T2, N1>N2.
:- dodge_t(R,T1,N1), dodge_t(R,T2,N2), T1<T2, N1>N2.

% rise in dodge_t means a dodge happened -> generate dodge move before dodge delay
1{dodge_m(R,T,(DX,DY)) : dir(DX,DY)}1 :- dodge_t(R,T,N1), dodge_t(R,T+1,N2), N1<N2, nulltime(T), robot(R).
dodge_m(R,T,(0,0)) :- dodge_t(R,T,N1), dodge_t(R,T+1,N2), N1>=N2, nulltime(T), robot(R).

% get new positions
newpos(R,(X,Y),0) :- robot(R), position(R,(X,Y),0).
newpos(R,(X,Y),T+W1+W2) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodge_t(R,T,W2).

% add new dodge positions
newpos(R,(X+DX,Y+DY),T+W1+W2+1) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodge_t(R,T,W2), dodge_m(R,T,(DX,DY)), 1{DX!=0; DY!=0}1.
newpos(R,(X,Y),T+W1+W2+2) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodge_t(R,T,W2), dodge_m(R,T,(DX,DY)), 1{DX!=0; DY!=0}1.

% fill posistions
newpos(R,(X,Y),T) :- newpos(R,(X,Y),T-1), not newpos(R,(X+1,Y),T), not newpos(R,(X-1,Y),T), not newpos(R,(X,Y+1),T), not newpos(R,(X,Y-1),T), robot(R), nulltime(T).

%############# CONSTRAINTS ################
% vertex constraint 
:- newpos(R1,(X,Y),T), newpos(R2,(X,Y),T), nulltime(T), robot(R1), robot(R2), R1!=R2.
% edge constraint
:- newpos(R1,(X1,Y1),T), newpos(R2,(X2,Y2),T), nulltime(T), robot(R1), robot(R2), R1!=R2, newpos(R1,(X2,Y2),T-1), newpos(R2,(X1,Y1),T-1).
% out of bounds
:- newpos(R,(X,Y),T), robot(R), nulltime(T), not node(X,Y).
% horizon
:- newpos(R,(X1,Y1),horizon), robot(R), position(R,(X2,Y2),horizon), X1!=X2.
:- newpos(R,(X1,Y1),horizon), robot(R), position(R,(X2,Y2),horizon), Y1!=Y2.

%############ ADDITIONAL FEATURES ######### 
% possible improvement: move before generation 
% locked robots can't change plan -> benchmark contains lock(object(robot,R)).
%:- wait(R,horizon,N1), lock(object(robot,R)), robot(R), N1!=0.
%:- dodge_t(R,horizon,N2), lock(object(robot,R)), robot(R), N2!=0.

%############ OUTPUT ###################### 
% transform new positions into output
occurs(object(robot,R),action(move,(DX,DY)),T) :- time(T), newpos(R,(X1,Y1),T), newpos(R,(X2,Y2),T-1), DX=X1-X2, DY=Y1-Y2, 1{X1!=X2; Y1!=Y2}1.

% show merged plan
#show occurs/3.

% used for debugging
%#show check/1.
%#show tlimit/2.
%#show collision/3.
%#show wait/3.
%#show count/2.
%#show dodge_t/3.
%#show dcount/2.
%#show dodge_m/3.
%#show newpos/3.
%#show position/3.
