CREATE TABLE adress_sample AS SELECT * FROM adresses LIMIT 20000;

CREATE TABLE lieu_dit (
    id SERIAL PRIMARY KEY UNIQUE,
    name VARCHAR(155)
);

CREATE TABLE coordinates (
    id SERIAL PRIMARY KEY UNIQUE,
    x FLOAT,
    y FLOAT,
    lon FLOAT,
    lat FLOAT,
    source_position VARCHAR(8)
);

CREATE TABLE old_nomenclature (
    id SERIAL PRIMARY KEY UNIQUE not null,
    old_insee VARCHAR,
    old_town_name VARCHAR(155)
);

CREATE TABLE lane (
    id SERIAL PRIMARY KEY UNIQUE not null,
    name VARCHAR(155),
    afnor_name VARCHAR(50),
    source_lane_name VARCHAR(8)
);

CREATE TABLE town (
    id SERIAL PRIMARY KEY UNIQUE not null,
    name VARCHAR(155),
    postcode INT,
    insee_code INT,
    forwarding VARCHAR(50),
    id_old_nomenclature INT,
    id_lieu_dit INT,
    constraINT fk_old_nomenclature foreign key (id_old_nomenclature) references old_nomenclature (id),
    constraINT fk_lieu_dit foreign key (id_lieu_dit) references lieu_dit (id)
);

CREATE TABLE adress (
    id SERIAL PRIMARY KEY UNIQUE not null,
    adress_id VARCHAR(50),
    fantoir_id VARCHAR(50),
    number INT,
    rep VARCHAR(50),
    position_type VARCHAR(50),
    cad_plot TEXT,
    certification INT,
    id_town INT,
    id_lane INT,
    id_coordinates INT,
    constraINT fk_id_town foreign key (id_town) references town (id),
    constraINT fk_id_lane foreign key (id_lane) references lane (id),
    constraINT fk_id_coordinates foreign key (id_coordinates) references coordinates (id)
);