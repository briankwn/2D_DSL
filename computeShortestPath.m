function computeShortestPath()


while(open.peek() < StartNode || StartNode.rhs > StartNode.g)
    u = open.peek();
    u_old = copyobj(open.peek()); %need to make a copy of this node... 
    u.DSL_computeKeys();
    
    if(u_old < u) %comparing node objects compares their keys
        %remove and re-add u in order to re-sort it in the queue, value
        %should already be recomputed
    elseif u.g > u.rhs %---- over consistent 
        u.g = u.rhs;
        open.remove(u);
        for s=1:pred %all nodes in predecessors... potential place for expansion - can use this as a place to look around and check against the graph
            if s ~= goal
                s.rhs = min(s.rhs,u.g + distance(s,u)); %this needs some noodling
                updateVertex(s);
            end
        end
    else % ---- under consistent 
        g_old = u.g;
        u.g = Inf; % Can't be this easy... 
        for s=1:pred %definite expansion point - might be worth its own method
            if(s.rhs == distance(s,u) + g_old) %c value here that I still don't entirely understand
                if s == sgoal
                    s.rhs %recompute rhs from successors...
                end
            end
            updateVertex(s)
        end
    end
    
    %todo
    %figure out what c function is
    %figure out "predecessors concept" and expansion
    %

end