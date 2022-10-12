%classe che gestisce le route
classdef route
    properties
        nodes {mustBeNumeric}
        %nodi che compongono la route
    end
    methods
        %costruttore tramite seed
        function obj = route(val)
            if nargin == 1
                obj.nodes = val;
            end
        end

        %funzione che aggiunge un nodo alla route
        function obj=add_node(obj,val,begin)
            if begin
                obj.nodes=[val, obj.nodes];
            else
                obj.nodes=[obj.nodes, val];
            end
            
        end

        %funzione che unisce due routes
        function o1 = merge_routes(o1,o2)
            o1.nodes = [o1.nodes, o2.nodes];
        end

        %funzione che restituisce la route completa
        function r=get_route(obj)
            r=[1, obj.nodes, 1];
        end
        
        %funzione che restituisce il costo totale della route
        function r=get_cost(obj,cost)
            vec=get_route(obj);
            dist=0;
            for i=1:(length(vec)-1)
                dist=dist+cost((vec(i)),vec(i+1));
            end
            r=dist;
        end

        %funzione che restituisce il budget totale richiesto dalla route
        function r=get_budget(obj,demand)
            budget=0;
            for i=1:length(obj.nodes)
                budget=budget+demand(obj.nodes(i));
            end
            r=budget;
        end

        %funzione che controlla se un certo nodo è all'interno della route 
        function r=in_route(obj,val)
            log=(obj.nodes==val);
            r=sum(log)>=1;
        end

    end
end