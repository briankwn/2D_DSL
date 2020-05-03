function succ = getMinSucc(node)

preds = getPreds(node);

min_g = inf;
for i=1:length(preds)
    new_g = cost(node,preds{i}) + preds{i}.g; 
    if new_g < min_g
       min_g=new_g;
       succ = preds{i};
    end
end