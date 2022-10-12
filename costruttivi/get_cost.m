function [distance] = get_cost(x,y)
%funzione che costruisce la matrice di costo date le distanze
if length(x)~=length(y)
    disp('Errore nelle dimensioni')
end
n=length(y);
distance = zeros(n, n);
for i = 1:n
    for j = 1:n
       distance(i, j) = round(sqrt(((y(i) - y(j)).^2) + ((x(i) - x(j)).^2)));
    end
end

