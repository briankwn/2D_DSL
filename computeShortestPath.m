function computeShortestPath()
%computes the shortest path 
global U s_start s_goal


DSL_computeKeys(s_start);
while(U.peek() < s_start || s_start.rhs > s_start.g)
    u = U.peek();
    
    u_old = DSL_Node(u.x,u.y,u.g,u.rhs);%need to make a copy of this node... 
    u_old.Key1 = u.Key1;
    u_old.Key2 = u.Key2;
    
    DSL_computeKeys(u);
    
    if(u_old < u) %comparing node objects compares their keys
        U.remove(u);
        U.insert(u);
        %remove and re-add u in order to re-sort it in the queue, value
    elseif u.g > u.rhs %---- locally over consistent, relax down 
        u.g = u.rhs;
        u = U.remove(u);
        preds = getPreds(u);
        for s_ind=1:length(preds) 
            s = preds{s_ind};
            if ~ s.pos_equal(s_goal)
                s.rhs = min(s.rhs, u.g + cost(s,u)); 
                updateVertex(s);
            end
        end
    else % ---- locally under consistent 
        g_old = u.g;
        u.g = Inf;
        preds = getPreds(u);
        preds{end + 1} = u; %dropping u back on the queue for the next round
        for s_ind=1:length(preds)
            s = preds{s_ind};
            if(s.rhs == cost(s,u) + g_old) 
                if ~ s.pos_equal(s_goal) %note to test without this pos_equal thing. realistically not necessary.
                    [succ_exists, s_min_pred] = getMinSucc(s);
                     if succ_exists
                        s.rhs = cost(s,s_min_pred) + s_min_pred.g; %recompute rhs from min of successors
                     else
                         s.rhs = Inf; %handle case where all successors are inf
                     end
                end
            end
            updateVertex(s)
        end
    end
    %DSL_computeKeys(s_start); %redundant
end