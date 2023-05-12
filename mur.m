classdef mur
    %MUR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        position %vecteur à deux composantes, chacune un vecteur à deux composantes (des points quoi)
        perm_rel 
        conduct 
        epaisseur 
        orientation 
    end
    
    methods
        %function obj=mur(position,perm_rel,conduct,epaisseur,orientation)
            %obj.position=position;
            %obj.perm_rel=perm_rel;
            %obj.conduct=conduct;
            %obj.epaisseur=epaisseur;
            %obj.orientation=orientation;
        %end

        function orientation=orienter(mur)
             orientation=[mur.position(1,1)-mur.position(2,1),mur.position(1,2)-mur.position(2,2)];
        end
    end
end

