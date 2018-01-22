% Written by Morteza Hosseini 
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


clc
clear all

N=5;  %Width and Length of the gridworld

x_curr=1; % X coordinate of the Random Walker
y_curr=1; % Y coordinate of the Random Walker
x_next=1; % Next X coordinate of the Random Walker
y_next=1; % Next Y coordinate of the Random Walker

gamma=0.95;
alpha=0.1;
steps=0;
steps_stored(1)=0;
episode=1;

Q = zeros(N);

for i = 1:500

reward=-1;    

 % Animation begins from here

 cursor = zeros(N);     % An N by N matrix of zeros
 cursor(x_curr,y_curr)=1;
 imagesc(cursor);            % Create a colored plot of the matrix values
 Texts = num2str(Q(:),'%0.2f');  % Create strings from the matrix values
 Texts = strtrim(cellstr(Texts));  % Remove any space padding
 [x,y] = meshgrid(1:N);   % Create x and y currs for the strings
 hStrings = text(x(:),y(:),Texts(:),...      %# Plot the strings
                 'HorizontalAlignment','center');         
 pause(0)
% pause is always necessery to be inserted between the frames when there is an animation 

% action policy3: take an action based on Q diffs      
x_l=x_curr-1;   y_l=y_curr;
x_u=x_curr;     y_u=y_curr-1;
x_r=x_curr+1;   y_r=y_curr;
x_d=x_curr;     y_d=y_curr+1;
% Taking care of borders
if x_l==0          x_l=1; end
if y_u==0          y_u=1; end
if x_r==N+1        x_r=N; end
if y_d==N+1        y_d=N; end

D=Q(x_d,y_d)-Q(x_curr,y_curr);
R=Q(x_r,y_r)-Q(x_curr,y_curr);
U=Q(x_u,y_u)-Q(x_curr,y_curr);
L=Q(x_l,y_l)-Q(x_curr,y_curr);
S=D+R+U+L;
MAX_FINDER= [D,R,U,L];

if         D<0&&R<0&&U<0 x_next=x_l;  y_next=y_l;  %left   
elseif 	R<0&&U<0&&L<0 x_next=x_d;  y_next=y_d;  %down
elseif 	U<0&&L<0&&D<0 x_next=x_r;  y_next=y_r;  %right
elseif 	L<0&&D<0&&R<0 x_next=x_u;  y_next=y_u;  %up
elseif  L<0&&U<0
    S=D+R;
    action = S*rand();
    if     action <D x_next=x_d;    y_next=y_d;  %down
    else             x_next=x_r;    y_next=y_r;  %right
    end
elseif  U<0&&R<0
    S=D+L;
    action = S*rand();
    if     action <D x_next=x_d;    y_next=y_d;  %down
    else             x_next=x_l;    y_next=y_l;  %left
    end
elseif  R<0&&D<0
    S=U+L;
    action = S*rand();
    if     action <U x_next=x_u;    y_next=y_u;  %up
    else             x_next=x_l;    y_next=y_l;  %left
    end
elseif  D<0&&L<0
    S=U+R;
    action = S*rand();
    if     action <U x_next=x_u;    y_next=y_u;  %up
    else             x_next=x_r;    y_next=y_r;  %right    
    end
elseif  L<0&&R<0
    S=U+D;
    action = S*rand();
    if     action <U x_next=x_u;    y_next=y_u;  %up
    else             x_next=x_d;    y_next=y_d;  %down    
    end
elseif  U<0&&D<0
    S=L+R;
    action = S*rand();
    if     action <L x_next=x_l;    y_next=y_l;  %left
    else             x_next=x_r;    y_next=y_r;  %right    
    end
elseif  L<0
    S=R+U+D;
    action = S*rand();
    if     action <R x_next=x_r;    y_next=y_r;  %right
    elseif action <U x_next=x_u;    y_next=y_u;  %up
    else             x_next=x_d;    y_next=y_d;  %down    
    end
elseif  U<0
    S=R+L+D;
    action = S*rand();
    if     action <R x_next=x_r;    y_next=y_r;  %right
    elseif action <L x_next=x_l;    y_next=y_l;  %left
    else             x_next=x_d;    y_next=y_d;  %down    
    end
elseif  R<0
    S=U+L+D;
    action = S*rand();
    if     action <U x_next=x_u;    y_next=y_u;  %up
    elseif action <L x_next=x_l;    y_next=y_l;  %left
    else             x_next=x_d;    y_next=y_d;  %down    
    end
elseif  D<0
    S=U+L+R;
    action = S*rand();
    if     action <U x_next=x_u;    y_next=y_u;  %up
    elseif action <L x_next=x_l;    y_next=y_l;  %left
    else             x_next=x_r;    y_next=y_r;  %right     
    end
else    
    S=U+L+R+D;
    action = S*rand();
    if     action <U x_next=x_u;    y_next=y_u;  %up
    elseif action <L x_next=x_l;    y_next=y_l;  %left
    elseif action <R x_next=x_r;    y_next=y_r;  %right       
    else             x_next=x_d;    y_next=y_d;  %down           
    end
end
    
 % next state and reward evaluation
if x_next*y_next==N*N reward=0; end

%  update Q
Q(x_curr,y_curr)=Q(x_curr,y_curr)+alpha*(reward+gamma*Q(x_next,y_next)-Q(x_curr,y_curr));
  
x_curr = x_next;
y_curr = y_next;

steps=steps+1;
% upon episode's termination
if reward==0 
    x_curr=1; 
    y_curr=1; 
    steps
    steps_stored(episode)=steps;
    episode=episode+1;    
    steps=0;
end

end
    
plot(steps_stored);
grid on

