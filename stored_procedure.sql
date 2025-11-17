INSERT INTO
    adress a (
        adress_id,
        fantoir_id,
        number,
        rep,
        position_type,
        cad_plot,
        certification
    )
VALUES (
        '33666_BatMAn_NEW',
        '33666_1312',
        404,
        'bis',
        'entrance',
        '33666000FT0095',
        1
    ) ON CONFLICT (id) DO
UPDATE
SET
    adress_id = EXCLUDED.adress_id,
    fantoir_id = EXCLUDED.fantoir_id,
    number = EXCLUDED.number,
    rep = EXCLUDED.rep,
    position_type = EXCLUDED.position_type,
    cad_plot = EXCLUDED.cad_plot,
    certification = EXCLUDED.certification;