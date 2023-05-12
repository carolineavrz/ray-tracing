classdef rayon
    %RAYONS chaque objet de cette classe représente un rayon qui part d'un
    %émetteur, fait un certain trajet (il peut prendre plusieurs directions
    %au cours de ce trajet) et termine sa trajectoire en un récepteur

    properties(Constant)
        eps_0=physconst("Permitivity");
        mu_0=physconst("Permeability");
        Z_0=sqrt(mu_0/eps_0);
    end
    
    properties
        frequence 
        emetteur 
        recepteur 
        usine 
        mode_propagation 
        direction  %cette direction est calculée dans une fonction de cette classe mais selon chat gpt on peut faire ça lol
        distance_tot 
        coefficient_eff  %c'est un produit des coefficients sur le trajet du rayon
    end
    
    methods
        function obj=rayon(emetteur,recepteur,mode_propagation,direction,coefficients_comp)
            obj.frequence=frequence;
            obj.emetteur=emetteur;
            obj.recepteur=recepteur;
            obj.usine=usine;
            obj.mode_propagation=mode_propagation;
            obj.direction=direction;
            obj.coefficient_eff=coefficient_eff;
        end

        function mode_propagation=calc_mode(emetteur,recepteur,mur)
            %fonction qui à partir de l'émetteur (source courante du rayon
            %donc pas forcément l'émetteur physique du début), du récepteur
            %final et des listes de murs en gros détermine si à la
            %rencontre d'un mur ce sera le rayon transmis ou réfléchi qui
            %ira vers la source (en gros si émetteur et récepteur sont du
            %même côté du mur ce sera le rayon réflechi qui ira vers la
            %source, sinon ce sera le transmis)

            %bref: la fonction retourne R ou T selon qu'émetteur et
            %récepteur soient du même côté du mur ou non
            d_mur=[mur.position(1,1)-mur.position(2,1),mur.position(1,2)-mur.position(2,2)];
            n_mur=[d_mur(2),-d_mur(1)];
            sign_em=sign(dot(emetteur.position,n_mur));
            sign_re=sign(dot(recepteur.position,n_mur));

            switch sign_em==sign_re
                %assigne le str à l'attribut mode_propagation du rayon,
                %sera utilisé pour le calcul de la direction
                case false
                    mode_propagation="T";
                case true 
                    mode_propagation="R";
            end

        end

        function direction=calc_dir(emetteur,recepteur,mur)
            %le but est de calculer la direction du rayon en fonction des
            %positions du récepteur et émetteur (ou du pseudo émetteur si on 
            % en cas d'image ou d'image d'une image pour une double réflexion
            % et du mode de
            %propagation (en cas de réflexion il faudra d'abord calculer
            %l'antenne image)
            mode_propagation=calc_mode(rayon.emetteur,rayon.recepteur,mur);

            switch rayon.mode_propagation
                case "T"
                    direction=[recepteur.position(1)-emetteur.position(1),recepteur.position(2)-emetteur.position(2)];
                case "R"
                    emetteur.position=calc_image(emetteur.position,mur);
                    direction=[recepteur.position(1)-emetteur.position(1),recepteur.position(2)-emetteur.position(2)];
            end
            distance=norm(direction);
            rayon.distance_tot=rayon.distance_tot + distance;
        end
        
        function coefficients = calc_coefficients(direction, mur, mode_propagation)
           %à partir de la direction on calcule l'angle d'incidence et on
           %met le tout dans la formule du gamma du cours
           %attention à bien implémenter la récursivité de manière à ce que
           %le gamma renvoyé soit le gamma final (produit des gamma de
           %chacune des réflexions)

           %relatif à la direction du rayon
           direction=calc_dir(rayon.emetteur,rayon.recepteur,mode_propagation);

           d=direction;
           d_mur=[mur(1,1)-mur(2,1),mur(1,2)-mur(2,2)];
           cos_in=d(2)/norm(d);
           sin_in=sqrt(1-cos_in^2);
           sin_tr=sqrt(1/mur.perm_rel)*sin_in;
           cos_tr=sqrt(1-sin_tr^2);
           s=norm(d_mur)/cos_tr;

           %constantes physiques
           
           eps_tilde=mur.perm_rel*direction.eps_0-1i*mur.conduct/rayon.frequence;
           Z_mur=sqrt(direction.mu_0/eps_tilde);
           gamma_min=1j*rayon.frequence*sqrt(direction.mu_0*eps_tilde);
           alpha=real(gamma_min);
           beta=imag(gamma_min);

           
           %calcul de gamma

           gamma_perp=(Z_mur*cos_in-rayon.Z_0*cos_tr)/(Z_mur*cos_in-rayon.Z_0*cos_tr);

           coefficients(1)=gamma_perp-(1-gamma_perp^2)*(gamma_perp*exp(-2*gamma_min*s)*exp(1j*beta*2*s*sin_tr*sin_in))/(1-(gamma_perp^2)*exp(-2*gamma_min*s)*exp(1j*beta*2*s*sin_tr*sin_in));
           
           %calcul de T
           coefficients(2)=(1-gamma_perp^2)*exp(-gamma_min*s)/(1-gamma_perp^2*exp(-2*gamma_min*s)*exp(1j*beta*2*s*sin_tr*sin_in));
           
           %ajout du coefficient "effectif" dans une liste
           switch mode_propagation
               case "R"
                   rayon.coefficient_eff=rayon.coefficient_eff*coefficients(1);
               case "T"
                   rayon.coefficient_eff=rayon.coefficient_eff*coefficients(2);
           end
        end
    end
end

