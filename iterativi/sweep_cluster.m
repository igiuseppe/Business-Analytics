function clustered = sweep_cluster(customers,capacities,angle_step,angle_sensitivity,radii_vector) %the deposit is always in (0,0). length of "capacities" allows us to deduce number of carriers
residual_capacities = capacities;
m = length(capacities);
clustered = zeros(1,5);
angle=0;
nrounds=10;
rounds=0;
angles=zeros(length(customers));
angles = abs(atan(customers(:,2)./customers(:,1)));

%assegno i quadranti al riusltato dell'arctan
angles(customers(:,1)<0 & customers(:,2)>0) =  pi/2-angles(customers(:,1)<0 & customers(:,2)>0)+pi/2;
angles(customers(:,1)<0 & customers(:,2)<=0) = (angles(customers(:,1)<0 & customers(:,2)<=0))+pi;
angles(customers(:,1)>=0 & customers(:,2)<=0) = pi/2-(angles(customers(:,1)>=0 & customers(:,2)<=0))+1.5*pi;

i=1;
%ciclo sui veicoli
while i <= m
 flag=0;    
%ciclo sull'update degli angoli
    while true

        for j = 2:length(customers) % non consideriamo il deposito ovviamente
%etrano solo i nodi che soddisfano la distanza minima dalla semi-retta
            if  ((sin(angles(j)-rem(angle,2*pi)))*(radii_vector(j))-angle_sensitivity)<=0 && (angles(j)-rem(angle,2*pi))<pi/2 && dot([radii_vector(j)*cos(angle), radii_vector(j)*sin(angle)],[customers(j,1),customers(j,2)])>=0  %sweep solo sulla parte positiva della retta

                %usiamo le coordinate per markare i nodi già inseriti, se
                %li inseriamo gli diamo coordinate  0
                if(customers(j,3)<=residual_capacities(i) && (customers(j,1)~= 0 || customers(j,2)~= 0))

                    clustered = [clustered;[customers(j,1:4),i]]; %appendiamo a clustered di nuovo la posizione macon accodato anche il numero del cluster di appartenenza
                    residual_capacities(i)= residual_capacities(i)-customers(j,3);
                    customers(j,1)=0;
                    customers(j,2)=0;



                end
                

%condizioni per la rottura del loop (se tutti i noid sono presi o se il
%corrente veicolo incontra un nodo con capacità più grande di quella
%disponibile)
                if all(~logical(customers(:,1))) && all(~logical(customers(:,2))) || customers(j,3)>residual_capacities(i)

                    % permette nrounds giri ulteriori
                    if rounds~=nrounds && i == m && customers(j,3)>residual_capacities(i)
                    i=1;
                    rounds=rounds+1;
                    
                    end
           
  
                    flag=1;
                    break;
                  
                end


            end
                if flag ==1 && (rounds==nrounds || max(residual_capacities(i))<customers(j,3))
                    break;
                end   
        end
        angle = angle + angle_step;
        
        if flag ==1
           break;
        end   
    
    end 
    i=i+1;
end
end