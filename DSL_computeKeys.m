function DSL_computeKeys(node)
% this in theory just takes s, which has attributes
%computing key for node given g, rhs, h, km value
%
%eventually build in error handling via boolean return

global s_start km

node.Key2 = min(node.g,node.rhs);

%potentiall update heuristic here

node.Key1 = node.Key2 + computeH(s_start ,node) + km;

end