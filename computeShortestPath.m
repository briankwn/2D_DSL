function computeShortestPath()
%computes the shortest path 
global U s_start push_num pop_num display_expansion


DSL_computeKeys(s_start);
while(U.peek() < s_start || s_start.rhs ~= s_start.g)
  
    
    u = U.remove(); %pop u 
    pop_num = pop_num + 1;

    u_old = DSL_Node(u.x,u.y,u.g,u.rhs);%need to make a copy of this node for comparison... 
    u_old.Key1 = u.Key1;
    u_old.Key2 = u.Key2;
    
    DSL_computeKeys(u);
    
    if(u_old < u) %comparing node objects compares their keys
        U.insert(u);
        push_num = push_num + 1;

    elseif u.g > u.rhs %---- locally over consistent, relax down 
        if display_expansion
            plot(u.x+.5,u.y+.5,'ch'); %uncomment to show which nodes are being fully expanded/relaxed
            pause(.1)
        end
        
        u.g = u.rhs;
        preds = getPreds(u);
        for s_ind=1:length(preds) 
            s = preds{s_ind};
            updateVertex(s);         
        end
        
    else % ---- locally under consistent - set g to inf and throw it back on the queue for re-expansion next round
        u.g = Inf;
        preds = getPreds(u);
        preds{end + 1} = u; %dropping u back on the queue for the next round
        for s_ind=1:length(preds)
            s = preds{s_ind};
            updateVertex(s)
        end
    end
    DSL_computeKeys(s_start);
end

end