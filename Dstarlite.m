%Implementation of D* Lite algorithm 
%
%Brian Kwon 2020
%

clear all
close all

%DEFINE THE 2-D MAP ARRAY
MAX_X=30;
MAX_Y=30;
MAX_VAL=30;
%This array stores the coordinates of the map and the 
%Objects in each coordinate
MAP=2*(ones(MAX_X,MAX_Y));

node_Grid = cell(MAX_X,MAX_Y);

for i=1:MAX_X
    for j=1:MAX_Y
        node_Grid{i,j} = DSL_Node(i,j,Inf,Inf);
    end
end

disp(node_Grid)

% Obtain Obstacle, Target and Robot Position
% Initialize the MAP with input values
% Obstacle=-1,Target = 0,Robot=1,Space=2

%potential new idea - Obstacle = inf, Space = 1, robot =2, target =3
j=0;
x_val = 1;
y_val = 1;
axis([1 MAX_X+1 1 MAX_Y+1])
%draw grid
xticks(1:MAX_X);
yticks(1:MAX_Y);
%get rid of numbers on axis labels
xticklabels({});
yticklabels({});
grid on;
hold on;
n=0;%Number of Obstacles

%might be worth it to randomly generate obstacles... for now we should
%click and have a way to set "rounds" of clicking

%% BEGIN Interactive Obstacle, Target, Start Location selection
pause(1);
h=msgbox('Please Select the Target using the Left Mouse button');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('Please Select the Target using the Left Mouse button','Color','black');
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1);
end
xval=floor(xval);
yval=floor(yval);
xTarget=xval;%X Coordinate of the Target
yTarget=yval;%Y Coordinate of the Target

% %%%%%%manual override - change comments for quicker testing
% xTarget=25;%X Coordinate of the Target
% yTarget=25;%Y Coordinate of the Target

MAP(xTarget,yTarget)=0;%Initialize MAP with location of the target
plot(xTarget+.5,yTarget+.5,'gd');
text(xTarget+1,yTarget+.5,'Target')

%% initialize obstacles
pause(2);
h=msgbox('Select Obstacles using the Left Mouse button,to select the last obstacle use the Right button');
  xlabel('Select Obstacles using the Left Mouse button,to select the last obstacle use the Right button','Color','blue');
uiwait(h,10);
if ishandle(h) == 1
    delete(h);
end
while but == 1
    [xval,yval,but] = ginput(1);
    xval=floor(xval);
    yval=floor(yval);
    MAP(xval,yval)=-1;
    plot(xval+.5,yval+.5,'ro');
end
 
pause(1);

%% initialize start/robot


h=msgbox('Please Select the Vehicle initial position using the Left Mouse button');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('Please Select the Vehicle initial position ','Color','black');
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1);
    xval=floor(xval);
    yval=floor(yval);
end
xStart=xval;%Starting Position
yStart=yval;%Starting Position
MAP(xval,yval)=1; %Initialize MAP with location of the start - going to do this in between every iteration
 plot(xval+.5,yval+.5,'bo');
 
% %%%%%manual override for less clicking
% xStart=5;%X Coordinate of the Start
% yStart=5;%Y Coordinate of the Start

MAP(xval,yval)=1;
plot(xStart+.5,yStart+.5,'bo');
text(xStart+1,yStart+.5,'Start')



%% initialize start/end nodes from values, then start the algo
%todo
%save map out for next time, add re-plot capabilities, extract start,
%obstacles, end from MAP - might be good to have this as an object for
%easier use
save('map.mat','MAP');


s_goal = node_Grid{xTarget, yTarget};%DSL_Node(xTarget, yTarget, Inf, 0);
s_start = node_Grid{xStart,yStart}; % DSL_Node(xStart, yStart, Inf, Inf);

%heuristic adjustment from focussed D* - this prevents constant queue
%rearranging
km = 0;

s_goal.rhs = 0;
DSL_computeKeys(s_goal, s_start, km); %get the heuristic set up on s_goal

%tic

%initialize U and closed
U = PriorityQueue();

%insert all obstacles onto closed

%put start on queue
U.insert(s_goal);



s_last = s_start;
computeShortestPath();
while(~s_start.pos_equal(s_goal)) %reminder to test this with full equals - should theoretically work if assignments are working right
    if(s_start.rhs ~= inf) %path is still available
       
    else
        %maybe set a variable here for cleanliness
        disp('path cannot be computed')
    end
    s_start = getMinSucc(s_start);
    current_pos = s_start; %move to start, this is kind of implicitly done above...
% %     changed = scanForChanges();
% %     if changed
% %         k_m = km + h_last_start; %-h_last_start in our case is almost always 1, but technically the heuristic between this node and the last
% %         s_last = s_start;
% %         for uv=1:changededges
% %             c_old = c(u,v);
% %             % if u ~= s_goal 
% %             %update edge cost ---
% %             if(c_old > c(u,v))
% %                 %if u~= s_goal
% %                 %recompute rhs
% %             else
% %                 %recompute rhs differently
% %             end
% %             updateVertex(u);
% %         end
% %         computeShortestPath();
% %     end
end
   
%toc
    

%todo

%InitializeDstar
%InitializeMap
%what the heck is C - feel like it's just cost between nodes
%details on heuristic
%heuristic determine first-last - think decent on this
%determine rhs recomputes
%what do they mean by u,v indexing
%argmin successors of start?
%scan for changes?
%re-evaluate equals for end condition

%"expansion" - done whenever looking through successors, =1 if that
%neighbor is walkable, = inf if that neighbor is obstacle

%first empty map
%way to store and reuse maps
%multi-map for dynamic obstacles


%to finish: computeShortest path, Dstarlight, 
    



    