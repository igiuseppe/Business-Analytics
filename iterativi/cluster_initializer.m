function tour = cluster_initializer(cluster)
%inizializzo i tour per i singoli cluster nell'ordine in cui vengono
%scoperti dallo sweep. (partendo sempre e finendo sempre col magazzino)
n=size(cluster,1);
tour=zeros([n+1,2]);
tour(1,1)=1;
tour(1,2)=cluster(1,4);


for i =2:n
    tour(i,1) = tour(i-1,2);
    tour(i,2) = cluster(i,4); % ordino rispetto all'ordine con cui sono stati messi dal cluster
end

tour(n+1,2)=1;
tour(n+1,1)=cluster(n,4);
end