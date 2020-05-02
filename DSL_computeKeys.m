function DSL_computeKeys(node, km)
% this in theory just takes s, which has attributes
%computing key for node given g, rhs, h, km value
%
%eventually build in error handling via boolean return

node.key2 = min(node.g,node.rhs);

%potentiall update heuristic here

node.key1 = node.key2 + node.h + km;

end