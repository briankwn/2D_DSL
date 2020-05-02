function comp_res = DSL_compare(key_a, key_b)

%Compare keys for D* lite -- re-did this with overriding gt, lt, eq in
%DSL_Node() class
%
% returns true if key_a greater than key_b
%
%keys have attributes of (g(or rhs) + heuristic , g(or rhs) )
%
%
%key(1) first comparison
%key(2) tie breaker

if(key_a(1) == key_b(1))
    comp_res = key_a(2) > key_b(2);
else
    comp_res = key_a(1) > key_b(1);
end

%need to figure out what k_m is in the paper... looks like it's updated in
%the main loop as a modified heuristic

end

