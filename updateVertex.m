function updateVertex(u)

global U s_goal

if ~u.pos_equal(s_goal)
    [exists, minSucc] = getMinSucc(u);
    if exists
        u.rhs = cost(u,minSucc) + minSucc.g;
        %plot(u.x+.5,u.y+.5,'g+'); %visualization to show vertices actually expanded
    else
        u.rhs = Inf;
        %plot(u.x+.2,u.y+.2,'r+'); %visualization to show vertices actually expanded
    end
end

%remove if the vertex needing updating is in the queue - need to run tests
%with/without the remove function on the queue. somehow it seems to stay
%consistent
put_these_back = {};
if U.contains(u)
    
    %hack for remove
    remove_temp = U.remove(); %have to resort to using pop/push remove since the built in remove function doesn't bubble
    while (remove_temp ~= u)
        put_these_back{end+1} = remove_temp; %hopefully minimizing the damage by pulling off/putting back in order
        remove_temp = U.remove();
    end
    for i=1:length(put_these_back)
        U.insert(put_these_back{i});
    end
    %end hack
    
%     U.remove(u);
    %test
    if U.contains(u)
        disp('remove seems to have failed')
    end
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