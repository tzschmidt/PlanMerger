% moved to benchmarks
%#const horizon=10.
time(1..horizon).
nulltime(0..horizon).

% directions 
dir(1,0). dir(-1,0). dir(0,1). dir(0,-1).

robot(R) :- init(object(robot,R),value(at,(X,Y))).
node(X,Y) :- init(object(node,N),value(at,(X,Y))).
shelf(N,(X,Y),0) :- init(object(shelf,N),value(at,(X,Y))).

%############# PREPATORY WORK #############
% get roboter positions
prepos(R,(X,Y),0) :- init(object(robot,R),value(at,(X,Y))).
prepos(R,(X+DX,Y+DY),T+1) :- occurs1(object(robot,R),action(move,(DX,DY)),T+1), prepos(R,(X,Y),T).
prepos(R,(X,Y),T2) :- prepos(R,(X,Y),T1), T2=T1+1, T2<=horizon, T1>=horizon-L, tlimit(R,L), not adomain.
prepos(R,(X,Y),T2) :- prepos(R,(X,Y),T1), T2=T1+1, T2<=horizon, T1>=horizon-L-TA+TD/2, tlimit(R,L), tdifft(R,horizon,TA), tdiff(R,TD,_,N), not tdiff(R,_,_,N+1), adomain. 

prepos(R,C,T+1) :- prepos(R,C,T), occurs1(object(robot,R),action(pickup,()),T+1).
prepos(R,C,T+1) :- prepos(R,C,T), occurs1(object(robot,R),action(putdown,()),T+1).
prepos(R,C,T+1) :- prepos(R,C,T), occurs1(object(robot,R),action(deliver,_),T+1).

% get times for pickup and delivery
prepickup(R,0,0) :- robot(R).
prepickup(R,T1,N+1) :- occurs1(object(robot,R),action(pickup,()),T1), prepickup(R,T2,N), T1>T2.
predeliver(R,0,0,0) :- robot(R).
predeliver(R,T1,D,N+1) :- occurs1(object(robot,R),action(deliver,D),T1), predeliver(R,T2,_,N), T1>T2.

% edit plan
% copy path from pickup to delivery, remember delivery time for future step
reppos(R,C,T,T2) :- prepos(R,C,T), prepickup(R,T1,N), predeliver(R,T2,_,N), T1<=T, T<T2, N!=0.
% calculate extra time needed
% per copy
tdiff(R,2*(T2-T1),T2,N) :- prepickup(R,T1,N), predeliver(R,T2,_,N), N!=0.
% at time T
tdifft(R,0,0) :- robot(R).
tdifft(R,T,TA) :- robot(R), time(T), TA == #sum{T1,x:tdiff(R,T1,T2,_), T2<=T}.

% add copied path
% D->P
position(R,C,T+(T1-T)*2-1+TA) :- reppos(R,C,T,T1), tdifft(R,T,TA).   
% P->D
% TODO: last step unnecessary, remnant of orginal deliver
position(R,C,T+TD+TA) :- reppos(R,C,T,T1), tdiff(R,TD,T1,_), tdifft(R,T,TA).
% adjust old plan
position(R,C,T+TA) :- prepos(R,C,T), tdifft(R,T,TA). 

% adjust actions
pickup(R,0,0) :- robot(R).
pickup(R,T+TA,N) :- tdifft(R,T,TA), prepickup(R,T,N), N!=0.
deliver(R,0,0,0) :- robot(R).
deliver(R,T+TA,D,N) :- tdifft(R,T-1,TA), predeliver(R,T,D,N), N!=0.
putdown(R,0,0) :- robot(R).
putdown(R,T1+2*(T2-T1),N) :- pickup(R,T1,N), deliver(R,T2,_,N), N!=0.

%############# MOVE GENERATOR #############
% determine availible time for needed domain
tlimit(R,L) :- L = horizon-N,  N == #sum{1,T:occurs1(object(robot,R),_,T)}, robot(R), not adomain. 
% moving athelp into line below doesnt work???
athelp(R,TD/2) :- tdiff(R,TD,_,N), not tdiff(R,_,_,N+1), adomain.
tlimit(R,L) :- L = horizon-N-TA+TH,  N == #sum{1,T:occurs1(object(robot,R),_,T)}, tdifft(R,horizon,TA), athelp(R,TH), robot(R), adomain. 

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

% generate dodge move before dodge delay
1{dodgem(R,T,(DX,DY)) : dir(DX,DY)}1 :- dodget(R,T,N1), dodget(R,T+1,N2), N1<N2, nulltime(T), robot(R).
dodgem(R,T,(0,0)) :- dodget(R,T,N1), dodget(R,T+1,N2), N1>=N2, nulltime(T), robot(R).

% get new positions
newpos(R,(X,Y),0) :- robot(R), position(R,(X,Y),0).
newpos(R,(X,Y),T+W1+W2) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodget(R,T,W2).

% add new dodge positions
newpos(R,(X+DX,Y+DY),T+W1+W2+1) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodget(R,T,W2), dodgem(R,T,(DX,DY)), 1{DX!=0; DY!=0}1.
newpos(R,(X,Y),T+W1+W2+2) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodget(R,T,W2), dodgem(R,T,(DX,DY)), 1{DX!=0; DY!=0}1.

% fill pos
newpos(R,(X,Y),T) :- newpos(R,(X,Y),T-1), not newpos(R,(X+1,Y),T), not newpos(R,(X-1,Y),T), not newpos(R,(X,Y+1),T), not newpos(R,(X,Y-1),T), robot(R), nulltime(T).

% see shelf constraint
%shelf(S,C,T+W1+W2) :- shelf(S,C,T+W1+W2-1), not pickup(R,T-1,_,S), robot(R), wait(R,T,W1), dodget(R,T,W2).
%shelf(S,C,T+W1+W2) :- shelf(S,C,0), putdown(R,T-1,_,S), robot(R), wait(R,T,W1), dodget(R,T,W2).
carry(R,T1+W1+W2,T2+W3+W4) :- pickup(R,T1,N), putdown(R,T2,N), robot(R), wait(R,T1,W1), dodget(R,T1,W2), wait(R,T2,W3), dodget(R,T2,W4), N!=0. 

%############# CONSTRAINTS ################
% vertex constraint 
:- newpos(R1,(X,Y),T), newpos(R2,(X,Y),T), nulltime(T), robot(R1), robot(R2), R1!=R2.
% edge constraint
:- newpos(R1,(X1,Y1),T), newpos(R2,(X2,Y2),T), nulltime(T), robot(R1), robot(R2), R1!=R2, newpos(R1,(X2,Y2),T-1), newpos(R2,(X1,Y1),T-1).
% out of bounds
:- newpos(R,(X,Y),T), robot(R), nulltime(T), not node(X,Y).
% horizon, different for M and A domain
% M domain stop under original shelf
:- newpos(R,(X1,Y1),horizon), robot(R), position(R,(X2,Y2),horizon), X1!=X2, not adomain.
:- newpos(R,(X1,Y1),horizon), robot(R), position(R,(X2,Y2),horizon), Y1!=Y2, not adomain.
% A domain stop (anywhere) after last putdown, but not under shelf
:- T1=T+W1+W2, time(T), putdown(R,T,N), wait(R,T,W1), dodget(R,T,W2), not putdown(R,_,N+1), T1>horizon, adomain.
:- newpos(R,C,horizon), robot(R), shelf(_,C,0), adomain.

% cant move with shelf through shelf
% cant dodge into original shelf position, regardless of whether there actually is a shelf or not
% TODO: improve 
%:- newpos(R,(X,Y),T), robot(R), nulltime(T), shelf(S,(X,Y),0), carry(R,T1,T2), T1<=T, T<=T2.
:- carry(R,T1,T2), T1<=T, T<=T2, shelf(S,(X+DX,Y+DY),0), robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodget(R,T,W2), dodgem(R,T,(DX,DY)), 1{DX!=0; DY!=0}1.

%############ ADDITIONAL FEATURES #########
% maybe improve performance by moving before generation 
% locked robots can't change plan -> benchmark contains lock(object(robot,R)).
%:- wait(R,T,N1), dodget(R,T,N2), nulltime(T), lock(object(robot,R)), 1{N1=0; N2=0}1.
:- wait(R,horizon,N1), lock(object(robot,R)), robot(R), N1!=0.
:- dodget(R,horizon,N2), lock(object(robot,R)), robot(R), N2!=0.


%############ OUTPUT ###################### 
% transform new positions into output
occurs(object(robot,R),action(move,(DX,DY)),T) :- time(T), newpos(R,(X1,Y1),T), newpos(R,(X2,Y2),T-1), DX=X1-X2, DY=Y1-Y2, 1{X1!=X2; Y1!=Y2}1.

%############ A-DOMAIN ####################
occurs(object(robot,R),action(pickup,()),T+W1+W2) :- time(T), pickup(R,T,N), wait(R,T,W1), dodget(R,T,W2), N>0.
occurs(object(robot,R),action(putdown,()),T+W1+W2) :- time(T), putdown(R,T,N), wait(R,T,W1), dodget(R,T,W2), N>0.
occurs(object(robot,R),action(deliver,D),T+W1+W2) :- time(T), deliver(R,T,D,N), wait(R,T,W1), dodget(R,T,W2), N>0.


%#show check/1.
%#show tlimit/2.
%#show collision/3.
%#show wait/3.
%#show count/2.
%#show dodget/3.
%#show dcount/2.
%#show dodgem/3.
%#show newpos/3.
%#show prepos/3.
%#show position/3.
%#show tdiff/4.
%#show prepos/3.
%#show lock/1.
%#show carry/3.
%#show pickup/3.
%#show putdown/3.
%#show deliver/4.
#show occurs/3.

