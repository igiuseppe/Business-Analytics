function [yes] = in_opt_route(opt,val)
%funzione che controlla se la route val è nel vettore con le route ottimali
%opt
b=0;

for i=1:length(opt)
    if in_route(opt(i),val)
        b=b+1;
    end
end

yes=b~=0;

end

