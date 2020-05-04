function edge_cost = cost(u,v, Map)
%cost of moving from one node to a neighbor, returns inf if either node is
%an obstacle or the nodes aren't adjacent, 1 if they're both open space and
%adjacent

global MAP

%default to global MAP, override for obstacle changes - consider making
%diagonals more expensive. also consider making moving diagonal through an
%obstacle impossible

if nargin < 3
    Map = MAP;
end

nodes_are_adjacent = abs(u.x - v.x) < 2 && abs(u.y - v.y) < 2;

if (Map(u.x,u.y) == -1 || Map(v.x,v.y) == -1 || ~nodes_are_adjacent) %either of the nodes is an obstacle or nodes aren't adjacent
    edge_cost = inf;
%penalize diagonals    
elseif abs(u.x - v.x) == 1 && abs(u.y - v.y)
    edge_cost = sqrt(2);

else
    edge_cost = 1;
end

end
