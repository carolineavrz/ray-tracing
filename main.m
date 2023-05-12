%résolution exo 8.1

%génération des murs
murs=[];

murA=mur();
murA.position=[[0,0];[0,80]];
murA.perm_rel=4.8;
murA.conduct=0.018;
murA.epaisseur=0.15;
murs=[murs;murA];

murB=mur();
murB.position=[[0,80];[80,80]];
murB.perm_rel=4.8;
murB.conduct=0.018;
murB.epaisseur=0.15;
murs=[murs;murB];

murC=mur();
murC.position=[[0,20];[80,20]];
murC.perm_rel=4.8;
murC.conduct=0.018;
murC.epaisseur=0.15;
murs=[murs;murC];


%génération de l'émetteur et récepteur
emetteurs=[];
emetteurTX=emetteur();
emetteurTX.position=[32,10];
emetteurs=[emetteurs;emetteurTX];

recepteurs=[];
recepteurRX=recepteur();
recepteurRX.position=[47,65];
recepteurs=[recepteurs;recepteurRX];


%génération de l'usine

usinetest=usine();
usinetest.murs=murs;
usinetest.recepteurs=recepteurs;
usinetest.emetteurs=emetteurs;
for m=1:numel(murs)
disp(murs(m).position);
end
disp(emetteurs);
disp(recepteurs);
disp(usinetest);
construire(murs,emetteurs,recepteurs);

%génération des rayons
%on sait qu'il y aura 5 trajectoires mais maybe déjà automatiser un peu ça
rayon1=rayon();
rayon1.frequence=2*pi*868.3*e6;
rayon1.emetteur=emetteurTX;
rayon1.recepteur=recepteurRX;




