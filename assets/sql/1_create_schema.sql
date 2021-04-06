CREATE TABLE encounter
(
    id            INTEGER PRIMARY KEY,
    ownSeed       TEXT,
    encounterSeed TEXT,
    latitude      FLOAT,
    longitude     FLOAT,
    date          INT,
    distance      FLOAT,
    transmitted   INT
);