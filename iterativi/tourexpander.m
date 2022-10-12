%questa fuznione espande un tour scritto come elenco di nodi in un insieme
%di coppie di nodi (a rappresentare le edge)
function tour = tourexpander(compressed_tour)
n = length(compressed_tour);
tour = zeros([n-1,2]);
for i=2:n-1
    tour(i,1)=compressed_tour(i);
    tour(i,2)=compressed_tour(i+1);
end
tour(1,1)=1;
tour(1,2)=compressed_tour(2);
tour(n-1,1) = compressed_tour(n-1);
tour(end,2)=1;
end