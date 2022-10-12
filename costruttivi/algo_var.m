function [opt,total_cost,unf] = algo_var(cost,vehicles,capacity,demand)
%variazione del c-w parallela che utilizza il criterio dei savings,
%l'output è:
%opt: un array contenente le route ottimali
%total_cost: il costo totale delle route in opt
%unf: il numero di nodi eventualmente non soddisfatti

n=size(cost);
n=n(1);

savings=get_savings(n,cost,demand,capacity);

seed=get_seed(cost,vehicles);

%inizializzo route ottimali, una per ogni seed
for i=1:vehicles
    opt(i)=route(seed(i));
end


routes=[];

%creo array con route usando come seed tutti gli altri nodi
for i=2:n
    if ~ismember(i,seed)
        routes(length(routes)+1)=i;
    end
end

%modifico matrice dei savings
savings=mod_sav(n,opt,savings);

for i=1:vehicles
    while(~check_budget_route(opt(i),routes,capacity,demand))
        %stop quando la route i non è più migliorabile
        r=opt(i).nodes;
        head=r(1);
        tail=r(length((r)));
        %definisco nodo iniziale e finale della route
        if head~=tail
            [s_h,i_h]=max(savings(head,:));
            [s_t,i_t]=max(savings(tail,:));
            for j=1:length(routes)
                if routes(j)==i_h
                    m_h=j;
                end
                if routes(j)==i_t
                    m_t=j;
                end
            end
            %trovo valore massimi savings rispetto a nodi head e tail e
            %route corrispondenti a tale savings
            if s_h>s_t
                %caso in cui il massimo saving è relativo al nodo iniziale
                candidate=add_node(opt(i),routes(m_h),true);
                %unisco route i con quella corrispondente al saving trovato
                savings(head,i_h)=0;
                savings(i_h,head)=0;
                %pongo saving in questione a zero per evitare che
                %l'algoritmo vada a finire nuovamente su questa
                %combinazione
                if get_budget(candidate,demand)<=capacity
                    %se la route candidata rispetta i criteri di capacità
                    %la sostituisco alla corrispondente e modifico la
                    %matrice savings
                    opt(i)=candidate;
                    routes(m_h)=[];
                    savings=mod_sav(n,opt,savings);
                    
                else
                    %altrimenti faccio stesso procedimento con nodo coda
                    candidate=add_node(opt(i),routes(m_t),false);
                    savings(tail,i_t)=0;
                    savings(i_t,tail)=0;
                    if get_budget(candidate,demand)<=capacity
                        opt(i)=candidate;
                        routes(m_t)=[];
                        savings=mod_sav(n,opt,savings);
                    end
                end
            else
                %s_t>s_h
                %stesso procedimento nel caso in cui il massimo saving è relativo al nodo finale
                candidate=add_node(opt(i),routes(m_t),false);
                savings(tail,i_t)=0;
                savings(i_t,tail)=0;
                if get_budget(candidate,demand)<=capacity
                    opt(i)=candidate;
                    routes(m_t)=[];
                    savings=mod_sav(n,opt,savings);
                else
                    candidate=add_node(opt(i),routes(m_h),true);
                    savings(head,i_h)=0;
                    savings(i_h,head)=0;
                    if get_budget(candidate,demand)<=capacity
                        opt(i)=candidate;
                        routes(m_h)=[];
                        savings=mod_sav(n,opt,savings);
                    end
                end
            end
        else
            %head==tail
            %se nodo iniziale e finale coincidono ho route degenere con solo
            %seed-> decido di aggiungere nodo a sx
   
            [~,i_h]=max(savings(head,:));
            m_h=0;
            for j=1:length(routes)
                if routes(j)==i_h
                    m_h=j;
                end
            end
            candidate=add_node(opt(i),routes(m_h),true);
            savings(head,i_h)=0;
            savings(i_h,head)=0;
            if get_budget(candidate,demand)<=capacity
                opt(i)=candidate;
                routes(m_h)=[];
                savings=mod_sav(n,opt,savings);
            end
        end
    end
end

for i=1:vehicles
    c(i)=get_cost(opt(i),cost);
end
%calcolo costo totale

total_cost=sum(c);

%calcolo numero di nodi non soddisfatti
unf=length(routes);

end


