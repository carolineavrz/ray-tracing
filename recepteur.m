classdef recepteur
    %RECEPTEUR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        position 
    end
    
    methods
        %là c'est n'importe quoi il faut que je fasse
        %function obj=recepteur(position)
            %obj.position=position;
        %end 
        function champ_E = calc_champ(rayon)
            %expression sans les coeff
            champ_E=sqrt(60*emetteur.puissance*emetteur.gain)*exp(-1j*rayon.distance_tot)/rayon.distance_tot;
            
            %boucle qui multiplie l'expression du haut par tous les coeff
            %d'une liste (qu'il faudra créer avec tous les coeff calculés
            %dans rayons)
            champ_E=rayon.coefficient_eff*champ_E;
        end
    end
end

