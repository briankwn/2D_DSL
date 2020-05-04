
global U s_start



for i=1:U.size()
   
    temp1 = U.remove;
   
    if i > 1
        if temp1 > temp2
            disp('queue order correct')
        elseif temp1 == temp2
            disp('duplicate found')
        else
            disp('------order incorrect')
        end
    end

    if temp1 < s_start

        disp('====end condition fail')
    else
        disp('end condition pass')
    end
    
    temp2 = temp1;
    
end


% for i=1:U.size()
%     testqueue{i} = U.remove();
%     
%     if i > 1
%         res_queue{i} = testqueue{i} > prev;
%         if ~res_queue{i}
%             disp('queue doesnt work')
%         end
%     end
%     prev = testqueue{i};
% end