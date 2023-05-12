classdef usine
    %USINE classe qui a les listes de tous les éléments de l'usine (murs,
    %émetteurs récepteurs) et qui va avoir une fonction qui va les tracer
    %   l'idée de cette classe est de tout regrouper, en appelant la
    %   fonction construire() de l'usine dans le main on va appeler les
    %   fonctions construire() de tous les éléments
    
    properties
        murs 
        emetteurs 
        recepteurs 
    end
    
    methods
        function construire(murs,emetteurs,recepteurs)
            %fonction qui permet de tracer les composants de l'usine (ne
            %renvoie rien)

            figure;
            plan=axes;

            for m= 1:numel(murs)
                plot(plan,murs(m).position(1),murs(m).position(2),'r')
            end


            parfor n=1:numel(emetteurs)
                plot(plan,emetteurs(n).position,'b')
            end

            parfor p=1:numel(recepteurs)
                plot(plan,recepteurs(p).position,'g')
            end
        end
   
    end
end

