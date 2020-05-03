function [foundChanges,changedNodes] = findChangedNodes()
%scan through the graph, find nodes that have changed, add them to a list
%for updating

global MAX_X MAX_Y MAP old_MAP node_Grid

foundChanges = 0; %default to not having found any changes
changedNodes = {};

for i=1:MAX_X %really hate looping but using a boolean index on a cell array isn't working
    for j=1:MAX_Y
        if MAP(i,j) ~= old_MAP(i,j) %found change
            changedNodes{end + 1} = node_Grid{i,j};
            preds = getPreds(changedNodes{end});
            for pred_i=1:length(preds)
                changedNodes{end+1} = preds{pred_i};
            end
        end
    end
end

if ~isempty(changedNodes)
    foundChanges = 1;
end

end
