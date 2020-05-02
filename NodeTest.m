clear all

tN = DSL_Node(2);
otN = DSL_Node(3);

tN.g;
tN.Key1 = 3;
tN.Key2 = 4;

otN.Key1 = 3;
otN.Key2 = 1;

% disp(otN.Key1)
% 
% one = otN.Key1;
% two = tn.Key1;
% 
% srsly = one == two
% huh = otN.Key2 == otN.Key2

celltest = {};

celltest{1} = otN;
celltest{2} = tN; 

% tN > otN
% 
% tN < otN
% 
% tN == otN


disp(celltest{2})

celltest{1} > celltest{2}

celltest{1} < celltest{2}

celltest{1} == celltest{2}