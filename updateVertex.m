function updateVertex(u)

global U

%remove if the vertex needing updating is in the queue
if U.contains(u)
    U.remove(u);
end

if u.g ~= u.rhs %add it back to the queue if it's locally inconsistent - this means we need to consider it for a shorter path
    DSL_computeKeys(u);
    U.insert(u);
end



%%pseudocode from paper - simplifies when your update function's just a
%%remove and re-add... likely will be a performance hit here though
% if g ~= rhs && u in U
%     U.update(u,calculateKey(u));
% 
% else if g ~= rhs && u not in U
%     U.insert(u,calculateKey(u));
% else if g == rhs && u in U
%    U.remove(u);         
% end



end