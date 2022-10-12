
function bestroutes = sweepandanneal_fromsolutions(x,y, demand,solutions)
coordinates=zeros(length(x),2);
coordinates(:,1)=x;
coordinates(:,2)=y;
customers=customers_generator(coordinates, demand);
distance_matrix=distance_matrix_generator(customers);

iteration_limit=5000;
threshold = 0.001;
total_cost=0;


tours={};
for i=1:length(solutions)



tour = solutions{i};

tour= (transpose(tour));

disp(size(tour))
if size(tour,1) ~= 1
inner_cost=0;
sol = simulated_annealing(tour,iteration_limit,threshold,distance_matrix);
disp(sol)
inner_cost=inner_cost+cost_calculation(tourexpander(sol),distance_matrix);
tours{end+1}=(sol);
disp(tourexpander(sol))
total_cost=total_cost + inner_cost;
end
end
disp(total_cost)
plot_tours(length(coordinates),tours,coordinates)
bestroutes=tours;
end
