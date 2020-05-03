function [exists, succ] = getMinSucc(node)

succ = nan;
exists = 0;

preds = getPreds(node);

min_g = inf;
for i=1:length(preds)
    new_g = cost(node,preds{i}) + preds{i}.g; 
    if new_g < min_g
       min_g=new_g;
       succ = preds{i};
       exists = 1;
    end
end