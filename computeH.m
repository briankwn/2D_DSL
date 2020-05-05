function h_val = computeH(node_a, node_b)
%keeping it simple with euclidian distance for now. Could evaluate
%min(xdist,ydist) in the future - realistically will look at a diagonal
%calculation later

%distance
h_val = sqrt((node_a.x - node_b.x)^2 + (node_a.y - node_b.y)^2);

%from Koenig Likhachev
%h_val = max(abs(node_a.x - node_b.x),abs(node_a.y - node_b.y));

end