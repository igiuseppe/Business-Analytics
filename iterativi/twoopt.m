function tourneighborhood = twoopt(tour) % tor è un array di numer i che si associano univocamente alle edges 
    tour_expanded = tourexpander(tour);
    count = 1:length(tour_expanded);
    [p,q] = meshgrid(count, count);
    A = [p(:) q(:)]; %coppie nel formato numero per edge

%sottraggo le coppie adiacienti
    A(checkadjacence(tour_expanded(A(:,1),:),tour_expanded(A(:,2),:)) , :) = [];
    %C contiene i nuovi tour che formano la  neighrborhood
    C = zeros(length(A),length(tour));
    for i = 1:length(A)
        %seleziono i punti da scambiare
        k_1 = tour_expanded(A(i,1),1);
        l_1 = tour_expanded(A(i,1),2);
        k_2 = tour_expanded(A(i,2),1);
        l_2 = tour_expanded(A(i,2),2);
        %seleziono solo gli scambi legali. Le altre coppie generano righe
        %con soli zeri, che rimuoviamo dopo
    if( k_1 ~= l_2  && k_2 ~= l_1 && l_1 ~=l_2 && k_1 ~= k_2 && k_1 ~= 1 &&  k_2 ~= 1 && l_1 ~= 1 && l_2 ~= 1)
        C(i,:)=tour;
        %troviamo il primo vertice in una direzione
        vertex1k=find(C(i,:) == k_1 );
        vertex1l=find(C(i,:) == l_1 );
        vertex1= min(vertex1k,vertex1l);
        %second vertice
        vertex2k = find( C(i,:) == k_2  );
        vertex2l=find(C(i,:) == l_2 );
        vertex2= min(vertex2k,vertex2l);
        
        first_vertex=min(vertex1,vertex2);
        second_vertex=max(vertex1,vertex2);
        %inversione dei nodi (cambia anche la topologia, non solo un
        %eventuale direzionamento)
        C(i,first_vertex+1:second_vertex)=fliplr(C(i,first_vertex+1:second_vertex));
    end

    end
%rimuoviamo coppie in cui non abbiamo scambiato
       C=C(any(C~=0,2 ),:);
       
       tourneighborhood = C;
end 


function areadjacent = checkadjacence(edge1,edge2)
    %genero un vettore di booleani per individuare le edge contigue
    areadjacent = not(logical(edge1(:,1)-edge2(:,2))) | not( logical(edge1(:,2)-edge1(:,1)));

end


