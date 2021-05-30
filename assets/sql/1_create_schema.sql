CREATE TABLE province
(
    id           INTEGER PRIMARY KEY,
    provinceName TEXT,
    deleted      INT
);

CREATE TABLE user
(
    id         INTEGER PRIMARY KEY,
    provinceId INT,
    uuid       TEXT,
    date       INT,
    deleted    INT,
    FOREIGN KEY (provinceId) REFERENCES province (id)
);

CREATE TABLE encounter_seed
(
    id       INTEGER PRIMARY KEY,
    userId   INTEGER,
    seedUuid TEXT,
    date     INT,
    deleted  INT,
    FOREIGN KEY (userId) REFERENCES user (id)
);

CREATE TABLE encounter
(
    id                INTEGER PRIMARY KEY,
    ownSeedId         INTEGER,
    encounterSeedUuid TEXT,
    latitude          FLOAT,
    longitude         FLOAT,
    date              INT,
    distance          FLOAT,
    duration          INT,
    transmitted       INT,
    FOREIGN KEY (ownSeedId) REFERENCES encounter_seed (id)
);

CREATE TABLE private_notification
(
    id              INTEGER PRIMARY KEY,
    userId          INTEGER,
    otp_value       TEXT,
    diagnostic_date INT,
    submitted_date  INT,
    FOREIGN KEY (userId) REFERENCES user (id)
);


CREATE TABLE risk_encounter
(
    id                INTEGER PRIMARY KEY,
    riskSeedUuid      TEXT,
    encounterSeedUuid TEXT,
    latitude          FLOAT,
    longitude         FLOAT,
    date              INT,
    deleted           INT
);

CREATE TABLE evolution
(
    id         INTEGER PRIMARY KEY,
    totalCases INT,
    date       INT,
    deleted    INT
);

CREATE TABLE evolution_province
(
    id         INTEGER PRIMARY KEY,
    provinceId INT,
    totalCases INT,
    date       INT,
    deleted    INT,
    FOREIGN KEY (provinceId) REFERENCES province (id)
);