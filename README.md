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

## requêtes SQL

### requêtes de consultation

- lister toutes les adresses d'une commune donnée, triées par voie

```sql 
SELECT * FROM adress WHERE id_town = ? ORDER BY id_lane
```