function bestroutes = sweepandanneal(x,y, demand,capacity,number)
capacities= repmat(capacity,number);
capacities = capacities(:,1);
coordinates=zeros(length(x),2);
coordinates(:,1)=x;
coordinates(:,2)=y;
customers=customers_generator(coordinates, demand);
distance_matrix=distance_matrix_generator(customers);

angle_step=0.001;% step dell'update dell'angolo
angle_sensitivity=0.01; %distanza minima di contatto tra i nodi e la semiretta
radii_vector = sqrt(customers(:,1).^2 + customers(:,2).^2); %vettore dei raggi pre-computato
clustering=sweep_cluster(customers,capacities,angle_step,angle_sensitivity,radii_vector); 
iteration_limit=5000; %limite sul simulated annealing
threshold = 0.1; %threshold di vicinanza per lo stop del  simulate annealing
total_cost=0; 


tours={};
for i=1:max(clustering(:,5))
%estraggo i singoli cluster per inizializzare i TSP
cluster = clustering(clustering(:,5)==i,:);

tour = cluster(:,4);

tour= transpose([1,transpose(tour),1]);


if size(tour,1) ~= 1
inner_cost=0;
%calcolo la soluzione con simulated annealing
sol = simulated_annealing(tour,iteration_limit,threshold,distance_matrix);
%calcolo il costo per il singolo TSP
inner_cost=inner_cost+cost_calculation(tourexpander(sol),distance_matrix);

tours{end+1}=(sol);
%calcolo il costo totale aggiornato
total_cost=total_cost + inner_cost;
end
end
disp(total_cost)
%plot della soluzione 
plot_tours(length(coordinates),tours,coordinates)
bestroutes=tours;
end
