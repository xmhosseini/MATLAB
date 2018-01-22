% A visualization  of  Q-learning in MATLAB that
% finds  an optimal  policy for  traversing a  5x5 
% grid  world  with  four  actions  that move one 
% step in the standard compass directions. Each 
% episode  starts  with  the  learner in the upper 
% left  corner state  and  ends  when the learner 
% enters the  lower  right corner state. Attempts 
% to move off the edges of the grid world should 
% result in the walker staying in the same state. 
% A reward structure  that  causes the learner to
% minimize the number of steps has been chosen 
% such  that  when  the walker hits the borders it 
% is  rewarded -1,  otherwise 0.  The  Q-table  is 
% initialized to all zeroes.
