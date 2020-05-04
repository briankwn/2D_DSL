classdef DSL_Node < handle
    %DSL_NODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x
        y
        g
        rhs
        Key1
        Key2
    end
    
    methods
        function obj = DSL_Node(x_, y_, g_, rhs_)
            %DSL_NODE Construct an instance of this class
            %   Things needed for a node... x, y, g, h rhs, key1, key2. g
            %   and rhs default to inf
            obj.x = x_;
            obj.y = y_;
            obj.g = g_;
            obj.rhs = rhs_;
            obj.Key1 = Inf; %default set key to Inf until computeKey is called
            obj.Key2 = Inf;
            
        end
        
        function boolout = gt(a,b)
            %overriding greater than
            %   compares keys - really should do error handling if no Key
            %   exists, or put Key initialization in the constructor
            if(a.Key1 == b.Key1)
                boolout = a.Key2 > b.Key2;
            else
                boolout = a.Key1 > b.Key1;
            end
        end
        
        function boolout = lt(a,b)
            %overriding less than
            %   compares keys
            if(a.Key1 == b.Key1)
                boolout = a.Key2 < b.Key2;
            else
                boolout = a.Key1 < b.Key1;
            end
        end
        
        function boolout = eq(a,b)
            %overriding equals
            %   compares keys
            boolout = a.x == b.x && a.y == b.y; %a.Key1 == b.Key1 && a.Key2 == b.Key2;
        end
        
        function boolout = pos_equal(a,b)
            boolout = a.x == b.x && a.y == b.y;
        end
        

    end
end

