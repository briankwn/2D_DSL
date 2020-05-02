function h_val = computeH(node_a, node_b)
%keeping it simple with euclidian distance for now. Could evaluate
%min(xdist,ydist) in the future

h_val = sqrt((node_a.x - node_b.x)^2 + (node_a.y - node_b.y)^2);


end