function best_tour = simulated_annealing(starting_tour,iteration_limit,threshold,distance_matrix)
current_tour=starting_tour;

k=0;
cost_old = 0;
cost_new = 1;
%loop while, breakkato quando c'è il return della funzione
while(k<iteration_limit && abs(cost_new - cost_old )> threshold )

    T=1-(k+1)/iteration_limit;
    %estraggo neighborhood tramite 2-opt
    current_neighborhood = twoopt(current_tour);
    %estraggo elemento random da neighborhood
    index_random = randi([1,size(current_neighborhood,1)],1,1);
    %setto nuova possiblità
    new = current_neighborhood(index_random,:,:);
    
    new=transpose(new);

    cost_old = cost_calculation(tourexpander(current_tour),distance_matrix);  

    cost_new = cost_calculation(tourexpander(new),distance_matrix);
    p=min(1,exp(-(cost_new-cost_old)/T));
    
    c=rand;
    %simulo scelta con la probabilità
    if c < p
        current_tour = new;
    end
    k=k+1;
end
best_tour = new;

end 



