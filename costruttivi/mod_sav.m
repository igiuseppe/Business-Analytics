function [savings] = mod_sav(n,opt,savings)
%funzione che modifica la matrice dei savings mettendo a zero le entrate
%corrispondenti alle route ottimali 
for i=2:n
    for j=2:n
        if in_opt_route(opt,i) && in_opt_route(opt,j)
            savings(i,j)=0;
        end
    end
end

end

