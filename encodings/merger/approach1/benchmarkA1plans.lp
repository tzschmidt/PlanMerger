% ROBOT 1
occurs1(object(robot,1),action(move,(1,0)),1).
occurs1(object(robot,1),action(move,(1,0)),2).
occurs1(object(robot,1),action(move,(1,0)),3).
occurs1(object(robot,1),action(move,(1,0)),4).
occurs1(object(robot,1),action(pickup,()),5).
occurs1(object(robot,1),action(move,(0,-1)),6).
occurs1(object(robot,1),action(move,(-1,0)),7).
occurs1(object(robot,1),action(move,(-1,0)),8).
occurs1(object(robot,1),action(deliver,(1,1,1)),9).
occurs1(object(robot,1),action(move,(-1,0)),10).
occurs1(object(robot,1),action(putdown,()),11).

% ROBOT 2
occurs1(object(robot,2),action(move,(0,-1)),1).
occurs1(object(robot,2),action(pickup,()),2).
occurs1(object(robot,2),action(move,(0,-1)),3).
occurs1(object(robot,2),action(deliver,(1,2,1)),4).
occurs1(object(robot,2),action(move,(-1,0)),5).
occurs1(object(robot,2),action(putdown,()),6).
