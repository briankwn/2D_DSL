function edge_cost = cost(u,v)
%cost of moving from one node to a neighbor, returns inf if either node is
%an obstacle or the nodes aren't adjacent, 1 if they're both open space and
%adjacent

nodes_are_adjacent = abs(u.x - v.x) < 2 && abs(u.y - v,y) < 2;

if (MAP(u.x,u.y) == -1 || MAP(v.x,v.y) == -1 || ~nodes_are_adjacent) %either of the nodes is an obstacle or nodes aren't adjacent
    edge_cost = inf;
else
    edge_cost = 1;
end

end
