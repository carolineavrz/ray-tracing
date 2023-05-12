classdef emetteur
    %EMETTEUR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        position 
        puissance 
        gain 
        sorte 
        image 
    end
    
    methods
        %function obj=emetteur(position,puissance,gain,sorte,image)
            %obj.position=position;
            %obj.puissance=puissance;
            %obj.gain=gain;
            %obj.sorte=sorte;
            %obj.image=image;
        %end

        %function construire(position)
            %plot (à voir comment faire avec l'appdesigner)
        %end
        
        function image=calc_image(position,mur)
           image=reflect(position,mur(1),mur(2));
        end
    end
end

