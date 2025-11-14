insert into lieu_dit (name) select distinct nom_ld from adresses;

insert into
    lane (
        name,
        afnor_name,
        source_lane_name
    )
select distinct
    nom_voie,
    nom_afnor,
    source_nom_voie
from adresses
where
    nom_voie is not null;

insert into
    old_nomenclature (old_insee, old_town_name)
select distinct
    code_insee_ancienne_commune,
    nom_ancienne_commune
from adresses;

insert into
    town (
        name,
        postcode,
        insee_code,
        forwarding,
        id_lieu_dit,
        id_old_nomenclature
    )
SELECT
    a.nom_commune,
    a.code_postal,
    a.code_insee,
    a.libelle_acheminement,
    (
        SELECT ld.id
        FROM lieu_dit ld
        WHERE
            ld.name = a.nom_ld
        LIMIT 1
    ) AS id_lieu_dit,
    (
        SELECT onm.id
        FROM old_nomenclature onm
        WHERE
            onm.old_insee = a.code_insee_ancienne_commune
            AND onm.old_town_name = a.nom_ancienne_commune
        LIMIT 1
    ) AS id_old_nomenclature
FROM
    adress_sample a ON CONFLICT (insee_code) DO NOTHING;

insert into
    adress (
        adress_id,
        fantoir_id,
        number,
        rep,
        position_type,
        cad_plot,
        certification,
        id_town,
        id_lane,
        id_coordinates
    )
select a.id, a.id_fantoir, a.numero, a.rep, a.type_position, a.cad_parcelles, a.certification_commune, t.id, l.id, c.id
from
    adress_sample a
    inner join town t on a.code_insee = t.insee_code
    inner join lane l on a.nom_voie = l.name
    left join coordinates c on abs(a.lat - c.lat) < 0.000001
    and abs(a.lon - c.lon) < 0.000001;