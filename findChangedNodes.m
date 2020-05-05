function [foundChanges,changedNodes] = findChangedNodes()
%scan through the graph, find nodes that have changed, add them to a list
%for updating

global MAX_X MAX_Y MAP old_MAP node_Grid

foundChanges = 0; %default to not having found any changes
changedNodes = {};

for i=1:MAX_X %really hate looping but using a boolean index on a cell array isn't working - look at cellfun for this in the future
    for j=1:MAX_Y
        if MAP(i,j) ~= old_MAP(i,j) %found change
%             if ~containsNode(changedNodes,node_Grid{i,j})
                changedNodes{end + 1} = node_Grid{i,j};
%             end
            preds = getPreds(node_Grid{i,j});
            for pred_i=1:length(preds)
%                 if ~containsNode(changedNodes,preds{pred_i})
                    changedNodes{end+1} = preds{pred_i};
%                 end
            end
        end
    end
end

if ~isempty(changedNodes)
    foundChanges = 1;
end

    function contains = containsNode(CN, node) %this is a silly way to have to dedup. 
        contains = 0;
        for cn_ind=1:length(CN)
            if CN{cn_ind} == node
                contains = 1;
                return
            end
        end
    end

end
