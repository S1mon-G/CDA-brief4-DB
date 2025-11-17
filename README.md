# CDA-brief4-DB

# ETAPES DE VALIDATION

## découverte de la donnée
- télécharger un fichier CSV au choix depuis https://adresse.data.gouv.fr/data/ban/adresses/latest/csv/
- créer un dictionnaire de données.
![dictionnaire de données](img/dictionnaire-de-donnees.png)

- importer le fichier dans une table brute
**établir la connection postgreSQL/DBeaver**
- ouvrir DBeaver
- se connecter à la base de données PostgreSQL souhaitée
**importer les données**
- dans l'arborescence de la base faire un **clic droit** sur `public` et sélectionner **import data**
- choisir le type de source `CSV`
- sélectionner le fichier téléchargé

⚠️ les données en français sont souvent séparées par un `;` plutôt qu'une `,` penser à modifier le séparateur dans DBeaver avant de lancer l'import.

**identifier les entités et les relations potentielles**
- créer un fichier de règles de gestion pour découper les données en entité et définir des relations
![règles de gestion](img/regles-de-gestion.png)
- une fois les entités repérées et les relations établies, passer à la modélisation de la base.
## modélisation MERISE
- créer un **MCD** reprenant les entités définies et leurs champs ainsi que les relations avec cardinalités
![MCD](img/MCD.png)
- créer un **MLD** formalisant les relations entre les tables par le biais de clé étrangères
![MLD](img/MLD.png)
- créer un **MPD** en indiquant chaque type de données
![MPD](img/MPD.png)
## mise en place de la base
-créer les tables issues du MPD
### ⚠️ commencer par les tables indépendantes de toute relation pour éviter les erreurs
**pour chaque table crées sur le MPD**
```sql
CREATE TABLE nom_de_la_table(
    colonne1 type de donnée contrainte, 
    colonne2 type de donnée contrainte,
    ...
);
````
le cas échéant, ajouter un **constraint** pour les clés étrangères

``constraint fk_nom_de_la_clé_étrangère 
foreign key (nom_de_la_clé_étrangère) 
references table_de_référence(identifiant)
 ``
 - [script de création des tables](./queries/table_creation.sql)

 - Créer un jeu d’échantillon depuis le fichier d’adresse complet pour faire les tests de requêtes.

 ``sql
CREATE TABLE adress_sample as
SELECT * FROM adresses LIMIT X
 ``

- créer un **script SQL** pour insérer les données dans les tables crées depuis le jeu de données.

- [script d'insertion de données](./queries/data_insert_script.sql)
## requêtes SQL

### requêtes de consultation
***exemple***

```sql
SELECT a.*, t.postcode, t.name
FROM adress a
    JOIN town t ON a.id_town = t.id
WHERE
    t.postcode IS NULL
    AND t.name IS NOT NULL;
```

***toutes les requêtes***
- [script de consultation des données](./queries/query_consult.sql)

### requêtes d’insertion / mise à jour / suppression
***exemple***

```sql
INSERT INTO
    town (
        name,
        postcode,
        insee_code,
        forwarding
    )
VALUES (
        'Gotham City',
        '33666',
        '66633',
        'GOTHAM CITY'
    );
 ```   

***toutes les requêtes***

- [script d'édition](./queries/query_add_update_delete.sql)

### requêtes de détection de problèmes et qualité des données

***exemple***
```sql
SELECT id_town, COUNT(*) AS nb_repetition
FROM adress a
GROUP BY
    id_town
HAVING
    COUNT(*) > 10000;
```
***toutes les requêtes***
- [script détection et qualité](./queries/query_quality.sql)


### requêtes d’agrégation et analyse

***exemple***
```sql
SELECT id_town, COUNT(*) AS nb_repetition
FROM adress a
GROUP BY
    id_town
ORDER BY nb_repetition DESC
LIMIT 10;
```
***toutes les requêtes***
- [script d'analyse et d'agrégation](./queries/query_analysis.sql)

## NOTES DE BRIEF

- ***Découverte de la donnée*** 
réalisé en entier
- ***Modélisation Merise***
réalisé en entier
- ***Mise en place de la base***
réalisé en entier
- ***Requêtes SQL à produire***
réalisé jusqu'au 4.5 deuxième point où je me suis arrêté pour jouer un peu ave docker-compose
- ***optimisation et analyse***
non réalisé


***docker compose***
## Création du fichier docker-compose

***Récupération de l'image officielle postgreSQL***

- sur https://hub.docker.com/_/postgres section ***how to use this image***

- création du fichier [docker-compose.yml](./docker-compose.yml)
```
services :
  db:
    image: postgres
    environment: 
      POSTGRES_PASSWORD : bddBrief
    ports:
    - "5433:5432"
    volumes: 
    - db_data:/var/lib/postgresql

volumes:
  db_data:
```
***⚠️ ici, le port 5432 de base était déjà utilisé, port local changé en 5433 afin de pouvoir démarrer le container***

-  transfert de la table d'échantillon créée de la première base pour l'utiliser dans la nouvelle créée via docker-compose.

- test des scripts sql 

- adaptation du dernier script d'import de données pour réduire le batch suite à une erreur 
```SQL Error [57P03]: FATAL: the database system is in recovery mode```
