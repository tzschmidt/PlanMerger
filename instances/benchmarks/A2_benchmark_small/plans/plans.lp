% ROBOT 1
occurs(object(robot,1),action(move,(1,0)),1).
occurs(object(robot,1),action(move,(1,0)),2).
occurs(object(robot,1),action(move,(1,0)),3).
occurs(object(robot,1),action(move,(1,0)),4).
occurs(object(robot,1),action(pickup,()),5).
occurs(object(robot,1),action(move,(0,-1)),6).
occurs(object(robot,1),action(move,(-1,0)),7).
occurs(object(robot,1),action(move,(-1,0)),8).
occurs(object(robot,1),action(deliver,(1,1,1)),9).
occurs(object(robot,1),action(move,(-1,0)),10).
occurs(object(robot,1),action(putdown,()),11).

% ROBOT 2
occurs(object(robot,2),action(move,(0,-1)),1).
occurs(object(robot,2),action(pickup,()),2).
occurs(object(robot,2),action(move,(0,-1)),3).
occurs(object(robot,2),action(deliver,(1,2,1)),4).
occurs(object(robot,2),action(move,(-1,0)),5).
occurs(object(robot,2),action(putdown,()),6).
