insert into lieu_dit (name) values ('Nottinghamshire');

insert into
    old_nomenclature (old_insee, old_town_name)
values ('66633', 'Gotham Harbour');

insert into
    lane (
        name,
        afnor_name,
        source_lane_name
    )
values (
        'Crime Alley',
        'CRIME ALLEY',
        'commune'
    );

insert into
    coordinates (
        x,
        y,
        lon,
        lat,
        source_position
    )
values (
        8237642.0,
        4970351.0,
        -74.0060,
        40.7128,
        'commune'
    );

insert into
    town (
        name,
        postcode,
        insee_code,
        forwarding
    )
values (
        'Gotham City',
        '33666',
        '66633',
        'GOTHAM CITY'
    );

insert into
    adress (
        adress_id,
        fantoir_id,
        number,
        rep,
        position_type,
        cad_plot,
        certification
    )
values (
        '33666_BatMAn_13012',
        '33666_1312',
        404,
        'bis',
        'entrance',
        '33666000FT0095',
        1
    );

update lane l set name = 'iceberg lounge' where l.id = 42518;

delete from adress where fantoir_id = '';