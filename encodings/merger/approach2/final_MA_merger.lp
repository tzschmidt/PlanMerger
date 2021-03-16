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
shelf(N,(X,Y),0) :- init(object(shelf,N),value(at,(X,Y))).

% get robot positions
prepos(R,(X,Y),0) :- init(object(robot,R),value(at,(X,Y))).
prepos(R,(X+DX,Y+DY),T+1) :- occurs1(object(robot,R),action(move,(DX,DY)),T+1), prepos(R,(X,Y),T).
prepos(R,(X,Y),T2) :- prepos(R,(X,Y),T1), T2=T1+1, T2<=horizon, T1>=horizon-L, tlimit(R,L), not adomain.
prepos(R,(X,Y),T2) :- prepos(R,(X,Y),T1), T2=T1+1, T2<=horizon, T1>=horizon-L-TA+TD/2, tlimit(R,L), tdifft(R,horizon,TA), tdiff(R,TD,_,N), not tdiff(R,_,_,N+1), adomain. 

prepos(R,C,T+1) :- prepos(R,C,T), occurs1(object(robot,R),action(pickup,()),T+1).
prepos(R,C,T+1) :- prepos(R,C,T), occurs1(object(robot,R),action(putdown,()),T+1).
prepos(R,C,T+1) :- prepos(R,C,T), occurs1(object(robot,R),action(deliver,_),T+1).

% get times for pickup and delivery and match them
prepickuphelp(R,0,0) :- robot(R).
prepickuphelp(R,T1,N) :- occurs1(object(robot,R),action(pickup,()),T1), prepickuphelp(R,T2,N-1), T1>T2.
prepickup(R,T,N) :- prepickuphelp(R,T,N), not prepickuphelp(R,T,N+1).
predeliverhelp(R,0,0,0) :- robot(R).
predeliverhelp(R,T1,D,N+1) :- occurs1(object(robot,R),action(deliver,D),T1), predeliverhelp(R,T2,_,N), T1>T2.
predeliver(R,T,D,N) :- predeliverhelp(R,T,D,N), not predeliverhelp(R,T,_,N+1).

% edit plan 
% possible improvement: only edit if pickup!=putdown, first tests showed significantly worse performance 
% copy path from pickup to delivery, remember delivery time for future step
reppos(R,C,T,T2) :- prepos(R,C,T), prepickup(R,T1,N), predeliver(R,T2,_,N), T1<=T, T<T2, N!=0.
% calculate extra time needed
% per copy
tdiff(R,2*(T2-T1),T2,N) :- prepickup(R,T1,N), predeliver(R,T2,_,N), N!=0.
% at time T
tdifft(R,0,0) :- robot(R).
tdifft(R,T,TA) :- robot(R), time(T), TA = #sum{T1,T2:tdiff(R,T1,T2,_), T2<=T}.

% add copied path
% delivery -> pickup
position(R,C,T+(T1-T)*2-1+TA) :- reppos(R,C,T,T1), tdifft(R,T,TA).   
% pickup -> delivery
% possible improvement: last step unnecessary, remnant of orginal deliver
position(R,C,T+TD+TA) :- reppos(R,C,T,T1), tdiff(R,TD,T1,_), tdifft(R,T,TA).
% adjust old plan
position(R,C,T+TA) :- prepos(R,C,T), tdifft(R,T,TA).

% adjust actions
pickup(R,0,0,0) :- robot(R).
pickup(R,T+TA,S,N) :- tdifft(R,T,TA), prepickup(R,T,N), position(R,C,T+TA), shelf(S,C,0), N!=0.
deliver(R,0,0,0) :- robot(R).
deliver(R,T+TA,D,N) :- tdifft(R,T-1,TA), predeliver(R,T,D,N), N!=0.
% create new putdowns
putdown(R,0,0) :- robot(R).
putdown(R,T1+2*(T2-T1),N) :- pickup(R,T1,S,N), deliver(R,T2,_,N), N!=0.

%############# MOVE GENERATOR #############
% determine available time for needed domain
tlimit(R,L) :- L = horizon-N,  N = #sum{1,T:occurs1(object(robot,R),_,T)}, robot(R), not adomain. 
% separate lines, because moving athelp into line below leads to wrong behavior
athelp(R,TD/2) :- tdiff(R,TD,_,N), not tdiff(R,_,_,N+1), adomain.
tlimit(R,L) :- L = horizon-N-TA+TH,  N = #sum{1,T:occurs1(object(robot,R),_,T)}, tdifft(R,horizon,TA), athelp(R,TH), robot(R), adomain. 

% generate wait times
count(R,0..L) :- tlimit(R,L).
1{wait(R,T,N) : count(R,N)}1 :- robot(R), nulltime(T). 

% generate time delay for dodge moves
dcount(R,0) :- robot(R).
dcount(R,N) :- tlimit(R,L), dcount(R,N-2), N<=L.
dodget(R,0,0) :- robot(R).
1{dodget(R,T,N) : dcount(R,N)}1 :- robot(R), time(T).

% remove invalid order
:- wait(R,T1,N1), wait(R,T2,N2), T1<T2, N1>N2.
:- dodget(R,T1,N1), dodget(R,T2,N2), T1<T2, N1>N2.

% rise in dodget means a dodge happened -> generate dodge move before dodge delay
1{dodgem(R,T,(DX,DY)) : dir(DX,DY)}1 :- dodget(R,T,N1), dodget(R,T+1,N2), N1<N2, nulltime(T), robot(R).
dodgem(R,T,(0,0)) :- dodget(R,T,N1), dodget(R,T+1,N2), N1>=N2, nulltime(T), robot(R).

% get new positions
newpos(R,(X,Y),0) :- robot(R), position(R,(X,Y),0).
newpos(R,(X,Y),T+W1+W2) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodget(R,T,W2).

% add new dodge positions
newpos(R,(X+DX,Y+DY),T+W1+W2+1) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodget(R,T,W2), dodgem(R,T,(DX,DY)), 1{DX!=0; DY!=0}1.
newpos(R,(X,Y),T+W1+W2+2) :- robot(R), position(R,(X,Y),T), nulltime(T), wait(R,T,W1), dodget(R,T,W2), dodgem(R,T,(DX,DY)), 1{DX!=0; DY!=0}1.

% fill posistions
newpos(R,(X,Y),T) :- newpos(R,(X,Y),T-1), not newpos(R,(X+1,Y),T), not newpos(R,(X-1,Y),T), not newpos(R,(X,Y+1),T), not newpos(R,(X,Y-1),T), robot(R), nulltime(T).

% determine when shelves are carried
newpickup(R,T+W1+W2,S,N) :- time(T), pickup(R,T,S,N), wait(R,T,W1), dodget(R,T,W2), N>0.
newputdown(R,T+W1+W2,N) :- time(T), putdown(R,T,N), wait(R,T,W1), dodget(R,T,W2), N>0.
carry(R,T1,T2,S) :- newpickup(R,T1,S,N), newputdown(R,T2,N), robot(R), N!=0. 
% possible improvement: determine position of shelves at all times
%shelf(S,C,T) :- shelf(S,C,T-1), newpickup(R,T1,S,N+1), newputdown(R,T2,S,N), T2<=T, T<T1.

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

% A domain specific shelf constraints
% cant move with shelf through shelf
% cant dodge into original shelf position, regardless of whether there actually is a shelf or not (rare case, where this actually hinders the merger)
:- carry(R,T1,T2,S1), T1<=T, T<=T2, shelf(S2,C,0), S1!=S2, robot(R), newpos(R,C,T), nulltime(T).
% possible improvement: dodge is possible if shelf is not there 
%:- newpos(R,(X,Y),T), robot(R), nulltime(T), shelf(S,(X,Y),0), carry(R,T1,T2), T1<=T, T<=T2.
% robots can only pickup shelves that are not carried
:- newpickup(R1,T,S,N), carry(R2,T1,T2,S), T1<=T, T<=T2, time(T), R1!=R2.

%############ ADDITIONAL FEATURES #########
% possible improvement: move before generation 
% locked robots can't change plan -> benchmark contains lock(object(robot,R)).
:- wait(R,horizon,N1), lock(object(robot,R)), robot(R), N1!=0.
:- dodget(R,horizon,N2), lock(object(robot,R)), robot(R), N2!=0.


%############ OUTPUT ###################### 
% transform new positions into output
occurs(object(robot,R),action(move,(DX,DY)),T) :- time(T), newpos(R,(X1,Y1),T), newpos(R,(X2,Y2),T-1), DX=X1-X2, DY=Y1-Y2, 1{X1!=X2; Y1!=Y2}1.

% adjust a-domain specific actions
occurs(object(robot,R),action(pickup,()),T) :- newpickup(R,T,S,N).
occurs(object(robot,R),action(putdown,()),T) :- newputdown(R,T,N).
occurs(object(robot,R),action(deliver,D),T+W1+W2) :- time(T), deliver(R,T,D,N), wait(R,T,W1), dodget(R,T,W2), N>0.

% show merged plan
#show occurs/3.

% used for debugging
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
%#show tdifft/3.
%#show prepickup/3.
%#show predeliver/4.
%#show reppos/4.
%#show lock/1.
%#show carry/4.
%#show pickup/4.
%#show putdown/3.
%#show deliver/4.
%#show shelf/3.



