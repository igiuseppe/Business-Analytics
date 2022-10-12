function customers=customers_generator(coordinates, demand)
%creo la amtrice customers in modo che abbia tutte le informazioni
%necessarie per fare lo sweep
customers = zeros(length(coordinates),4);
customers(:,1:2) = coordinates- coordinates(1,:); % shift coordinate mettendo a zero il deposito 
customers(:,3) =  demand;
customers(:,4) = 1:length(customers); % numero associato al customer, ora il deposito è 1
end


