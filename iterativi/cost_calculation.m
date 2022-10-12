function costs = cost_calculation ( tour, distance_matrix)
costs=0;

for i =1:length(tour)

costs = costs + distance_matrix(tour(i,1),tour(i,2));
end

end