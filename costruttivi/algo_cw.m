function [opt,total_cost,vehicles] = algo_cw(capacity,cost,demand)
%algoritmo Clarke–Wright il cui output è:
%opt: un array contenente le route ottimali
%total_cost: il costo totale delle route in opt

n=size(cost);
n=n(1);

savings=get_savings(n,cost,demand,capacity);

%creazione route iniziali, una per ogni customer
for i=2:n
    routes(i-1)=route(i);
end

%creazione array con route ottimali
opt=route(1);
opt(1)=[];

%creazione array con route da eliminare 
clear=[];

while (length(routes)>=1)
    %stop se non ci sono più route da unire
    for i=1:length(routes)
        if check_budget_idx(i,routes,capacity,demand)
                opt(length(opt)+1)=routes(i);
                clear(length(clear)+1)=i;
                %aggiungo a opt le route che non posso più migliorare per il
                %vincolo di capacità
        end
    end
    if length(clear)>=1
        routes(clear)=[];
        clear=[];
        %elimino da routes le route già ottimizzate
    end

    k=0;
    while(k==0)
        [v,i] = max(savings);
        [~,j]=max(v);
        i=i(j);
        savings(i,j)=0;
        savings(j,i)=0;
        m_i=0;
        m_j=0;
        %cerco il massimo saving e vedo se esiste un possibile merge tra
        %due route che corrisponda a tale saving
        for l=1:length(routes)
            if in_route(routes(l),i)
                m_i=l;
            end
            if in_route(routes(l),j)
                m_j=l;
            end
        end
        if m_i==m_j || m_i==0 || m_j==0
            break
        end
        candidate=merge_routes(routes(m_i),routes(m_j));
        if get_budget(candidate,demand)<=capacity
            k=1;
            if m_i<m_j
                routes(m_j)=[];
                routes(m_i)=[];
            else
                routes(m_i)=[];
                routes(m_j)=[];
            end
            %elimino singole routes e creo nuova route data dal merge delle
            %due
            routes(length(routes)+1)=candidate;
        end
        
    end
end

%calcolo costo totale
for i=1:length(opt)
    c(i)=get_cost(opt(i),cost);
end
total_cost=sum(c);

vehicles=length(opt);
