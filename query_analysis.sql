select (
        select avg(cnt)
        from (
                select id_town, count(*) as cnt
                from adress
                group by
                    id_town
            ) as par_commune
    ) as avg_adress_par_commune,
    (
        select avg(cnt)
        from (
                select id_lane, count(*) as cnt
                from adress
                group by
                    id_lane
            ) as par_voie
    ) as avg_adresses_par_voie;

SELECT id_town, COUNT(*) AS nb_repetition
FROM adress a
GROUP BY
    id_town
ORDER BY nb_repetition DESC
LIMIT 10;