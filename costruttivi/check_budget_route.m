function [stop] = check_budget(r,routes,capacity,d)
%funzione che controlla se la route r può essere
%ulteriormente migliorata oppure il vincolo di capacità impone di fermare
%la ricerca
v=0;
if get_budget(r,d)==capacity
            stop=true;
else
    for i=1:length(routes)
        candidate1=add_node(r,routes(i),true);
        candidate2=add_node(r,routes(i),false);
        if (get_budget(candidate1,d)>capacity)
            v=v+1;
        end
        if (get_budget(candidate2,d)>capacity)
            v=v+1;
        end
    end
    stop=(v==2*length(routes));
end