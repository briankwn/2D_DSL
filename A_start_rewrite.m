

%DEFINE THE 2-D MAP ARRAY
MAX_X=30;
MAX_Y=30;
MAX_VAL=30;
%This array stores the coordinates of the map and the 
%Objects in each coordinate
MAP=2*(ones(MAX_X,MAX_Y));

% Obtain Obstacle, Target and Robot Position
% Initialize the MAP with input values
% Obstacle=-1,Target = 0,Robot=1,Space=2
j=0;
x_val = 1;
y_val = 1;
axis([1 MAX_X+1 1 MAX_Y+1])
grid on;
hold on;
n=0;%Number of Obstacles


%%%%%change start coords here
xStart=5;%X Coordinate of the Start
yStart=5;%Y Coordinate of the Start

MAP(xval,yval)=0;%Initialize MAP with location of the start
plot(xStart+.5,yStart+.5,'bo');
xticks(1:MAX_X);
xticklabels({});
yticks(1:MAX_Y);
yticklabels({});
text(xStart+1,yStart+.5,'Start')



%%%%%%change target coords here
xTarget=25;%X Coordinate of the Target
yTarget=25;%Y Coordinate of the Target

MAP(xTarget,yTarget)=0;%Initialize MAP with location of the target
plot(xTarget+.5,yTarget+.5,'gd');
xticks(1:MAX_X);
yticks(1:MAX_Y);
text(xTarget+1,yTarget+.5,'Target')


% NodeStructure

StartNode.x = 0;
StartNode.y = 0;
%StartNode.Parent
StartNode.g = 0;
StartNode.h = 0;
StartNode.f = 0;

TestNode.x = 0;
TestNode.y = 0;
%StartNode.Parent
TestNode.g = 0;
TestNode.h = 0;
TestNode.f = 2;

struct2cell(TestNode)'

%tic

%initialize open and closed
open = PriorityQueue(StartNode.f);
closed = PriorityQueue(StartNode.f);

%insert all obstacles onto closed

%put start on open
open.insert(StartNode);
open.insert(TestNode);
%put start on closed

open.peek();

%while no end is found

    %expand and check cost of neighbors
    %for each expanded neighbor
        %if not in closed
           %if new path shorter or not in open
                %calculate fcost (path + heuristic)
                %set parent of neighbor to current node
                %if not in open, add to open
    %pop minqueue(find lowest cost node and make current)
    %add popped value to closed
    
%follow parents back and export
%toc
    




