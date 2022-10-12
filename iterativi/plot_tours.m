function plot_routes = plot_tours(n,tours,coordinates)

A=zeros([n,n]);
tours_simple=tours;
%costruzione matrice di adiacenza
for i = 1:length(tours)
    tours{i}=tourexpander(tours{i});
    for j = 1:length(tours{i})

A(tours{i}(j,1),tours{i}(j,2))=1;
A(tours{i}(j,2),tours{i}(j,1))=1;

    end
end

x=coordinates(:,1);
y=coordinates(:,2);
%plot del grafo

G= graph(A);
h = plot(G,'XData',x,'YData',y);
%estrazione dei colori random per i subgraph associati ai singoli TSP
for i = 1:size(tours,2)
randcolor = [(rand) (rand) (rand)];
highlight(h,tours_simple{i},'EdgeColor',randcolor,'NodeColor',randcolor)
end



end