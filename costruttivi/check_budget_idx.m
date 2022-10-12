function [stop] = check_budget_idx(idx,routes,capacity,d)
%funzione che controlla se la route in posizione idx può essere
%ulteriormente migliorata oppure il vincolo di capacità impone di fermare
%la ricerca
r=routes(idx);
v=0;
if get_budget(r,d)==capacity
            stop=true;
else
    routes(idx)=[];
    for i=1:length(routes)
        candidate=merge_routes(r,routes(i));
        if (get_budget(candidate,d)>capacity)
            v=v+1;
        end
    end
    stop=(v==length(routes));
end

