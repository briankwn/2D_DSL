function preds = getPreds(node)

%technically all neighbors are preds
global MAX_X
global MAX_Y
global node_Grid


pred_count=1;

for i=-1:1:1
    for j=-1:1:1
        pred_x = node.x + i;
        pred_y = node.y + j;
        if( ~(i == 0 && j == 0) && ...
                pred_x <= MAX_X && pred_y <= MAX_Y ...
                && pred_x >0 && pred_y >0) %if not current, and not out of bounds
            
            preds(pred_count) = node_Grid(pred_x,pred_y);
            pred_count = pred_count +1;
        end
    end
end

end