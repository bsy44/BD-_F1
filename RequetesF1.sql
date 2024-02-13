/*Les requêtes SQL pour le script F1.

Facile : 

Retrouvez le nom et prénom du directeur de l'écurie Ferrari (1 tuples):*/

Select directeurecurie.nom,directeurecurie.prenom from f1.directeurecurie INNER JOIN f1.ecurie using(idDirecteur)where ecurie.nom='Scuderia Ferrari';

-- Listez les pilotes de chaque ecurie;

Select ecurie.nom as "nom ecurie", pilote.nom as "nom pilote" from f1.pilote INNER JOIN f1.ecurie using(idecurie)group by ecurie.nom, pilote.nom;


/*Moyen :

Lister les classement de tout les pilotes au cours de leurs GrandPrix : */

Select pilote.nom,count(*) as "Nb de victoire" from f1.pilote INNER JOIN f1.performancePilote on pilote=numeroLicence where classement=1 group by pilote.nom;


-- Retrouvez le nom et prénom des pilotes gagnants des Grands Prix de 2022(4 tuples)

Select distinct pilote.nom,pilote.prenom from f1.pilote INNER JOIN f1.performancePilote on pilote=numeroLicence INNER JOIN f1.grandPrix on grandPrix=nomGP where grandPrix.edition='2022' and performancePilote.classement=1;


/*Difficile :

Trouver le nombre total de Titre Anglais gagné (titre gagné par des ecuries Anglaise) et affichez ceux des autres écuries.*/

Select ecurie.nom,count(*) as "Nb de titre" from f1.pilote INNER JOIN f1.performancePilote on pilote=numeroLicence INNER JOIN f1.ecurie using (idEcurie) where classement=1 and pilote.nationalite='Royaume-Unis' group by ecurie.nom
UNION 
Select ecurie.nom,ecurie.nbrTitre
From f1.ecurie;
