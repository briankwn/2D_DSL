function DSL_computeKeys(node)
% 
% computing key for node given g, rhs, h, km value
%
%

global s_start km

node.Key2 = min(node.g,node.rhs);


node.Key1 = node.Key2 + computeH(s_start ,node) + km;

end