function [savings] = get_savings(n,cost,demand,capacity)
%funzione che crea la matrice dei savings 

%decido di mettere a zero le entrate in cui il vincolo di capacità non
%permette la creazione di una route
savings=zeros(n,n);
for i=2:n
    for j=2:n
        savings(i,j)=max(cost(i,1)+cost(1,j)-cost(i,j),0);
        if (demand(i)+demand(j)>capacity) || i==j
            savings(i,j)=0;
        end 
    end
end

end

