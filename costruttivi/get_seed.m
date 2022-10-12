function [seed] = get_seed(cost,vehicles)
%funzione che crea i seed di partenza per l'algoritmo scegliendo i nodi più
%distanti fra di loro

seed=zeros(vehicles+1,1);
seed(1)=1;

[~,i]=max(cost(1,:));
seed(2)=i;

dim=size(cost);
customers=1:dim(1);

for i=3:length(seed)
    for c=1:length(customers)
        if ~ismember(c,seed)
            for j=1:i-1
                v(j)=cost(seed(j),c);
            end
            m(c)=min(v);
            v=[];
        else
            m(c)=-1;
        end
    end
    [~,idx]=max(m);
    seed(i)=idx;
    m=[];
end

seed(1)=[];

end

