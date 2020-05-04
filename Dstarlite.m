%Implementation of D* Lite algorithm 
%
%Brian Kwon 2020
%

clear all
close all

%control variables
makemap = 0;
sensor_dist = 2;


%DEFINE THE 2-D MAP ARRAY
global MAX_X MAX_Y
MAX_X=30;
MAX_Y=30;
MAX_VAL=30;
%This array stores the coordinates of the map and the 
%Objects in each coordinate
global MAP
MAP=2*(ones(MAX_X,MAX_Y));

global node_Grid
node_Grid = cell(MAX_X,MAX_Y);

for i=1:MAX_X
    for j=1:MAX_Y
        node_Grid{i,j} = DSL_Node(i,j,Inf,Inf);
    end
end

%% map generation
if makemap


    % Obtain Obstacle, Target and Robot Position
    % Initialize the MAP with input values
    % Obstacle=-1,Target = 0,Robot=1,Space=2

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
        MAP(xval,yval)=-2;  %this value is better as -2 for dynamic obstacles that we want revealed later, -1 for static ones revealed at the start. potentially add a section in the future for static + dynamic selection
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

    plot(xStart+.5,yStart+.5,'bo');
    text(xStart+1,yStart+.5,'Start')

    save('map.mat','MAP'); %save map for future use



else

    
    axis([1 MAX_X+1 1 MAX_Y+1])
    %draw grid
    xticks(1:MAX_X);
    yticks(1:MAX_Y);
    %get rid of numbers on axis labels
    xticklabels({});
    yticklabels({});
    grid on;
    hold on;
    
    load('map.mat');
    for i=1:size(MAP,1)
        for j=1:size(MAP,2)
            if MAP(i,j) == 0
                xTarget = i;
                yTarget = j;
                
                plot(xTarget+.5,yTarget+.5,'gd');
                text(xTarget+1,yTarget+.5,'Target')
            end
            if MAP(i,j) == 1
                xStart = i;
                yStart = j;
                
                plot(xStart+.5,yStart+.5,'bo');
                text(xStart+1,yStart+.5,'Start')
                
            end
            if MAP(i,j) == -2
                plot(i+.5,j+.5,'ro');
            end
        end
    end



    
    
end



%% initialize start/end nodes from values, then start the algo
global s_start
global s_goal

s_goal = node_Grid{xTarget, yTarget};%DSL_Node(xTarget, yTarget, Inf, 0);
s_start = node_Grid{xStart,yStart}; % DSL_Node(xStart, yStart, Inf, Inf);

%heuristic adjustment from focussed D* - this prevents constant queue
%rearranging
global km
km = 0;

s_goal.rhs = 0;
DSL_computeKeys(s_goal); %get the heuristic set up on s_goal

%tic

%initialize U and closed
global U
U = PriorityQueue();

%insert all obstacles onto closed

%put start on queue
U.insert(s_goal);

global s_last old_MAP
s_last = s_start;
computeShortestPath();
opt_path = [];

changecount = 0;

while(~s_start.pos_equal(s_goal)) %reminder to test this with full equals - should theoretically work if assignments are working right
    if(s_start.rhs ~= inf) %path is still available
        [exists, s_start] = getMinSucc(s_start);
        current_pos = s_start; %move to start, this is kind of implicitly done above...
        
        %% section for adding/removing dynamic obstacles and plotting the bot
            %re-display bot
            children = get(gca, 'children');
            delete(children(1)); %deleting only the text provides a 'trail' of robots to see the path. can look at a better solution for this in the future.

            old_MAP = MAP; %store off previous map for comparison
            
            %scan around the robot in order to 'discover' obstacles - could
            %probably do this in a more vectorized manner, sweep with a
            %kernel etc
            for i=current_pos.x - sensor_dist : current_pos.x + sensor_dist
                for j =current_pos.y- sensor_dist : current_pos.y + sensor_dist
                    inbounds = i <= MAX_X && j <= MAX_Y && i >0 && j >0; %bound check so we don't try and update outside the map
                    if inbounds && MAP(i,j) == -2
                        MAP(i,j) = -1;
                        plot(i+.5,j+.5,'m*'); %plot the object as 'discovered'
                    end
                end
            end

            %plot the visible area around the robot as visited, or just
            %plot obstacles in different colors as they're "discovered"
            
            plot(current_pos.x+.4,current_pos.y+.4,'bo');
            text(current_pos.x+.5,current_pos.y-.5,'Robot');
            
            pause(.1); %pause for animation, probably should nest this in a state/conditional/flag for speed tests
            
        
    
        %% dealing with dynamic obstacles
        [changed, changed_nodes] = findChangedNodes();
        if changed

            km = km + computeH(s_last, s_start); %-h_last_start in our case is almost always 1, but technically the heuristic between this node and the last
            s_last = s_start;
            
            for edge_ind=1:length(changed_nodes) %any changed node, plus all neighbors
                c_node = changed_nodes{edge_ind}; %this is u in the paper
                
                %updateVertex(c_node)
                 
                 preds = getPreds(c_node);
                 for pred_ind = 1:length(preds)
                     pred = preds{pred_ind}; %this is v in the paper
                     updateVertex(pred);
%                     c_old = cost(c_node, pred, old_MAP);
%                     c_new = cost(c_node, pred);
%                     if c_old ~= c_new %cycling through all possibly changed edges since edges aren't explicitly stored
%                         
                 end
%                 end
            end
            %s_start.rhs = Inf; %try this to see if it forces relaxation
            computeShortestPath(); %get the new shortest path
        end

    else
        %maybe set a variable here for cleanliness
        disp("I'm sorry Dave, I'm afraid I can't do that") %print humor when path is impossible
   end
end



%toc
    
    
    